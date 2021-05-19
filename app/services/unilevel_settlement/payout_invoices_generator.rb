module UnilevelSettlement
  class PayoutInvoicesGenerator
    def initialize(payout_run, excel_reader)
      @run = payout_run
      @excel_reader = excel_reader
      @users = find_all_users
    end

    def all_users_known?
      @users.none?(&:nil?)
    end

    def create_all_invoices
      @contracts = create_contracts
      return contracts_error_message if should_cancel_contacts?

      coordinate_records_and_invoice_creation
      return records_error_message if should_cancel_records?

      calculate_invoice_totals
      return invoices_error_message if should_cancel_invoices?
    end

    private

    def find_all_users
      @excel_reader.read_users.map do |consultant_number|
        find_user_by_consultant_number(consultant_number)
      end
    end

    # --- contracts creation ---

    def create_contracts
      contracts_data = @excel_reader.read_contracts
      contracts_data.map { |contract_data| create_contract(contract_data) }
    end

    def create_contract(data)
      Contract.create(
        provider: Provider.find_by_name(data[:provider]),
        user: find_user_by_consultant_number(data[:consultant_number]),
        contract_number: data[:contract_number],
        customer: data[:customer],
        product: data[:product],
        cancellation: data[:cancellation],
        rejected: data[:rejected],
        follow_up: data[:follow_up]
      )
    end

    def find_user_by_consultant_number(consultant_number)
      User.send("find_by_#{UnilevelSettlement.consultant_number}", consultant_number)
    end

    def should_cancel_contacts?
      !@contracts.all?(&:valid?)
    end

    def contracts_error_message
      invalid_contracts = @contracts.select(&:invalid?).map { |c| "`Vertragsnummer: #{c.contract_number}`" }
      { error: "Einige Verträge gibt es bereits. Die Abrechnung wurde abgebrochen und alle dazugehörigen Daten wurden
               gelöscht. Es handelt sich um folgende Verträge:\n#{invalid_contracts.join("\n")}" }
    end

    # --- records creation & invoice initiation ---

    def coordinate_records_and_invoice_creation
      @contracts.each do |contract|
        unilevel_users = collect_unilevel_users(contract)
        create_records_and_invoice(contract, unilevel_users[:owner], level: 0)
        create_records_and_invoice(contract, unilevel_users[:first_level_up], level: 1)
        create_records_and_invoice(contract, unilevel_users[:second_level_up], level: 2)
      end
    end

    def collect_unilevel_users(contract)
      owner = contract.user
      first_level_up = owner.send(UnilevelSettlement.consultant_sponsor)
      second_level_up = first_level_up.send(UnilevelSettlement.consultant_sponsor)
      { owner: owner, first_level_up: first_level_up, second_level_up: second_level_up }
    end

    def create_records_and_invoice(contract, user, level:)
      invoice = PayoutInvoice.find_or_create_by(user: user, run: @run)
      PayoutRecord.new(invoice: invoice, contract: contract, level: level)
                  .assign_attributes_from_contract
                  .save
    end

    def should_cancel_records?
      !@run.records.all?(&:valid?)
    end

    def records_error_message
      { error: 'Es gab Probleme bei der Erstellung der Rechnungsposten. Die Abrechnung wurde abgebrochen und alle dazugehörigen Daten wurden gelöscht.' }
    end

    # --- invoice amounts calculation ---

    def calculate_invoice_totals
      return unless @run.invoices.each(&:valid?) && @run.invoices.each(&:assign_invoice_totals)

      @run.invoices.each(&:attach_invoice_pdf) if UnilevelSettlement.should_create_invoice_pdf
    end

    def should_cancel_invoices?
      !@run.invoices.all?(&:totals_ok?)
    end

    def invoices_error_message
      { error: 'Es gab Probleme bei der Fertigstellung der Rechnungen. Die Abrechnung wurde abgebrochen und alle dazugehörigen Daten wurden gelöscht.' }
    end
  end
end
