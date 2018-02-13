# @class Crawler
class Crawler
  def initialize(term = SearchTerm.random)
    @search_term = term
    @driver = Driver.new
    @randomizer = Randomizer.new(@driver)
  end

  def search
    login
    search_by_term
  end

  private

  def login
    @driver.visit('https://www.linkedin.com')
    @driver.fill('#login-email', Rails.application.secrets.email)
    @driver.fill('#login-password', Rails.application.secrets.password)
    randomize
    @driver.submit
  end

  def search_by_term
    @driver.fill('#extended-nav-search input', @search_term.name)
    @driver.submit
    randomize

    max = rand(Rails.application.secrets.max_profiles)
    page = Pagination.new(@driver)
    iter(page, max)
  end

  def iter(page, count)
    return if Profile.today.count >= count
    @randomizer.do_stuff

    link = uniq_link
    if link.nil?
      page.next
    else
      visit_link(link)
    end
    iter(page, count)
  end

  def visit_link(link)
    id = find_uid(link)
    link.click
    name = @driver.css('h1').first.text
    Profile.create(name: name, uid: id, search_term: @search_term)
    randomize
    @driver.back
    randomize
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

  def randomize
    @randomizer.do_stuff
  end
end
