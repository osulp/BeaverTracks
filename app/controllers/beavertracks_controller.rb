class BeavertracksController < ApplicationController
  def index
    @title = 'Home'
    @disable_header = 'true'
  end

  def about
    @title = 'About'
  end

  def instructions
    @title = 'About Tour'
  end
end
