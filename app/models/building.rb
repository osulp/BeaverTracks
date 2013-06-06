class Building < ActiveRecord::Base
  hobo_model # Don't put anything above this
  #Building.list - grouped by building name
  named_scope :list, :order => :name
  named_scope :search, lambda { |query| 
    {:conditions => ["LOWER(name) LIKE ? or LOWER(description) LIKE ? or LOWER(search_tags) LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%"] , :order => :name}
    }
  #GeoKit
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng


#hobo
 fields do
    name          :string, :required
    description   :text, :required
    flickr_url    :string, :required
    og_url        :string, :required
    tag           :string, :required
    search_tags   :string, :required
    lat           :float, :required
    lng           :float, :required
    timestamps
  end
  
  
  #param trunc_me = string to be truncated, length to trucate, and filler
  #returns the truncated string
  def truncate_string(trunc_me = "", len = 25, om = "...")
      text = trunc_me
      l = len - om.mb_chars.length
      chars = text.mb_chars
      trunc_me = (chars.length > len ? chars[0...l] + om : text).to_s
      return trunc_me
  end
  
    # param @building 
 # returns marker
 def create_marker(url, icon, inf = nil)
      #create info string with self name, shorten description and link
      info = '<div id="info_bubble"><h2><a href='+url+'>' + name.to_s + '</a></h2><p>' + truncate_string(description, 55,  "...") + ' <a href='+url+'>more</a></p>'
      info += inf == nil ? '</div>' : inf + '</div>'
      #create the marker with lat/long and info
      mark = GMarker.new([lat,lng], :title => "#{name}",
      :icon => icon,
      :info_window => "#{info}")

     return mark
 end
 


 #return nearby buildings
 # nearby this object
   def self.nearby(obj)
    return Building.find(:all, :origin => obj, :within => 1, :limit => 4, :order=>'distance').select{|b| b.id != obj.id}
  end
# --- Permissions --- #

def create_permitted?
 acting_user.administrator?
end

def update_permitted?
  acting_user.administrator? || (acting_user == self && only_changed?(:crypted_password, :email_address))
  # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
  # directly from a form submission.
end

def destroy_permitted?
  acting_user.administrator?
end

def view_permitted?(field)
  true
end
end
