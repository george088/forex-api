require 'open-uri'

namespace :update_db do
  desc "TODO"
  task download_file_with_quotes: :environment do
    # url = "https://candledata.fxcorporate.com/D1/EURUSD/2012.csv.gz"

    # open("#{Rails.root}/downloaded/#{Time.now.year}.csv.gz", 'wb') do |file|
    #   file << open(url).read
    # end

    Ticketlist.select(:sybmol).each do |ticket|
      url = "https://candledata.fxcorporate.com/D1/#{ticket.sybmol}/2012.csv.gz"
      open("#{Rails.root}/downloaded/#{ticket.sybmol}_2012.csv.gz", 'wb') do |file|
        file << open(url).read
      end
    end
  end
end
