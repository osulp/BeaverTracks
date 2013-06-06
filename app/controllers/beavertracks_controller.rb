class BeavertracksController < ApplicationController
layout 'template'

def index
  @meta_keywords = @title = @meta_description = 'Home'
  expire_fragment(%r{/*/})
end

def about
   @meta_keywords = @title = @meta_description = 'About'
end

def intructions
   @meta_keywords = @title = @meta_description = 'About Tour'
end

end
