class UnilevelSettlement::LevelOrderValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.empty?

    normal_levels = value.reject(&:follow_up?).map(&:level)
    follow_up_levels = value.select(&:follow_up?).map(&:level)

    level_0_missing_validation(record, attribute, normal_levels)
    seamless_order_validation(record, attribute, normal_levels, follow_up_levels)
  end

  private

  def level_0_missing_validation(record, attribute, normal_levels)
    return if normal_levels.include?(0)

    record.errors.add(attribute, 'Level 0 als `Eigenprovision` muss angegeben sein')
  end

  def seamless_order_validation(record, attribute, normal_levels, follow_up_levels)
    return if seamless_order?(normal_levels) && seamless_order?(follow_up_levels)

    record.errors.add(attribute, 'Alle Level müssen durchgängig ohne Lücke sein')
  end

  def seamless_order?(levels)
    return true if levels.empty?

    levels.sort == (levels.min..levels.max).to_a
  end
end
