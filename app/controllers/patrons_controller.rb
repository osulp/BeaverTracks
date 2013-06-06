class PatronsController < ApplicationController
 geocode_ip_address :only => [:new, :edit, :set_location]
  
  # GET /patrons/new
  # GET /patrons/new.xml
  def new
    @meta_keywords = @title = @meta_description = 'Retrieving Location'
    session[:patron] = nil
    @patron =  Patron.new
    # test if on campus
    @lat = session[:geo_location] != nil ? session[:geo_location].lat : ""
    @lng = session[:geo_location] != nil ? session[:geo_location].lng : ""
    respond_to do |format|
      format.html  # new.html.erb
      format.xml  { render :xml => @patron }
    end
  end
  
  # POST /patrons
  # POST /patrons.xml
  def create
    @patron =  Patron.new(params[:patron])
    if @patron.save
        session[:patron] = @patron
        redirect_patron(@patron.id)
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml { render :xml => @patron.errors, :status => :unprocessable_entity }
      end
    end
  end


 # GET /patrons/1/edit
  def edit
    @meta_keywords = @title = @meta_description = 'Updating Location'
    @patron = Patron.find(params[:id])
    @lat = @patron.lat
    @lng = @patron.lng
  end

  
  # PUT /patrons/1
  # PUT /patrons/1.xml
  def update
    @patron = Patron.find(params[:id])

    if @patron.update_attributes(params[:patron])
        redirect_patron(@patron.id)
    else
       respond_to do |format|
          format.html { render :action => "edit" }
        format.xml  { render :xml => @patron.errors, :status => :unprocessable_entity }
       end
    end
  end


 # param @patron 
 # checks if oncampus, and redirects to show
 def redirect_patron(id)
   patron = Patron.find(id)
    buildings =  Building.count_within(3, :origin => patron)
    #see if on campus
    if buildings > 0
       session[:campus] = true
    else
      #set location to library
        session[:campus] = false
         patron.lat = 44.5650618928
         patron.lng = -123.27603917
        patron.save
     end
      respond_to do |format|
        format.html { redirect_to(tour_map_path(patron)) }
        format.xml  { head :ok }
      end   
  end
  


end
