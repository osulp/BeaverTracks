# RailsAdmin config file. Generated on September 12, 2013 08:50
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Require authentication before reaching Admin Dashboard
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method &:current_user

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Beavertracks', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['Buildings']

  # Include specific models (exclude the others):
  # config.included_models = ['Buildings']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:

  config.model 'User' do                                                                                                        
    list do                                                                                                                     
      field :email                                                                                                              
      field :last_sign_in_at                                                                                                    
    end                                                                                                                         
    edit do                                                                                                                     
      field :email                                                                                                              
      field :password                                                                                                           
      field :password_confirmation                                                                                              
    end                                                                                                                         
                                                                                                                                
  end     


  ###  Buildings  ###

  # config.model 'Buildings' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your buildings.rb model definition

  #   # Found associations:



  #   # Found columns:

  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :description, :text 
  #     configure :flickr_thumb_url, :string 
  #     configure :flickr_orig_url, :string 
  #     configure :flickr_tag, :string 
  #     configure :search_tags, :string 
  #     configure :lat, :float 
  #     configure :lng, :float 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:

  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!

  #   # Section specific configuration:

  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
