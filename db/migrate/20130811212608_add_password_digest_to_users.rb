class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    # attr_accessor :password, :password_confirmation
    # attr_accessible :password, :password_confirmation
  end
end
