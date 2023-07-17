class AddIpAddressInPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :ip_address, :string
    add_column :posts, :country, :string
    add_column :posts, :region, :string
    add_column :posts, :city, :string
  end
end
