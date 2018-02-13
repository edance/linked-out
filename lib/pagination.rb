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
    scroll_to_bottom
    next_link.click
    @page += 1
  end

  def prev
    return unless less?
    scroll_to_bottom
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

  def scroll_to_bottom
    @driver.scroll(0, 1000)
  end
end
