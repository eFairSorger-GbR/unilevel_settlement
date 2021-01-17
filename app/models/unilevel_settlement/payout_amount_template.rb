module UnilevelSettlement
  class PayoutAmountTemplate < ApplicationRecord
    has_many :providers
    has_many :provision
  end
end
