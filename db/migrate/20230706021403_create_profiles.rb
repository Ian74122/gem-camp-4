class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.date :birthday
      t.string :legal_name
      t.string :location
      t.string :education
      t.string :occupation
      t.text :bio
      t.text :specialty
      t.timestamps
    end
  end
end
