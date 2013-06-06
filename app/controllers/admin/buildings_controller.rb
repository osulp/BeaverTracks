class Admin::BuildingsController < Admin::AdminSiteController
  hobo_model_controller Building
  auto_actions :all
  cache_sweeper :building_sweeper, :only =>[:create, :update, :destroy]
end