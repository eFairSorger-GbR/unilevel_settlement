module UnilevelSettlement
  class Payout < ApplicationRecord
    belongs_to :payout_run
  end
end
