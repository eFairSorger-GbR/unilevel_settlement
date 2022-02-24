require_dependency "unilevel_settlement/application_controller"

module UnilevelSettlement
  class ProvidersController < ApplicationController
    before_action :find_provider, only: %i[edit update]

    def index
      @providers = Provider.all.sort_by(&:name.downcase)
    end

    def new
      @provider = Provider.new
      @templates = ProvisionsTemplate.all.order(:name)
    end

    def create
      @provider = Provider.new(provider_params)
      if @provider.save
        redirect_to providers_path
      else
        @templates = ProvisionsTemplate.all.order(:name)
        render :new
      end
    end

    def edit
     @templates = ProvisionsTemplate.all.order(:name)
    end

    def update
      if @provider.update(provider_params)
        redirect_to providers_path(anchor: "anbieter-#{@provider.id}")
      else
        @templates = ProvisionsTemplate.all.order(:name)
        render :edit
      end
    end

    private

    def provider_params
      params.require(:provider).permit(
        :name,
        :provisions,
        :inactive,
        :unilevel_settlement_provisions_template_id,
        provisions_attributes: %i[id provision level follow_up _destroy]
      )
    end

    def find_provider
      @provider = Provider.find(params[:id])
    end
  end
end
