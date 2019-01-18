class AddSymbolToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :symbol, :string
  end
end
