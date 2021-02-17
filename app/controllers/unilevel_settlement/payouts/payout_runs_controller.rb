require_dependency 'unilevel_settlement/payouts/application_controller'

module UnilevelSettlement
  module Payouts
    class PayoutRunsController < ApplicationController
      include ActiveStorage::SendZip

      def index
        @payout_runs = PayoutRun.all
      end

      def show
        @invoices = if @efairsorger = @payout_run.invoices.find_by(user: User.find_by(first_name: 'eFairSorger'))
                      @payout_run.invoices.where.not(id: @efairsorger.id)
                    else
                      @payout_run.invoices
                    end

        @total_payout = @invoices.sum(:total)
        @total_vat_payout = @invoices.sum(:total_vat)
        @sub_total_payout = @invoices.sum(:sub_total)
        @count_payouts = @invoices.count

        respond_to do |format|
          format.html { render }
          format.zip {
            send_zip @invoices.to_a.concat([@efairsorger]).map(&:invoice_pdf),
            filename: "eFairSorger_Abrechnungen_#{@payout_run.payout_date.strftime('%Y-%m-%d')}.zip"
          }
        end
      end

      def start
        @payout_run = PayoutRun.new
      end

      def create
        @payout_run = PayoutRun.new(payout_run_params)
        if @payout_run.save
          @payout_run.update(state: 'awaiting_providers')
          redirect_to flow_payouts_payout_run_path(@payout_run)
        else
          render :new
        end
      end

      def flow
        redirect_to set_next_path
      end

      def publish
        if @payout_run.published_date.nil? && @payout_run.update(published_date: Date.today)
          @payout_run.invoices.each { |i| i.user.send_new_invoice(i) }
          flash[:notice] = 'Die Abrechnungen wurden veröffentlicht und die Berater benachrichtigt.'
        else
          flash[:error] = 'Die Aktion konnte nicht durchgeführt werden'
        end
        redirect_to payouts_payout_run_path(@payout_run)
      end

      def cancel
        @payout_run.cancel
        flash[:notice] = 'Die Abrechnung und alle dazugehörigen Daten wurden gelöscht'
        redirect_to payouts_payout_runs_path(@payout_run)
      end

      private

      def payout_run_params
        params.require(:payout_run).permit(
          :payout_date,
          :performance_start_date,
          :performance_end_date,
          :payout_records_source_excel
        )
      end

      def set_next_path
        case @payout_run.state
        when 'awaiting_providers' then payouts_payout_run_providers_path(@payout_run)
        when 'awaiting_payout_records' then create_all_payouts_payout_run_payout_invoices_path(@payout_run)
        when 'run_finished' then payouts_payout_run_path(@payout_run)
        else
          start_payouts_payout_runs_path
        end
      end
    end
  end
end
