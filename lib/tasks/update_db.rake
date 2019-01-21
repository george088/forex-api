require 'open-uri'
require 'rubygems/package'
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

      open(folder + "#{ticket.sybmol}_2012.csv.gz", 'wb') do |file|
        file << open(url).read

        gz_extract = Zlib::GzipReader.open(file)
        gz_extract.rewind # The extract has to be rewinded after every iteration
        gz_extract.each do |entry|
          puts entry.full_name
          puts entry.directory?
          puts entry.file?
          # puts entry.read
        end
        gz_extract.close
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
