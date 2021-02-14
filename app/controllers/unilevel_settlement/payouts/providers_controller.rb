require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class ProvidersController < ApplicationController
      before_action :set_templates

      def index
        @providers = instantiate_providers
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

      def check_provider_validity
        @providers = instantiate_providers

        if @providers.all?(&:valid?) && @payout_run.update(state: 'awaiting_payout_records')
          redirect_to flow_payouts_payout_run_path(@payout_run)
        else
          flash.now[:error] = 'Bitte füge für alle neuen Anbieter Provisionen hinzu und speichere sie ab.'
          render :index
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

      def instantiate_providers
        providers = PayoutRunExcelReader.new(@payout_run).read_providers
        providers.map { |name| Provider.find_or_initialize_by(name: name) }
      end
    end
  end
end
