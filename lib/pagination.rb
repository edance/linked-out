# @class Pagination
# @author Evan Dancer
class Pagination
  def initialize(driver)
    @page = 1
    @driver = driver
  end

  def more?
    !next_link.nil?
  end

  def less?
    !prev_link.nil?
  end

  def next
    return unless more?
    next_link.click
    @page += 1
  end

  def prev
    return unless less?
    prev_link.click
    @page -= 1
  end

  private

  def prev_link
    @driver.css('.results-paginator .prev').first
  end

  def next_link
    @driver.css('.results-paginator .next').first
  end
end
