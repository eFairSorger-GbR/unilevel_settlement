module UnilevelSettlement
  class PayoutRun < ApplicationRecord
    has_many :payouts
    has_many :payout_records, through: :payouts

    validates :payout_date, presence: true
    validates :performance_start_date, presence: true
    validates :performance_end_date, presence: true

    validate :end_date_after_start_date, :payout_date_after_start_date

    default_scope { order(payout_date: :desc) }

    private

    def end_date_after_start_date
      return unless performance_end_date && performance_start_date
      return unless performance_end_date < performance_start_date

      errors.add(:performance_end_date, 'muss nach Start Datum liegen')
    end

    def payout_date_after_start_date
      return unless performance_start_date && payout_date
      return unless payout_date < performance_start_date

      errors.add(:payout_date, 'muss nach Start Datum liegen')
    end
  end
end
