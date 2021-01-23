require_dependency "unilevel_settlement/application_controller"

module UnilevelSettlement
  class ProvisionsTemplatesController < ApplicationController
    def index
      @templates = ProvisionsTemplate.all.sort_by(&:name.downcase)
    end

    def new
      @template = ProvisionsTemplate.new
    end

    def create
      @template = ProvisionsTemplate.new(template_params)
      if @template.save
        redirect_to templates_path
      else
        render :new
      end
    end

    private

    def template_params
      params.require(:provisions_template).permit(
        :name,
        provisions_attributes: %i[id provision level _destroy]
      )
    end

    def find_template
      @template = ProvisionsTemplate.find(params[:id])
    end
  end
end
