require_dependency "unilevel_settlement/application_controller"

module UnilevelSettlement
  class PayoutRunsController < ApplicationController
    def index
      @payout_runs = PayoutRun.all
    end
  end
end
