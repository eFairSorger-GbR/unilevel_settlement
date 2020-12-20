module UnilevelSettlement
  class Provider < ApplicationRecord
    belongs_to :unilevel_settlement_payout_amount_template
  end
end
