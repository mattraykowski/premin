# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(email: "matt.raykowski@gmail.com", name: "Matt Raykowski", account_name: "My Demo School", account_subdomain: "demo", password: "changeme", password_confirmation: "changeme")
