class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
        :trackable, :authentication_keys => [:logged]



  #RELATIONS
  has_many :levels, class_name: "Level", foreign_key: "user_id", dependent: :destroy
  has_many :materials, class_name: "Material", foreign_key: "user_id", dependent: :destroy
  has_many :schools, class_name: "School", foreign_key: "user_id", dependent: :destroy
  has_many :citytowns, class_name: "Citytown", foreign_key: "user_id", dependent: :destroy
  has_many :courses, class_name: "Course", foreign_key: "user_id", dependent: :destroy
  has_many :exercises, class_name: "Exercise", foreign_key: "user_id", dependent: :destroy
  has_many :result, class_name: "Result", foreign_key: "user_id", dependent: :destroy
  has_one :avatar
  
  
  #enum :role, student: "student", teacher: "teacher", team: "team", default: "student"
  
  
  before_validation :strip_custom_data
  before_validation :strip_contact
  before_validation :full_name
  
   validates :first_name, :last_name, :full_name, :email, :password,
              :contact, :user_role, :city_name, presence: true

   validates :contact, uniqueness: true, numericality: { only_integer: true }, length: { is:10,
              message: "%{ value} verifier votre nom numéro est 10 chiffres"}
 
              
   validates :user_role, inclusion: { in: %w(Student Teacher Team Ambassador),
                    message: "%{value} acces non identifier" }
                    
                    
  ################  Custom data of User ###########
  def strip_custom_data
    if self.user_role == "Student"
      self.matricule = matricule.gsub(/\s+/, "")
      self.email = "#{self.matricule}@gmail.com"
      self.school_name = school_name.strip.downcase.capitalize
      self.password = "#{self.contact}"
    else 
      self.matricule = "#{self.contact}T"
    end
  end

  ################  Contact ###########
  def strip_contact
    self.contact = contact.gsub(/\s+/, "")
  end


  ################  Full name ###########
  def full_name
    self.full_name = "#{self.first_name} #{self.last_name}" 
  end 

################## SLUG ###############
  extend FriendlyId
  friendly_id :user_slugged, use: :slugged
  
  def user_slugged
    [
      :full_name,
    [:full_name, :contact]
    ]
  end
  ################## END SLUGGED #########

  ################## BEFORE SAVE  #########
  before_save do
    self.contact            = contact.strip.squeeze("")
    self.first_name         = first_name.strip.squeeze("").downcase.capitalize
    self.last_name          = last_name.strip.squeeze("").downcase.capitalize
    self.city_name          = city_name.downcase.capitalize
    self.matricule          = matricule.downcase
  end


   attr_writer :logged
  
  ################## LOGGED  #########
  #permet la connexion avec le matricule
  def logged
    @logged || self.matricule || self.email
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (logged = conditions.delete(:logged))
      where(conditions.to_h).where(["lower(email) = :value OR lower(matricule) = :value", { :value => logged.downcase }]).first
    elsif conditions.has_key?(:email) || conditions.has_key?(:matricule)
      where(conditions.to_h).first
    end
  end
  
  ################## End Logged  #########

end
