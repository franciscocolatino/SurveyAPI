class Question < ApplicationRecord
  belongs_to :survey
  has_many :answer

  enum type_question: { text: 0, radio: 1, checkbox: 2 }

  TYPE_QUESTION = {
    "text" => "Texto",
    "radio" => "Botão de seleção",
    "checkbox" => "Caixa de seleção"
  }.freeze
end
