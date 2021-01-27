require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class PayoutRunsController < ApplicationController
      def index
        @payout_runs = PayoutRun.all
      end

      def start
        @payout_run = PayoutRun.new
      end

      def create
        @payout_run = PayoutRun.new(payout_run_params)
        if @payout_run.save
          redirect_to payouts_payout_runs_path
        else
          render :new
        end
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
    end
  end
end
