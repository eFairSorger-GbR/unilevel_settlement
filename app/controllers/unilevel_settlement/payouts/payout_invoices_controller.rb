require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class PayoutInvoicesController < ApplicationController
      def create_all
        excel_reader = PayoutRunExcelReader.new(@payout_run)
        generator = PayoutInvoicesGenerator.new(@payout_run, excel_reader)

        if generator.all_users_known?
          invoices = generator.create_all_invoices
          stop_invoices_creation(invoices[:error]) if invoices.is_a?(Hash) && invoices.key?(:error)
        else
          error_message = 'Nicht alle Berater aus der Excel existieren in der Datenbank. Die Abrechnung wurde abgebrochen und alle dazugehörigen Daten wurden gelöscht.'
          stop_invoices_creation(error_message)
        end
      end

      private

      def stop_invoices_creation(error_message)
        PayoutRunCancelService.new(@payout_run).cancel
        flash[:error] = error_message
        redirect_to payouts_payout_runs_path
      end
    end
  end
end
