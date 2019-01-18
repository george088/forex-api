class CreateTicketlists < ActiveRecord::Migration[5.2]
  def change
    create_table :ticketlists do |t|
      t.string  :sybmol
      t.boolean :for_premium
      
      t.timestamps
    end
  end
end
