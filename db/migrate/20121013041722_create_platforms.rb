class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.string :url
      t.string :name
      t.string :logo_url

      t.timestamps
    end
  end
end
