module UnilevelSettlement
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def set_user
      self.user = UnilevelSettlement.user_class.find_or_create_by(name: user_name)
    end
  end
end
