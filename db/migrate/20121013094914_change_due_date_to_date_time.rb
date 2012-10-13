class ChangeDueDateToDateTime < ActiveRecord::Migration
  def change
    change_table(:sections) do |t|
      t.change :due_date, :datetime
    end
  end
end
