class AddNotifyWithTwitterToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :twitter_notify, :boolean, default: false
  end
end
