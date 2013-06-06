class MapsController < ApplicationController
  #campus map
  def index
    @meta_keywords = @title = @meta_description = 'Map View'
   # Create a new map object, also defining the div ("map") 
   # where the map will be rendered in the view
   @map = GMap.new("map")
   # Use the larger pan/zoom control but disable the map type
   # selector
   @map.control_init()
   # Center the map on library and focus out to capture
   #  all buildings
   @map.center_zoom_init([44.5650618928,-123.27603917],16)
    location_icon = building_marker(@map)
    Building.list.each do |building|
      url = url_for(building)
        mark =  building.create_marker(url, location_icon)
        @map.overlay_init(mark)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @maps }
    end
end

  # GET /buildings/1
  # GET /buildings/1.xml
  #building map
 def locations
   @building = Building.find(params[:id])
   @meta_keywords = @title = @meta_description = "Nearby " + @building.name
   @map = GMap.new("map")
   # Use the larger pan/zoom control but disable the map type
   # selector
   @map.control_init()
   # Center the map on building and focus in fairly
   # closely
    @map.center_zoom_init([@building.lat,@building.lng],17)
    @map.icon_global_init(GIcon.new(:image => "/images/home/image.png",
       :shadow => "/images/home/shadow.png",
        :iconSize => GSize.new(32,37),
       :shadow_size => GSize.new(51,37),
       :icon_anchor => GPoint.new(16,37),
       :transparent => "/images/home/transparent.png",
       :info_window_anchor => GPoint.new(16,0)),
       "home_icon")
        home_icon = Variable.new("home_icon")
        url = url_for(@building)
        mark =  @building.create_marker(url,home_icon)
    @map.overlay_init(mark)    
    @buildings = Building.nearby(@building)  #the 3 closest and itself
    location_icon = building_marker(@map)
    @buildings.each do |building|
          url = url_for(building)
          mark =  building.create_marker(url,location_icon)
          @map.overlay_init(mark)
    end  
    respond_to do |format|
      format.html # locations.html.erb
      format.xml  { render :xml => @map }
    end
 end
 
  # GET /patrons/1
  # GET /patrons/1.xml
   def tour
       @meta_keywords = @title = @meta_description = "Walking Tour"
       @patron = Patron.find(params[:id])
       @map = GMap.new("map")
       # Use the larger pan/zoom control but disable the map type
       # selector
       @map.control_init()
       # Center the map on building and focus in fairly
       # closely
        @map.center_zoom_init([@patron.lat,@patron.lng],17)
        @buildings = Building.nearby(@patron)  #the 4 closest 
        #create icon
        @map.icon_global_init(GIcon.new(:image => "/images/walking/image.png",
       :shadow => "/images/walking/shadow.png",
        :iconSize => GSize.new(32,37),
       :shadow_size => GSize.new(51,37),
       :icon_anchor => GPoint.new(16,37),
       :transparent => "/images/walking/transparent.png",
       :info_window_anchor => GPoint.new(16,0)),
       "patron_icon")
        patron_icon = Variable.new("patron_icon")
        #build direction info
        info = direction_info(@patron.id)
        #create the marker with lat/long and info
        mark = GMarker.new([@patron.lat,@patron.lng], 
        :icon => patron_icon,
        :title => "My Location",
        :info_window => "#{info}")
        #add patron marker
        @map.overlay_init(mark)
        #build buildings markers
        location_icon = building_marker(@map)
        @buildings.each do |building|
          loc = building.lat.to_s+','+building.lng.to_s
          info = building_direction_info(@patron.id,loc)
          url = url_for(building)
          mark =  building.create_marker(url,location_icon, info)
          @map.overlay_init(mark)
        end  
       @on_campus = session[:campus]
       session[:campus]= nil
       respond_to do |format|
           format.html   # walking.html.erb
           format.xml  { render :xml => @map }
       end
   end
   
 #walking directions from patron location
 #param(sadd) ending location
  def directions
    @meta_keywords = @title = @meta_description = "Directions"
    sadd = params[:saddr]
    @patron = Patron.find(params[:id])
    fadd = @patron.lat.to_s+','+@patron.lng.to_s
    @map = GMap.new("map")
    @map.control_init()
    @map.center_zoom_init([@patron.lat,@patron.lng],17)
    @map.directions('directions',fadd,sadd)
     respond_to do |format|
           format.html  # directions.html.erb
           format.xml  { render :xml => @map }
       end
 end
 
 
 def building_marker(map)
   #make icon
      map.icon_global_init(GIcon.new(:image => "/images/home.png",
       :shadow => "/images/walking/shadow.png",
       :iconSize => GSize.new(32,37),
       :shadow_size => GSize.new(51,37),
       :icon_anchor => GPoint.new(16,37),
       :transparent => "/images/walking/transparent.png",
       :info_window_anchor => GPoint.new(16,0)),
       "location_icon")
        return Variable.new("location_icon")
 end
 
 
 #build patron direction marker info
 def direction_info(id)
    url = edit_patron_url(id)
    direct_url = directions_map_url(id)
    edit_url =  edit_patron_path(id)
    buildings = Building.list
    #create info string with link to refresh patron location
    info = '<div id="info_bubble">'
    info +=  '<h2>Get Directions To:</h2>' +'<form action='+direct_url +' ><select class="select type="search" name="saddr" id="saddr">'
    buildings.each do |building|
          info += '<option   value="'+building.lat.to_s+','+building.lng.to_s+'" />'+building.name+'</option>'
     end     
     info += '</select><input value="Go" type="submit" class="button" /></form>'
     info += '<span class="right"><a href= "'+edit_url+'">Update Position</a></span></div>'
       
     return info
 end
 
  #build location directions marker info
 def building_direction_info(id, loc)
    direct_url = directions_map_url(id)
    #create info string with link to refresh patron location
    info =  '<form action='+direct_url + '><input type = hidden id = "saddr" name = "saddr" value ='+loc+') />'
    info += '<input value="Get Direction to Here" type="submit" class="button" />'
       
     return info
 end
 

end
