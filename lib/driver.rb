# @class Driver
# @author Evan Dancer
class Driver
  attr_accessor :driver

  def initialize
    @driver = Selenium::WebDriver.for(:chrome, options: default_options)
  end

  def visit(url)
    @driver.navigate.to(url)
  end

  def fill(selector, text)
    send_keys_to_element(find_element(selector), text)
  end

  def submit
    @driver.action.send_keys(:enter).perform
  end

  def css(selector)
    @driver.find_elements(:css, selector)
  end

  def back
    @driver.navigate.back
  end

  def scroll(x, y)
    js_eval("window.scrollTo(#{x}, #{y})")
  end

  def js_eval(str)
    @driver.execute_script(str)
  end

  def quit
    @driver.quit
  end

  private

  def default_options
    Selenium::WebDriver::Chrome::Options.new(
      args: Rails.application.secrets.headless ? ['-headless'] : [],
      binary: ENV['GOOGLE_CHROME_SHIM']
    )
  end

  def find_element(selector)
    @driver.find_element(:css, selector)
  end

  def send_keys_to_element(element, text)
    element.clear
    element.send_keys(text)
  end
end
