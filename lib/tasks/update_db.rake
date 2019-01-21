require 'open-uri'
# require 'rubygems/package'
require 'zlib'

namespace :update_db do
  desc "TODO"
  task download_file_with_quotes: :environment do
    # url = "https://candledata.fxcorporate.com/D1/EURUSD/2012.csv.gz"

    # open("#{Rails.root}/downloaded/#{Time.now.year}.csv.gz", 'wb') do |file|
    #   file << open(url).read
    # end

    Ticketlist.select(:sybmol).each do |ticket|
      url = "https://candledata.fxcorporate.com/D1/#{ticket.sybmol}/2012.csv.gz"
      folder = "#{Rails.root}/downloaded/"
      file_name = "#{ticket.sybmol}_2012"
      
      puts file_name

      sss = folder + file_name + '.csv.gz'
      puts sss

      open(folder + file_name + '.csv.gz', 'wb') do |file|
        file << open(url).read
      end

      Zlib::GzipReader.open(sss).each_line do |gz|
        puts gz
      end

    end
  end
end




    
# input_filenames = ['image.jpg', 'description.txt', 'stats.csv']

# zipfile_name = "/Users/me/Desktop/archive.zip"

# Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
#   input_filenames.each do |filename|
#     # Two arguments:
#     # - The name of the file as it will appear in the archive
#     # - The original file, including the path to find it
#     zipfile.add(filename, File.join(folder, filename))
#   end
#   zipfile.get_output_stream("myFile") { |f| f.write "myFile contains just this" }
#   end
# end
