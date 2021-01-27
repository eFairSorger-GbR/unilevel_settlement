require_dependency 'unilevel_settlement/application_controller'

module UnilevelSettlement
  module Payouts
    class ApplicationController < UnilevelSettlement::ApplicationController
      before_action :assure_admin

      private

      def assure_admin
        return if current_user.admin?

        flash[:error] = 'Berechtigung erforderlich'
        redirect_to dashboard_users_path
      end
    end
  end
end
