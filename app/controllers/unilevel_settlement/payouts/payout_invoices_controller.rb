require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class PayoutInvoicesController < ApplicationController
      def create_all
        excel_reader = PayoutRunExcelReader.new(@payout_run)
        generator = PayoutInvoicesGenerator.new(@payout_run, excel_reader)

        if generator.all_users_known?
          generator.create_all_invoices
        else
          @payout_run.cancel
          flash[:error] = 'Nicht alle Berater aus der Excel existieren in der Datenbank. Die Abrechnung wurde abgebrochen und alle dazugehörigen Daten wurden gelöscht.'
          redirect_to payouts_payout_runs_path
        end
      end
    end
  end
end
