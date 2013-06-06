# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
gem 'flickr_fu', '= 0.3.0'
require 'flickr_fu'
class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
 
 def flickr_id
   return '27497198@N08'
 end
  
  
 
 #return nearby buildings
 #@param obj = nearby this object
   def nearby(obj)
    return Building.find(:all, :origin => obj, :within => 1, :limit => 4, :order=>'distance')
  end
  
  
end
