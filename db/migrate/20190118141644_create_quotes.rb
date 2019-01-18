class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.float :open
      t.float :high
      t.float :low
      t.float :close

      t.timestamps
    end
  end
end
