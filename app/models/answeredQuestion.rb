class AnsweredQuestion < ApplicationRecord
  belongs_to :answer, optional: true
  belongs_to :question
  belongs_to :result

  accepts_nested_attributes_for :answer
  accepts_nested_attributes_for :question
end
