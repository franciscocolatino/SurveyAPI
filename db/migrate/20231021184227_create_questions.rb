class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :type_question
      t.string :options_answer, array: true, default: []
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end
