require 'open-uri'
# require 'rubygems/package'
require 'zlib'

namespace :update_db do
  desc "TODO"
  task download_file_with_quotes: :environment do
    # Ticketlist.select(:sybmol).each do |ticket|
    #   url = "https://candledata.fxcorporate.com/D1/#{ticket.sybmol}/2012.csv.gz"
    #   folder = "#{Rails.root}/downloaded/"
    #   file_name = "#{ticket.sybmol}_2012"
      
    #   full_path = folder + file_name + '.csv.gz'

    #   open(folder + file_name + '.csv.gz', 'wb') do |file|
    #     file << open(url).read
    #   end

    #   Zlib::GzipReader.open(full_path).each_line do |gz|
    #       # teper' nugno razdelit'
    #       puts line = gz.split(',')
          
    #       # if line[0] != 'BidOpen' do
    #       #   Quotes.create(datestamp: line[0], Open: line[1], High: line[2], Low: line[3], Close: line[4], symbol: ticket.sybmol)
    #       # end
    #   end

    # end
  end
end