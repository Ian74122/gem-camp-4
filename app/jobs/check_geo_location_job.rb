class CheckGeoLocationJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find post_id
    if post.ip_address
      geo_location = Geocoder.search(post.ip_address).first
      post.country = geo_location.country
      post.region = geo_location.region
      post.city = geo_location.city
      post.save
    end
  end
end
