module UnilevelSettlement
  class Contract < ApplicationRecord
    belongs_to :unilevel_settlement_provider
  end
end
