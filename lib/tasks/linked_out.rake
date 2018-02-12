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
    @driver.fill('#extended-nav-search input', term.name)
    @driver.submit

    # Find all the links
    @driver.css('.search-result a').each do |el|
      url = el.attribute('href')
      id = %r{in\/(?<id>.*)\/}.match(url)[:id]
      Profile.find_by_uid(id)
    end

    # Go to the next page
  end
end
