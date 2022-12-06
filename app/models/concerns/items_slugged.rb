#Whitelist additional fields for devise User objects.
module ItemsSlugged
     extend ActiveSupport::Concern

     #
     included do
      
        extend FriendlyId
            friendly_id :title, use: :slugged
            validates :title, :user_id, :slug, presence: true
     end

    

  ################## SLUG ###############  
  def should_generate_new_friendly_id?
   title_changed?
  end

end
