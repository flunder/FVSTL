class CreateFestivalsCountriesJoinTable < ActiveRecord::Migration
  def up
    create_table :countries_festivals, :id => false do |t|
      t.integer  :festival_id  
      t.integer  :country_id  
    end    
  end

  def down
     drop_table :countries_festivals
  end
end
