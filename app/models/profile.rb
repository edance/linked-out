# @class Profile
class Profile < ApplicationRecord
  belongs_to :search_term

  default_scope { where(created_at: 4.months.ago..Time.now) }

  scope :today, -> { where(created_at: 1.day.ago..Time.now) }
end
