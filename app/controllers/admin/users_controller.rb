class Admin::UsersController < Admin::AdminSiteController
  hobo_user_controller
  auto_actions :all
end