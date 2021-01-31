require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class PayoutInvoicesController < ApplicationController
      def create_all
        excel_reader = PayoutRunExcelReader.new(@payout_run)
        generator = PayoutInvoicesGenerator.new(@payout_run, excel_reader)
        generator.all_users_known?
      end
    end
  end
end
