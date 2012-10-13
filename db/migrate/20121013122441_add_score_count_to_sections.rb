class AddScoreCountToSections < ActiveRecord::Migration
  def change
    add_column :sections, :score_count, :integer
  end
end
