module UnilevelSettlement
  class PayoutInvoice < ApplicationRecord
    belongs_to :run, class_name: 'UnilevelSettlement::PayoutRun', foreign_key: 'unilevel_settlement_payout_run_id',
                     optional: false, inverse_of: :invoices
    belongs_to :user, class: UnilevelSettlement.user_class.to_s

    has_many :records, class_name: 'UnilevelSettlement::PayoutRecord', foreign_key: 'unilevel_settlement_payout_invoice_id',
                       inverse_of: :invoice
  end
end
