require 'roo'

module UnilevelSettlement
  class PayoutRunExcelReader
    def initialize(payout_run)
      @payout_run = payout_run
      @parsed_excel = parse_excel
    end

    def read_providers
      providers = []
      @parsed_excel.map do |row|
        provider_name = row['Produkt'].split(' _ ')[0]
        providers << provider_name unless providers.include?(provider_name)
      end
      providers
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
  end
end
