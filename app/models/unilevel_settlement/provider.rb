module UnilevelSettlement
  class Provider < ApplicationRecord
    include UnilevelSettlement::DelegateAttributes

    belongs_to :provisions_template, optional: true
    has_many :provision
    has_many :contracts

    delegate_if_not_set :provisions, to: :provisions_template
  end
end
