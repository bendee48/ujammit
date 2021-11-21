class AddExpirationColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :access_token_expiration, :datetime
  end
end
