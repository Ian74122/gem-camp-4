# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
(3..10).to_a.sample.times do
  user = User.create(email: Faker::Internet.email, password: 'qwer4321')
  puts "create user : #{user.email}"
end

(20..40).to_a.sample.times do
  post = Post.create(title: Faker::Lorem.sentence(word_count: 3),
                     content: Faker::Lorem.paragraph,
                     user: User.all.sample)
  puts "create post id #{post.id}"
  (5..20).to_a.sample.times do
    comment = post.comments.create(content: Faker::Lorem.sentence(word_count: 6), user: User.all.sample)
    puts "create comment id #{comment.id}"
  end
end
