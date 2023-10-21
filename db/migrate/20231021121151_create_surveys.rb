class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.string :title
      t.string :closed
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
