class Question < ApplicationRecord
  belongs_to :survey
  has_many :answer
  
  validates :type_question, inclusion: { in: %w[text radio checkbox] }
end
