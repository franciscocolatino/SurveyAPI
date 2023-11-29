class Question < ApplicationRecord
  belongs_to :survey
  has_many :answer

  # validates :type_question, inclusion: { in: %w[text radio checkbox] }
  enum type_question: {
    text: 0,
    radio: 1,
    checkbox: 2
  }

end
