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
    term = SearchTerm.order('RANDOM()').first
    search_by_term(term)
  end

  def search_by_term(term)
    @driver.fill('#extended-nav-search input', term.name)
    @driver.submit
    sleep(2)

    max = rand(Rails.application.secrets.max_profiles)
    page = Pagination.new(@driver)
    iter(page, term, max)
  end

  def iter(page, term, count)
    return if Profile.count >= count
    sleep(2)

    link = uniq_link
    if link.nil?
      page.next
    else
      id = find_uid(link)
      link.click
      name = @driver.css('h1').first.text
      Profile.create(name: name, uid: id, search_term: term)
      sleep(2)
      @driver.back
      sleep(2)
    end
    iter(page, term, count)
  end

  def uniq_link
    @driver.css('.search-result__result-link').find do |link|
      !Profile.exists?(uid: find_uid(link))
    end
  end

  def find_uid(link)
    url = link.attribute('href')
    %r{in\/(?<id>.*)\/}.match(url)[:id]
  end
end
