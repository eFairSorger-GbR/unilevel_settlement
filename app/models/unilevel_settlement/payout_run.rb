module UnilevelSettlement
  class PayoutRun < ApplicationRecord
    has_many :payouts
    has_many :payout_records, through: :payouts
  end
end
