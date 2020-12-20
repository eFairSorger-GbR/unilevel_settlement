module UnilevelSettlement
  class Provider < ApplicationRecord
    belongs_to :payout_amount_template, optional: true
    has_many :contracts
  end
end
