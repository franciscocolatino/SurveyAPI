class AddDeadlineToSurveys < ActiveRecord::Migration[7.0]
  def change
    add_column :surveys, :deadline, :datetime
  end
end
