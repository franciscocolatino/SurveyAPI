class Survey < ApplicationRecord
  belongs_to :user
  has_many :question
  has_many :answer
end
