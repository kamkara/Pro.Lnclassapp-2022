class Material < ApplicationRecord
  belongs_to :user
  has_one_attached :materialIcon

  
  #Slugged concern
  include ItemsSlugged
end
