module UnilevelSettlement
  class ProvisionsTemplate < ApplicationRecord
    has_many :providers
    has_many :provision
  end
end
