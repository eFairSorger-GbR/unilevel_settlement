require_dependency "unilevel_settlement/application_controller"

module UnilevelSettlement
  class ProvisionsTemplatesController < ApplicationController
    before_action :find_template, only: %i[edit update destroy]

    def index
      @templates = ProvisionsTemplate.all.sort_by(&:name.downcase)
    end

    def new
      @template = ProvisionsTemplate.new
    end

    def create
      @template = ProvisionsTemplate.new(template_params)
      if @template.save
        redirect_to provisions_templates_path
      else
        render :new
      end
    end

    def edit; end

    def update
      if @template.update(template_params)
        redirect_to provisions_templates_path(anchor: "template-#{@template.id}")
      else
        render :edit
      end
    end

    def destroy
      if @template.destroy
        flash[:notice] = 'Das Template wurde erfolgreich gelöscht.'
        redirect_to provisions_templates_path
      else
        flash[:error] = 'Kann nicht gelöscht werden solange das Template Anbietern zugeordnet ist.'
        render :edit
      end
    end

    private

    def template_params
      params.require(:provisions_template).permit(
        :name,
        provisions_attributes: %i[id provision level follow_up _destroy]
      )
    end

    def find_template
      @template = ProvisionsTemplate.find(params[:id])
    end
  end
end
