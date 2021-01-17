require_dependency "unilevel_settlement/application_controller"

module UnilevelSettlement
  class ProvidersController < ApplicationController
    before_action :find_provider, only: [:update]

    def index
      @providers = Provider.all.sort_by(&:name.downcase)
    end

    def new
      @provider = Provider.new
    end

    def create
      @provider = Provider.new(provider_params)

      if @provider.save
        redirect_to providers_path
      else
        render :new
      end
    end

    def update
      if @provider.update(provider_params)
        respond_to do |format|
          format.html { redirect_to providers_path(anchor: "anbieter-#{@provider.id}") }
          format.js
        end
      else
        respond_to do |format|
          format.html { render :index }
          format.js
        end
      end
    end

    private

    def provider_params
      params.require(:provider).permit(
        :name,
        :provisions,
        :inactive,
        :unilevel_settlement_provisions_template
      )
    end

    def find_provider
      @provider = Provider.find(params[:id])
    end
  end
end
