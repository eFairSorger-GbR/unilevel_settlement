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
      destroy_new_contracts
      destroy_new_providers
    end

    def destroy_new_contracts
      contracts = PayoutRunExcelReader.new(@payout_run)
                                      .read_contracts.map { |data| Contract.find_by_contract_number(data[:contract_number]) }
                                      .compact
      contracts = contracts.select { |contract| contract.created_at > @payout_run.created_at }
      contracts.each(&:destroy)
    end

    def destroy_new_providers
      providers = PayoutRunExcelReader.new(@payout_run)
                                      .read_providers.map { |name| Provider.find_by_name(name) }
                                      .compact
      providers = providers.select { |provider| provider.created_at > @payout_run.created_at }
      providers.each(&:destroy)
    end
  end
end