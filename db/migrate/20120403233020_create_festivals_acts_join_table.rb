class CreateFestivalsActsJoinTable < ActiveRecord::Migration
  def up
    create_table :acts_festivals, :id => false do |t|
      t.integer  :festival_id  
      t.integer  :act_id  
    end
    
    # ??
    add_index :acts_festivals, [ :festival_id , :act_id ], :unique => true
    
  end

  def down
    drop_table :acts_festivals
  end
end
