module UnilevelSettlement
  class PayoutRunCancelService
    def initialize(payout_run)
      @payout_run = payout_run
    end

    def cancel
      destroy_connected_data
      @payout_run.destroy
    end

    private

    def destroy_connected_data
      contracts = @payout_run.records.map(&:contract).uniq
      destroy_new_records
      destroy_new_invoices
      destroy_new_contracts(contracts)
    end

    def destroy_new_invoices
      @payout_run.invoices.each(&:destroy)
    end

    def destroy_new_records
      @payout_run.records.each(&:destroy)
    end

    def destroy_new_contracts(contracts)
      contracts.each(&:destroy)
    end
  end
end
