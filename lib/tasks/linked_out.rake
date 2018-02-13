namespace :linked_out do
  task random: :environment do
    Crawler.new.search
  end
end
