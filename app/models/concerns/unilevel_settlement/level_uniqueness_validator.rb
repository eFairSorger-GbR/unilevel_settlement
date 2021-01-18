class UnilevelSettlement::LevelUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    return unless record.attribute.present?

    levels_arr = record.send(attribute).map { |i| i.unilevel_settlement_provisions.map(&:level) }
    record.errors.add(attribute, 'das Level wurde bereits vergeben') unless levels_arr.count == levels_arr.uniq.count
  end
end