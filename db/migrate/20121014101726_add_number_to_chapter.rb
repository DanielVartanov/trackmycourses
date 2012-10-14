class AddNumberToChapter < ActiveRecord::Migration
  def change
    add_column :chapters, :number, :integer
  end
end
