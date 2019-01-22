class AddDataToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :datestamp, :date
  end
end
