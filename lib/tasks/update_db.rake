require 'open-uri'

namespace :update_db do
  desc "TODO"
  task download_file_with_quotes: :environment do
    url = "https://candledata.fxcorporate.com/D1/EURUSD/2012.csv.gz"

    open("#{Time.now.year}.csv.gz", 'wb') do |file|
      file << open(url).read
    end

  end
end
