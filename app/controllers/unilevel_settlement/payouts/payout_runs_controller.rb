require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class PayoutRunsController < ApplicationController
      def index
        @payout_runs = PayoutRun.all
      end

      def show; end

      def start
        @payout_run = PayoutRun.new
      end

      def create
        @payout_run = PayoutRun.new(payout_run_params)
        if @payout_run.save
          @payout_run.update(state: 'awaiting_providers')
          redirect_to flow_payouts_payout_run_path(@payout_run)
        else
          render :new
        end
      end

      def flow
        redirect_to set_next_path
      end

      def cancel
        @payout_run.cancel
        flash[:notice] = 'Die Abrechnung und alle dazugehörigen Daten wurden gelöscht'
        redirect_to payouts_payout_runs_path
      end

      private

      def payout_run_params
        params.require(:payout_run).permit(
          :payout_date,
          :performance_start_date,
          :performance_end_date,
          :payout_records_source_excel
        )
      end

      def set_next_path
        case @payout_run.state
        when 'awaiting_providers' then payouts_providers_path(@payout_run)
        when 'awaiting_payout_records' then create_all_payouts_payout_invoices_path
        when 'run_finished' then payouts_payout_run_path(@payout_run)
        else
          start_payouts_payout_runs_path
        end
      end
    end
  end
end
