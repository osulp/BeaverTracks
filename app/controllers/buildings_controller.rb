class BuildingsController < ApplicationController

  def index
    @title = "Building List"

    @buildings = Buildings.list
  end

  def show
    @building = Buildings.find(params[:id])

    @title = @building.name

    FlickRaw.api_key = ENV["BEAVERTRACKS_FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["BEAVERTRACKS_FLICKR_SECRET"]

    @flickr_user_id = ENV["BEAVERTRACKS_FLICKR_USER_ID"]

    @photos = flickr.photos.search :user_id => @flickr_user_id, :tags => @building.flickr_tag
    @photos = @photos.sort_by {|a| a.title}
  end

  def flickr_view
    @building = Buildings.find(params[:id])
    @title = @building.name

    @flickr_photo_id = params[:flickr_photo_id]
    # TEST/SECURE - retrieve Flickr info based on ID

    @photo = flickr.photos.getInfo :photo_id => @flickr_photo_id
  end

  def image
    @building = Buildings.find(params[:id])

    @title = @building.name + " - Large Image"
  end
end
