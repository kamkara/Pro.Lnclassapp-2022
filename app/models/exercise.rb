class Exercise < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_rich_text :content
  has_rich_text :correction

  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
  

  ########## VALIDATIONS  #############
  validates :title, :slug, :user_id, :content, :correction, :course_id, presence: true


  ########## SCOPES  #############
  scope :feed_exercise, -> {order(created_at: :desc).limit(2)}
  
  
  ########### completed exercice  #########
  def completed_by(user)
    results.any? {|result| result.user == user}
  end
  
  ########### user grade  #########
  def user_grade(user)
    results.where(user_id: user).last.grade()
  end

    
  ############ Result ###################
  def build_result
    result = self.results.build()
    self.questions.each {|question| result.answered_questions.build(question: question)}
    return result
  end
  
  ########## SLUG  #############
  extend FriendlyId
    friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    title_changed?
  end
  
end
