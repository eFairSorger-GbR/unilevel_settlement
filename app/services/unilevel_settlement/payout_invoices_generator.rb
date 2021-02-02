module UnilevelSettlement
  class PayoutInvoicesGenerator
    def initialize(payout_run, excel_reader)
      @payout_run = payout_run
      @excel_reader = excel_reader
      @users = find_all_users
    end

    def all_users_known?
      @users.none?(&:nil?)
    end

    def create_all_invoices
      @contracts = create_contracts
    end

    private

    def find_all_users
      @excel_reader.read_users.map do |consultant_number|
        find_user_by_consultant_number(consultant_number)
      end
    end

    def create_contracts
      contracts_data = @excel_reader.read_contracts
      contracts = contracts_data.map { |contract_data| create_contract(contract_data) }
    end

    def create_contract(data)
      Contract.create(
        provider: Provider.find_by_name(data[:provider]),
        user: find_user_by_consultant_number(data[:consultant_number]),
        contract_number: data[:contract_number],
        customer: data[:customer],
        product: data[:product],
        cancellation: data[:cancellation],
        rejected: data[:rejected]
      )
    end

    def find_user_by_consultant_number(consultant_number)
      User.send("find_by_#{UnilevelSettlement.consultant_number}", consultant_number)
    end
    end
  end
end