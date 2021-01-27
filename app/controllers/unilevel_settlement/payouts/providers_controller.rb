require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class ProvidersController < ApplicationController
      def index
        # @providers = PayoutRunExcelReader.new(@payout_run).read_providers
      end
    end
  end
end
