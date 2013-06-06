# This module contains helper methods geo_mere_laal
module GeoMereLaalHelper
  
 
  def latitude_field(object, method, options={})
    it =   ActionView::Helpers::InstanceTag.new(object.to_s.dup, method, self)
    result = it.to_input_field_tag("text", options)    
    result << init_gml
    result << "<script> GeoMereLaal.updateLatitude_callback = function(){ document.getElementById(\"#{it.object_name.to_s+'_'+it.method_name.to_s}\").setAttribute(\"value\",GeoMereLaal.lat())}; </script>"
  end 
  
  def longitude_field(object, method, options={})
    it =   ActionView::Helpers::InstanceTag.new(object.to_s.dup, method, self)
    result = it.to_input_field_tag("text", options)  
    result << init_gml 
    result << "<script> GeoMereLaal.updateLongitude_callback = function(){ document.getElementById(\"#{it.object_name.to_s+'_'+it.method_name.to_s}\").setAttribute(\"value\",GeoMereLaal.lng())}; </script>"
  end   
  
  
  
   
  def init_gml    
      result = ""
      if !@gml_initialised
        result << GeoMereLaal.init
        result << "<script> old_onload = window.onload; window.onload = function() { if(geo_position_js.init()){ GeoMereLaal.request(); } if(typeof old_onload == \"function\"){old_onload();}} </script>"   
         @gml_initialised ||= true
      end  
      result
  end 
  
end