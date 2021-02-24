class UnilevelSettlement::LevelOrderValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.empty?

    levels = value.map(&:level)
    record.errors.add(attribute, 'Level 0 als `Eigenprovision` muss angegeben sein') unless levels.include?(0)

    return if levels.sort == (levels.min..levels.max).to_a

    record.errors.add(attribute, 'Alle Level müssen durchgängig ohne Lücke sein')
  end
end
