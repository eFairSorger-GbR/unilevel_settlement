class RemoveProvisionsJsonb < ActiveRecord::Migration[6.0]
  def up
    remove_column :unilevel_settlement_providers, :provisions, :jsonb
    remove_column :unilevel_settlement_provisions_templates, :provisions, :jsonb
  end

  def down
    add_column :unilevel_settlement_providers, :provisions, :jsonb
    add_column :unilevel_settlement_provisions_templates, :provisions, :jsonb
  end
end
