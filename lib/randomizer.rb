# @class Randomizer
class Randomizer
  def initialize(driver)
    @driver = driver
  end

  def do_stuff
    actions = %w(rest scroll move_mouse)
    send(actions.sample)
  end

  def rest
    sleep(random_interval)
  end

  def scroll
    @driver.scroll(0, rand(height))
  end

  # Only works in Chrome 53+
  def move_mouse
    # random height
    # random width
    # find element at point (chrome only)
  end

  private

  # Make all events take more than 1 sec
  def random_interval
    rand + 1
  end

  def width
    @driver.js_eval('return window.innerWidth')
  end

  def height
    @driver.js_eval('return window.innerHeight')
  end

  def random_element
    tags = %w(a div p)
    @driver.css(tags.sample).sample
  end
end
