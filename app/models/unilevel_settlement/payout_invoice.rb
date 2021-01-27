module UnilevelSettlement
  class PayoutInvoice < ApplicationRecord
    belongs_to :payout_run
    belongs_to :user, class: UnilevelSettlement.user_class.to_s
    has_many :payout_records
  end
end
