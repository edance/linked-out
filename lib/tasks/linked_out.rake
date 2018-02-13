namespace :linked_out do
  task search: :environment do
    Crawler.new(SearchTerm.find_by_name(ENV['SEARCH_TERM'])).search
  end

  task random_search: :environment do
    Crawler.new.search
  end
end
