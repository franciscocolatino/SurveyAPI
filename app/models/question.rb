class Question < ApplicationRecord
  belongs_to :survey

  validates :type_question, inclusion: { in: %w[text radio checkbox] }
end
