module UnilevelSettlement
  class PayoutRecord < ApplicationRecord
    belongs_to :payout
    belongs_to :contract
    has_one :user, through: :contract
  end
end
