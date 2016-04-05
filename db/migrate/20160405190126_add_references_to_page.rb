class AddReferencesToPage < ActiveRecord::Migration
  def change
  	add_column :pages, :user_id, :integer, references: :users
  end
end
