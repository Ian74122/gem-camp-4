class Post < ApplicationRecord
  audited
  default_scope { where(deleted_at: nil) }
  scope :hot_posts, -> { order(comments_count: :desc).limit(3) }
  scope :filter_by_title, -> (title) { where(title: title) }
  scope :filter_by_content, -> (content) { where(content: content) }
  validates :title, presence: true
  validates :content, presence: true

  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  has_one :post_count_preview
  belongs_to :user
  belongs_to :genre
  mount_uploader :image, ImageUploader
  delegate :email, to: :user

  after_create :check_geo_location
  def destroy
    update(deleted_at: Time.current)
  end

  def check_geo_location
    CheckGeoLocationJob.perform_later(id)
  end

  def comments_count
    post_count_preview.count
  end
end
