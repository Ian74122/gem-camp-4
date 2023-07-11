class CreateAddressProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :address_provinces do |t|
      t.string :code
      t.string :name
      t.belongs_to :region
      t.timestamps
    end
  end
end
