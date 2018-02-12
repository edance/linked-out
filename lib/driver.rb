# @class Driver
# @author Evan Dancer
class Driver
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

  private

  def default_options
    return {} unless Rails.application.secrets.headless
    Selenium::WebDriver::Chrome::Options.new(args: ['-headless'])
  end

  def find_element(selector)
    @driver.find_element(:css, selector)
  end

  def send_keys_to_element(element, text)
    element.clear
    element.send_keys(text)
  end
end
