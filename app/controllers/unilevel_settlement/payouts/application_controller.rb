require_dependency 'unilevel_settlement/application_controller'

module UnilevelSettlement
  module Payouts
    class ApplicationController < UnilevelSettlement::ApplicationController
      before_action :assure_admin, :set_payout_run

      private

      def assure_admin
        return if current_user.admin?

        flash[:error] = 'Berechtigung erforderlich'
        redirect_to dashboard_users_path
      end

      def set_payout_run
        @payout_run = PayoutRun.find(params[:id]) if params[:id]
      end
    end
  end
end
