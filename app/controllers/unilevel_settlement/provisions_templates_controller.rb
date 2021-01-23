require_dependency "unilevel_settlement/application_controller"

module UnilevelSettlement
  class ProvisionsTemplatesController < ApplicationController
    def index
      @templates = ProvisionsTemplate.all.sort_by(&:name.downcase)
    end

    def new
      @template = ProvisionsTemplate.new
    end
  end
end
