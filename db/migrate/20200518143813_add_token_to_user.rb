class AddTokenToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :authentication_token, :text
    add_column :users, :authentication_token_created_at, :datetime
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    add_index :users, :authentication_token, unique: true
  end
end
