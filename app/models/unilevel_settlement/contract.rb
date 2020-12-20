module UnilevelSettlement
  class Contract < ApplicationRecord
    belongs_to :provider
    belongs_to :user, class: UnilevelSettlement.user_class.to_s
    has_many :payout_records
  end
end
