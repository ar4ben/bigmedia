# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
AdminUser.first.add_role :super_admin
cat = Category.create!(name:'test_cat')

(0..30).each do |id|
  cat.articles.create!(title: "test_post#{id}", body: "lorem ipsum", published: true)
end