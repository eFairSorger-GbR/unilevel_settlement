require 'roo'

module UnilevelSettlement
  class PayoutRunExcelReader
    def initialize(payout_run)
      @payout_run = payout_run
      @parsed_excel = parse_excel
    end

    def read_providers
      providers = Hash.new(0)
      @parsed_excel.map do |row|
        provider_name = provider_product_row(row)[0]
        providers[provider_name] += 1
      end
      providers.keys
    end

    def read_users
      users = Hash.new(0)
      @parsed_excel.map do |row|
        user_consultant_number = row['VP-Nr.']
        users[user_consultant_number] += 1
      end
      users.keys
    end

    def read_contracts
      @parsed_excel.map do |row|
        {
          provider: provider_product_row(row)[0],
          user_consultant_number: row['VP-Nr.'],
          contract_number: row['Auftragsnr.'],
          customer: row['Kunde'],
          product: provider_product_row(row)[1],
          cancellation: row['Provision'].negative?,
          rejected: rejected?(row)
        }
      end
    end

    private

    # creating a workable object.
    # the excel shall have only one (!) sheet where all the contracts for that payout_run are included
    def parse_excel
      workbook = Roo::Spreadsheet.open(@payout_run.payout_records_source_excel_file_path, extension: :xlsx)
      worksheet = workbook.sheet(0)
      parsed_excel = worksheet.parse(headers: true)[1..-1]
      parsed_excel.reject { |row| row['Unter VP-Nr.'].nil? }
    end

    def provider_product_row(row)
      row['Produkt'].split(' _ ')
    end

    # it only counts as rejected, if "Buchungsgrund" is a cancellation (storno) and provision is 0.
    # if "Buchungsgrund" is cancellation (storno) and provision is negative, it really is a normal cancellation (storno)
    def rejected?(row)
      reason = row['Buchungsgrund'].include?('Storno aus Eigenumsatz')
      reason && row['Provision'].zero?
    end
  end
end
