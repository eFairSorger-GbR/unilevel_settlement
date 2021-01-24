module UnilevelSettlement
  class PayoutRun < ApplicationRecord
    has_many :payouts
    has_many :payout_records, through: :payouts

    validates :payout_date, presence: true
    validates :performance_start_date, presence: true
    validates :performance_end_date, presence: true

    default_scope { order(payout_date: :desc) }
  end
end
