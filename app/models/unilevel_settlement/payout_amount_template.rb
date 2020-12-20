module UnilevelSettlement
  class PayoutAmountTemplate < ApplicationRecord
    has_many :providers
  end
end
