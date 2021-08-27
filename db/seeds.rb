# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create a main sample user.
User.create!(name: "Example User",
email: "example@user.lv",
password: "11111111",
password_confirmation: "11111111",
admin: true,
activated: true,
activated_at: Time.zone.now)