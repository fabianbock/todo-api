# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.find_or_initialize_by(
  name:     'Admin User',
  email:    'admin@example.com'
)
admin.save!

list_one = List.create(user: admin, title: "My first List")

first_task = Task.create(list: list_one, title: "My first task")

puts 'Seed finished'