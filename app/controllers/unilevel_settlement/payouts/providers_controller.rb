require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class ProvidersController < ApplicationController
      before_action :set_templates

      def index
        @providers = PayoutRunExcelReader.new(@payout_run).read_providers
        @providers = @providers.map { |name| Provider.find_or_initialize_by(name: name) }
      end

      def create
        @provider = Provider.new(provider_params)
        @provider.save

        respond_to do |format|
          format.html { render :index }
          format.js { render :index, layout: false }
        end
      end

      def update
        @provider = Provider.find(params[:id])
        @provider.update(provider_params)

        respond_to do |format|
          format.html { render :index }
          format.js { render :index, layout: false }
        end
      end

      private

      def provider_params
        params.require(:provider).permit(
          :name,
          :inactive,
          :unilevel_settlement_provisions_template_id,
          provisions_attributes: %i[id provision level _destroy]
        )
      end

      def set_templates
        @templates = ProvisionsTemplate.all.order(:name)
      end
    end
  end
end
