class FestivalsController < ApplicationController

  def index
    @festivals = Festival.all.sort { |a,b| a.from. <=> b.from }
    @countries = Country.all
    
    s_date = DateTime.now
    e_date = Date.new(2012, 12, 31)
    @months = (s_date.month..e_date.month).to_a
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @festivals }
    end
  end

  def show
    @festival = Festival.find(params[:id])
    @acts = @festival.acts.sort { |a,b| a.name <=> b.name }
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @festival }
    end
  end

  def new
    @festival = Festival.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @festival }
    end
  end

  def edit
    @festival = Festival.find(params[:id])
  end

  def create
    @festival = Festival.new(params[:festival])

    respond_to do |format|
      if @festival.save
        format.html { redirect_to @festival, :notice => 'Festival was successfully created.' }
        format.json { render :json => @festival, :status => :created, :location => @festival }
      else
        format.html { render :action => "new" }
        format.json { render :json => @festival.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @festival = Festival.find(params[:id])

    respond_to do |format|
      if @festival.update_attributes(params[:festival])
        format.html { redirect_to @festival, :notice => 'Festival was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @festival.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @festival = Festival.find(params[:id])
    @festival.destroy

    respond_to do |format|
      format.html { redirect_to festivals_url }
      format.json { head :ok }
    end
  end
  
  def import
    Festival.import_from_festivalsearcher
    render :nothing => true
  end  
  
  
  def monthsums
    Festival.calculate_monthsums
    render :nothing => true
  end
end
