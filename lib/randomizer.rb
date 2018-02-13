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

  def move_mouse
    # TODO: Create this in javascript
  end

  private

  # Make all events take more than 1 sec
  def random_interval
    rand + 1
  end

  def height
    @driver.js_eval('return window.innerHeight')
  end
end
