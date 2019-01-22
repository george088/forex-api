require 'open-uri'
require 'zlib'

class LoadQuotes < ActiveRecord::Migration[5.2]
  def change
    Ticketlist.select(:sybmol).each do |ticket|
      url = "https://candledata.fxcorporate.com/D1/#{ticket.sybmol}/2012.csv.gz"
      folder = "#{Rails.root}/downloaded/"
      file_name = "#{ticket.sybmol}_2012"
      
      full_path = folder + file_name + '.csv.gz'

      open(folder + file_name + '.csv.gz', 'wb') do |file|
        file << open(url).read
      end

      Zlib::GzipReader.open(full_path).each_line do |gz|
          # teper' nugno razdelit'
          puts line = gz.split(',')
          if !(line[0] == 'DateTime')
            Quote.create(datestamp: Date.strptime(line[0].split(' ')[0], '%m/%d/%Y').to_s, open: line[1], high: line[2], low: line[3], close: line[4], symbol: ticket.sybmol)
          end
        end
    end
  end
end
