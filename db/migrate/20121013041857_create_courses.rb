class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :platform_id
      t.string :title
      t.text :description
      t.string :url
      t.string :logo_url

      t.timestamps
    end
  end
end
