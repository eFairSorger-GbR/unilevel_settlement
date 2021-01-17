module UnilevelSettlement
  class Provision < ApplicationRecord
    belongs_to :provider, optional: true
    belongs_to :provisions_template, optional: true
  end
end
