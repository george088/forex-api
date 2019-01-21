class AddTicketnametolistoftickets < ActiveRecord::Migration[5.2]
  def change
    Ticketlist.create :sybmol => 'EURUSD', :for_premium => '0'
    Ticketlist.create :sybmol => 'USDCAD', :for_premium => '0'
    Ticketlist.create :sybmol => 'USDJPY', :for_premium => '1'
    Ticketlist.create :sybmol => 'AUDUSD', :for_premium => '1'
  end
end
