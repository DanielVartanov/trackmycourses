class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :course
      t.references :account
      t.timestamps
    end
  end
end
