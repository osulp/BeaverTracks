class BuildingsController < ApplicationController


  def index
    @title = "Building List"

    @buildings = Buildings.list
  end

  def show
    @building = Buildings.find(params[:id])

    @title = @building.name


    require 'flickraw'

    FlickRaw.api_key = ENV["BEAVERTRACKS_FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["BEAVERTRACKS_FLICKR_SECRET"]

    @flickr_user_id = ENV["BEAVERTRACKS_FLICKR_USER_ID"]

    @photos = flickr.photos.search :user_id => @flickr_user_id, :tags => @building.flickr_tag
    @photos = @photos.sort_by {|a| a.title}
  end

  def image
    @building = Buildings.find(params[:id])

    @title = @building.name + " - Large Image"
  end
end
