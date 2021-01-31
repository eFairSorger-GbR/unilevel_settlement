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

    private

    def find_all_users
      @excel_reader.read_users.map do |consultant_number|
        User.send("find_by_#{UnilevelSettlement.consultant_number}", consultant_number)
      end
    end
  end
end