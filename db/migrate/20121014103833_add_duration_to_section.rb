class AddDurationToSection < ActiveRecord::Migration
  def change
    add_column :sections, :duration, :integer
    rename_column :sections, :exercise_count, :practice_count
    add_column :sections, :type, :string
  end
end
