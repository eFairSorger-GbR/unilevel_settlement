module UnilevelSettlement
  class PayoutInvoice < ApplicationRecord
    belongs_to :run, class_name: 'UnilevelSettlement::PayoutRun', foreign_key: 'unilevel_settlement_payout_run_id',
                     optional: false, inverse_of: :invoices
    belongs_to :user, class_name: UnilevelSettlement.user_class.to_s, foreign_key: 'user_id', optional: false,
                      inverse_of: :invoices

    has_many :records, class_name: 'UnilevelSettlement::PayoutRecord', foreign_key: 'unilevel_settlement_payout_invoice_id',
                       inverse_of: :invoice

    before_validation :create_invoice_number, on: :create

    validates :invoice_number, presence: true, uniqueness: true

    private

    def create_invoice_number
      others_count = PayoutRun.where(payout_date: run.payout_date.all_month).map(&:invoices).count
      self.invoice_number = "eFS#{run.payout_date.strftime('%y%m')}#{others_count.succ.to_s.rjust(4, '0')}"
    end
  end
end
