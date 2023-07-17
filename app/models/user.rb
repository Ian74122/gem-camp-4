class User < ApplicationRecord
  audited
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_one :profile

  accepts_nested_attributes_for :profile

  enum genre: { client: 0, admin: 1 }
  validates :phone_number, phone: {
    possible: true,
    allow_blank: true,
    types: %i[voip mobile],
    countries: [:ph]
  }
  before_validation :clear_phone_number_mark

  def clear_phone_number_mark
    self.phone_number = phone_number.gsub(/-/, '')
  end
end
