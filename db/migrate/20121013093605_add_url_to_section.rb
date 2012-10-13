class AddUrlToSection < ActiveRecord::Migration
  def change
    change_table :sections do |t|
      t.string :url
    end
  end
end
