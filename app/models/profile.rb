class Profile < ApplicationRecord
  belongs_to :search_term

  default_scope { where(created_at: 4.months.ago..Time.now) }
end
