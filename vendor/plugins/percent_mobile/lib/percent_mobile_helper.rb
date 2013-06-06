require 'action_view'

module ActionView
  module Helpers
    module PercentMobileHelper
  
      PERCENT_MOBILE_COOKIE_PATH="/"
      PERCENT_MOBILE_VISIT_DURATION=60*60
      PERCENT_MOBILE_VERSION="rails_12152009"
      PERCENT_MOBILE_COOKIE_NAME="_percent_mobile_c"

      def percent_mobile_track(id,url="")
        percent_mobile_u=new_random
        percent_mobile_v=new_random

        if cookies[:PERCENT_MOBILE_COOKIE_NAME] and cookies[:PERCENT_MOBILE_COOKIE_NAME]=~/(\d+)[01]_(\d+)_(\d+)[01]/
        	percent_mobile_u=$1+"0";
        	percent_mobile_v=$3+"0" if $2.to_i>Time.new().to_i
      	end    
      	cookies[:PERCENT_MOBILE_COOKIE_NAME]={
      	  :value=>percent_mobile_u+'_'+(Time.new().to_i+PERCENT_MOBILE_VISIT_DURATION).to_s+'_'+percent_mobile_v,
      	  :expires=>1.year.from_now,
      	  :path=>PERCENT_MOBILE_COOKIE_PATH
      	  }
        subdomain=""
        # for _subdomain in request.subdomains 
        #   subdomain+=_subdomain+"." 
        # end         
        url = request.protocol+subdomain+request.host+request.request_uri if url==""

        referer=""        
        referer = request.env["HTTP_REFERER"] if request.env["HTTP_REFERER"]

        image_url="#{request.protocol}tracking.percentmobile.com/pixel/#{id}/#{rand(0xffff)}.gif?v=#{PERCENT_MOBILE_VERSION}&us=#{percent_mobile_u}&vi=#{percent_mobile_v}&url=#{CGI::escape(url)}&referer=#{CGI::escape(referer)}";			

        if request.env["HTTP_USER_AGENT"] and request.env["HTTP_USER_AGENT"]=~/iPhone/
          return "<script type='text/javascript'>
        	<!--
        	{
        		var percentmobile_t=new Date().getTime();	
        		var percentmobile_s=0;
        		while(new Date().getTime()-percentmobile_t<20)
        		{
        			Math.random();
        			percentmobile_s++;
        		}
        		new Image().src='#{image_url}&m='+((percentmobile_s>1000)?'3gs':'2g3g');
        	}
        	-->
        	</script>"
      	else
      	  return "<img src='#{image_url.gsub('&','&amp;')}' width='2' height='2' alt='.' />";
    	  end
      end

      private
      def new_random
        rand(2147583646).to_s+"1"
      end
    end
  end
end

ActionView::Base.class_eval do
  include ActionView::Helpers::PercentMobileHelper
end
