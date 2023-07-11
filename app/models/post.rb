class Post < ApplicationRecord
  default_scope { where(deleted_at: nil) }
  scope :hot_posts, -> { order(comments_count: :desc).limit(3) }
  scope :filter_by_title, -> (title) { where(title: title) }
  scope :filter_by_content, -> (content) { where(content: content) }
  validates :title, presence: true
  validates :content, presence: true

  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  belongs_to :user
  belongs_to :genre
  mount_uploader :image, ImageUploader

  def destroy
    update(deleted_at: Time.current)
  end
end
