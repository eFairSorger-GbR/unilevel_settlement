module UnilevelSettlement
  class ProvisionsTemplate < ApplicationRecord
    has_many :providers, class_name: 'UnilevelSettlement::Provider',
                         foreign_key: 'unilevel_settlement_provisions_template_id'
    has_many :provisions, class_name: 'UnilevelSettlement::Provision',
                          foreign_key: 'unilevel_settlement_provision_template_id', inverse_of: :provision_templates


  end
end
