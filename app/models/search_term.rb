# @class SearchTerm
class SearchTerm < ApplicationRecord
  before_save :downcase_name

  def self.find_by_name(name)
    super(name.downcase)
  end

  def downcase_name
    name.downcase!
  end
end
