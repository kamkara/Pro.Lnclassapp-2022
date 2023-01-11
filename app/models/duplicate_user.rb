class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
        :trackable, :authentication_keys => [:logged]



 ##############  Relations   #################
  has_many :levels, class_name: "Level", foreign_key: "user_id", dependent: :destroy
  has_many :materials, class_name: "Material", foreign_key: "user_id", dependent: :destroy
  has_many :schools, class_name: "School", foreign_key: "user_id", dependent: :destroy
  has_many :citytowns, class_name: "Citytown", foreign_key: "user_id", dependent: :destroy
  has_many :courses, class_name: "Course", foreign_key: "user_id", dependent: :destroy
  has_many :exercises, class_name: "Exercise", foreign_key: "user_id", dependent: :destroy
  has_many :result, class_name: "Result", foreign_key: "user_id", dependent: :destroy
  has_one :avatar
  



 ##############  Before validation   #################
 before_validation :strip_fields, :normalize_fields, :downcase_fields
  before_validation :strip_matricule_number
  before_validation :strip_phone_number
  before_validation :user_validations?,  on: :create
  before_validation :full_name
  

  def strip_phone_number
    self.contact = contact.gsub(/\s+/, "").strip
  end
  def strip_matricule_number
    self.matricule = matricule.gsub(/\s+/, "").strip
  end

  def strip_fields
    self.email = email.strip
    self.first_name = first_name.strip
    self.last_name = last_name.strip
  end

  def normalize_fields
    self.email = email.unicode_normalize(:nfkc).encode('ASCII', replace: '').downcase
    self.first_name = first_name.unicode_normalize(:nfkc).encode('ASCII', replace: '').capitalize
    self.last_name = last_name.unicode_normalize(:nfkc).encode('ASCII', replace: '').capitalize
    self.city_name = city_name.unicode_normalize(:nfkc).encode('ASCII', replace: '').capitalize
  end

  def downcase_fields
    self.country = country.downcase
  end

  def user_validations?
    if self.user_role != "Student"
      #User is Teacher, Admin or other persons
      self.matricule = "#{self.contact}T"
    else 
      self.email = "#{self.matricule}@gmail.com"
      self.password = "#{self.contact}"
    end    
  end

  def full_name
    self.full_name = "#{self.first_name} #{self.last_name}" 
  end 

  ##############  Validations   #################
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 18 }


  ################## SLUGGED ###############
  extend FriendlyId
  friendly_id :user_slugged, use: :slugged
  
  def user_slugged
    [
      :full_name,
    [:full_name, :contact]
    ]
  end
  ################## END SLUGGED #########

  
end