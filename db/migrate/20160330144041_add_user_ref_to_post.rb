class AddUserRefToPost < ActiveRecord::Migration
  def change
  	change_column :posts, :user_id, :integer, references: :users
  end
end
