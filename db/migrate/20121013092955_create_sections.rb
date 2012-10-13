class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :chapter
      t.string :title
      t.integer :exercise_count
      t.date :due_date

      t.timestamps
    end
  end
end
