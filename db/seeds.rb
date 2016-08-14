# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
orders = []
orders << Order.create(name: 'order1')
orders << Order.create(name: 'order2')
orders << Order.create(name: 'order3')
orders << Order.create(name: 'order4')

users = []
users << User.create(name: 'user1')
users << User.create(name: 'user2')
users << User.create(name: 'user3')
users << User.create(name: 'user4')

meals = []
meals << Meal.create(name: 'meal1', price: '1', order: orders.sample, user: users.sample)
meals << Meal.create(name: 'meal2', price: '2', order: orders.sample, user: users.sample)
meals << Meal.create(name: 'meal3', price: '3', order: orders.sample, user: users.sample)
meals << Meal.create(name: 'meal4', price: '4', order: orders.sample, user: users.sample)
