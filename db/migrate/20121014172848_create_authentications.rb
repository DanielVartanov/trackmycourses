class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :account
      t.string :provider
      t.string :uid
      t.string :nickname

      t.timestamps
    end

    remove_column :accounts, :uid
    remove_column :accounts, :twitter_username
  end
end
