class UnilevelSettlement::LevelUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present?

    levels_arr = record.send(attribute)
                       .provisions
                       .select { |s| s.follow_up == record.follow_up }
                       .map(&:level)

    record.errors.add(attribute, 'Level wurde bereits vergeben') unless levels_arr.count == levels_arr.uniq.count
  end
end
