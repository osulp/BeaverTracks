class BuildingsController < ApplicationController
  def index
    @title = 'Building List'

    @buildings = Buildings.list
  end

  def show
    @building = Buildings.find(params[:id])

    @title = @building.name

    begin
      @photos = flickr.photos.search user_id: @flickr_user_id, tags: @building.flickr_tag
      @photos = @photos.sort_by { |a| a.title }
    rescue => ex
      logger.error ex.message
    end
  end

  def flickr_view
    @building = Buildings.find(params[:id])
    @title = @building.name

    @flickr_photo_id = params[:flickr_photo_id]

    begin
      @photo = flickr.photos.getInfo photo_id: @flickr_photo_id
    rescue => ex
      logger.error ex.message
    end
  end

  def image
    @building = Buildings.find(params[:id])

    @title = @building.name + ' - Large Image'
  end
end
