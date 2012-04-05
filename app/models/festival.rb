# encoding: UTF-8

require 'rubygems'
require 'htmlentities'
require 'open-uri'
require 'scrapi'
require 'iconv'
require 'csv'
require 'cgi'
require 'xml'

class Festival < ActiveRecord::Base
  
  has_and_belongs_to_many :acts, :uniq => true
  has_many :prices
  
  # PAPERCLIP ------------------------------------------
  attr_accessor :image_url
  attr_accessor :image_remote_url

  # before_create :dblcheck_file_name
  before_create :dblcheck_file_name
  before_validation :download_remote_image, :if => :image_url_provided?
  validates_presence_of :image_remote_url, :if => :image_url_provided?, :message => 'is invalid or inaccessible'  
  
  has_attached_file :photo,
                    :styles => { :small =>  ["50x50#", :png], :thumb =>  ["200x134#", :png] }, #, :large =>  ["250x230#", :png]
                    :path => ":rails_root/public/images/items/:id/:style/:basename.:extension",
                    :url  => "/images/items/:id/:style/:basename.:extension",
                    :default_url => "/images/noimage.png",
                    :default_style => :thumb
  # // PAPERCLIP ----------------------------------------
   
  def self.import_from_festivalsearcher
    
      scraper = Scraper.define do
          array :items
          process "#ctl00_main_festivalslistgrid tr", :items => Scraper.define {
              process ".asp_hyplk2", :title => :text, :link => "@href"
              process "td:nth-child(3)", :country => :text
              result :title, :link, :country
            }
          result :items
      end
      
      scraper2 = Scraper.define do
          array :items
          process "#festivalprofile-main-mid", :items => Scraper.define {
              process "#ctl00_main_FormView1_FestivalNameLabel", :title => :text
              process "#ctl00_main_FormView1_StartDateLabel", :fromdate => :text
              process "#ctl00_main_FormView1_EndDateLabel", :todate => :text              
              process "#ctl00_main_FormView1_WebsiteLinkText", :website => "@href"     
              process "#ctl00_main_FormView1_CityLabel", :city => :text                            
              process "#ctl00_main_FormView1_FacebookLinkImage", :fbUrl => "@href"                                               
              process "#ctl00_main_FormView1_Established", :estab => :text
              process "#ctl00_main_FormView1_Image1", :imageSrc => "@src"    
              process "#ctl00_main_FormView1_Capacity", :capacity => :text                

              result :title, :fromdate, :todate, :website, :city, :fbUrl, :estab, :imageSrc, :capacity
            }
          result :items
      end      
      
      scraper3 = Scraper.define do
          array :items
          process "#lineup li", :items => Scraper.define {
              process "a", :act => :text
              result :act
            }
          result :items
      end
  
      uri = URI.parse('http://www.festivalsearcher.com/festivalslist.aspx')

      scraper.scrape(uri).each_with_index do |product,i|
        
        if product.link && (i < 10)
                  
            @title = product.title 
            @href = 'http://www.festivalsearcher.com/' << product.link
            @country = product.country
          
            puts "working on #{product.title}"
            
            uri = URI.parse(@href)

            scraper2.scrape(uri).each_with_index do |product2,i2|
                @title2 = product2.title
                @from2 = (product2.fromdate << ' 2012').to_date if @from2
                @to2 = product2.todate.to_date unless !@to2
                @website = product2.website         
                @city = product2.city                     
                @fbUrl = product2.fbUrl      
                @estab = product2.estab   
                @image = 'http://www.festivalsearcher.com/' << product2.imageSrc 
                @capacity = product2.capacity.delete(',').to_i if @capacity
              
                # price
                
                puts "counter #{i}"              
                puts @title2
                puts "dates: #{@from2} - #{@to2}"
                puts "website: #{@website}"
                puts "city: #{@city} / #{@country}"              
                puts "fbUrl: #{@fbUrl}" 
                puts "estab: #{@estab}"          
                puts "image: #{@image}" 
                puts "capacity: #{@capacity}" 
                puts    
          
               create!(
                   :title        => @title2,
                   :website      => @website,
                   :desc         => '',
                   :country      => @country,
                   :city         => @city,                 
                   :from         => @from2,                     
                   :to           => @to2,  
                   :imageSrc     => @image,
                   :image_url    => @image,                                    
              )

              @justCreatedFestival = Festival.find_by_title(@title2)
              
            end
            
            if scraper3.scrape(uri)
              scraper3.scrape(uri).each_with_index do |product3,i|
                
                  @act3 = product3
                  # puts "act: #{@act3}" 
  
                  #new_acts = [] 
                  #if existing = Act.find_by_name(@act3) 
                  #  new_acts << existing
                  #else 
                  #  new_acts << @act3
                  #end
                  
                  @justCreatedFestival.add_act(@act3)
                  @justCreatedFestival.save

                  
                  # org
                  #@justCreatedFestival.acts.create( {:name => @act3 })
                  
              end
            end
            
        end
        
    end    


  end
     
     private

        def dblcheck_file_name
          # Always generate a new filename
            self.photo.instance_write(:file_name, "#{SecureRandom.hex(6)}.png")
        end

        def image_url_provided?
          !self.image_url.blank?
        end

        def download_remote_image
          self.photo = do_download_remote_image
          self.image_remote_url = image_url
        end

        def do_download_remote_image
          io = open(URI.parse(image_url))
          def io.original_filename; base_uri.path.split('/').last; end
          io.original_filename.blank? ? nil : io
        rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
      end     
      
  
end
