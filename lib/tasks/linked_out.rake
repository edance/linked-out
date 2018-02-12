namespace :linked_out do
  task random: :environment do
    @driver = Driver.new
    login
    search
    sleep(5)
    @driver.quit
  end

  # Good to go
  def login
    @driver.visit('https://www.linkedin.com')
    @driver.fill('#login-email', Rails.application.secrets.email)
    @driver.fill('#login-password', Rails.application.secrets.password)
    @driver.submit
  end

  def search
    # ENV of how many terms we want to use
    ENV['DAILY_COUNT'] = 200
    term = SearchTerm.order('RANDOM()').first
    search_by_term(term)
  end

  def search_by_term(term)
    # Use the term
    element = @driver.find_element(:css, '#extended-nav-search input')
    element.clear
    element.send_keys(term.name)
    element.send_keys:return

    # Find all the links
    selector = '.search-result a'
    @driver.find_elements(:css, selector).each do |el|
      url = el.attribute('href')
      id = %r{in\/(?<id>.*)\/}.match(url)[:id]
    end

    # Go to the next page
  end
end
