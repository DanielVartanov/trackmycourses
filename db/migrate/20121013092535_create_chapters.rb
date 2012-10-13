class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :course
      t.string :title

      t.timestamps
    end
  end
end
