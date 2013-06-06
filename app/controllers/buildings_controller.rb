class BuildingsController < ApplicationController
  layout 'template'

  # GET /buildings
  # GET /buildings.xml
  def index
     @meta_keywords = @title = @meta_description = 'Locations A-Z'
    unless read_fragment(:action => 'index')
      @buildings = Building.list
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @buildings }
    end
  end

def search    
    session[:query] = params[:query].strip.downcase if params[:query]
    if session[:query] and request.xhr?
      @buildings = Building.search(session[:query])
      render :partial => "searchresults", :layout => false, :locals => {:searchresults => @buildings} 
    end
  end

  # GET /buildings/1
  # GET /buildings/1.xml
  def show
    session[:building_id] = nil
    @flickr_id = flickr_id
    @building = Building.find(params[:id])
    session[:building_id] = @building.id
    @meta_keywords = @title = @meta_description = @building.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @building }
    end
  end
  
  #AJAX update
  def show_detail
    @building ||= Building.find(session[:building_id])
    render :partial => "detail", :locals => {:url => params[:url], :description => params[:description], :building => @building, :name => params[:name], :og_url => params[:og_url]} and return
  end


  # GET /buildings/image/1
  # GET /buildings/image/1.xml
  def image
   @building = Building.find(params[:id])
   @name = params[:name]   
   @meta_keywords = @title = @meta_description = @building.name + " " + @name
   @image_url = params[:url]
    respond_to do |format|
      format.html {render :layout  => 'image'}
      format.xml  { render :xml => @building }
    end
  end
  
 
  
end
