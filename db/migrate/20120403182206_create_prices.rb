class CreatePrices < ActiveRecord::Migration
  
  def self.up
    create_table :prices do |t|
      t.float    :price
      t.integer  :festival_id
      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end  
  
end
