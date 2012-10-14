class AddAuthToAccount < ActiveRecord::Migration
  def change
    change_table(:accounts) do |t|
      t.string :uid
      t.string :twitter_username
    end
  end
end
