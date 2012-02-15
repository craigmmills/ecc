# RailsAdmin config file. Generated on February 15, 2012 13:26
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_user } # auto-generated
  
  # If you want to track changes on your models:
  # config.audit_with :history, User
  
  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, User
  
  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Ecc', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  config.model Venue do
      edit do
        field :opposition
        field :matches
        field :name
        field :venue_lat, :map do
          longitude_field :venue_lng
          default_latitude 52  
          default_longitude 0
        end
      end
    end
  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Match, News, Opposition, OurTeam, Player, User, Venue]

  # Add models here if you want to go 'whitelist mode':
  # config.included_models = [Match, News, Opposition, OurTeam, Player, User, Venue]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Match do
  #   # Found associations:
  #     configure :our_team, :belongs_to_association 
  #     configure :opposition, :belongs_to_association 
  #     configure :venue, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :our_team_id, :integer         # Hidden 
  #     configure :opposition_id, :integer         # Hidden 
  #     configure :our_runs, :string 
  #     configure :opposition_runs, :string 
  #     configure :venue_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :match_date, :date 
  #     configure :our_wickets, :integer 
  #     configure :opposition_wickets, :integer 
  #     configure :result, :string 
  #     configure :url, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model News do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :title, :string 
  #     configure :description, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :pics_file_name, :string         # Hidden 
  #     configure :pics_content_type, :string         # Hidden 
  #     configure :pics_file_size, :integer         # Hidden 
  #     configure :pics_updated_at, :datetime         # Hidden 
  #     configure :pics, :paperclip   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Opposition do
  #   # Found associations:
  #     configure :venue, :belongs_to_association 
  #     configure :matches, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :venue_id, :integer         # Hidden 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model OurTeam do
  #   # Found associations:
  #     configure :matches, :has_many_association 
  #     configure :players, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Player do
  #   # Found associations:
  #     configure :our_teams, :has_and_belongs_to_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :email, :string 
  #     configure :description, :string 
  #     configure :mob_num, :string 
  #     configure :home_num, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :avatar_file_name, :string         # Hidden 
  #     configure :avatar_content_type, :string         # Hidden 
  #     configure :avatar_file_size, :integer         # Hidden 
  #     configure :avatar_updated_at, :datetime         # Hidden 
  #     configure :avatar, :paperclip 
  #     configure :url, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Venue do
  #   # Found associations:
  #     configure :opposition, :has_many_association 
  #     configure :matches, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :venue_lat, :decimal 
  #     configure :venue_lng, :decimal 
  #     configure :conditions, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :name, :string   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
