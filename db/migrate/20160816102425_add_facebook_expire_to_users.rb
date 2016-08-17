class AddFacebookExpireToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :token_expire, :integer
  end
end
