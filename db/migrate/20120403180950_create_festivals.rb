class CreateFestivals < ActiveRecord::Migration
  def self.up
    create_table   :festivals do |t|
      t.string     :title      
      t.string     :website
      t.text       :desc
      t.string     :city
      t.date       :from
      t.date       :to      
      t.text       :imageSrc      
      t.string     :photo_file_name
      t.string     :photo_content_type
      t.integer    :photo_file_size      
      t.timestamps
    end
  end

  def self.down
    drop_table :festivals
  end
end
