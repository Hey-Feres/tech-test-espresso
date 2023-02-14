class AddMfaToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :multi_factor_authenticable, :boolean
  end
end
