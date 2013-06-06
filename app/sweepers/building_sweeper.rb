class BuildingSweeper < ActionController::Caching::Sweeper
  observe Building
  
  def after_save(building)
    expire_cache(building)
  end
  
  def after_destroy(building)
    expire_cache(building)
  end
  
  def expire_cache(building)
  expire_fragment(%r{/building/*})
  end
  
end
  
  