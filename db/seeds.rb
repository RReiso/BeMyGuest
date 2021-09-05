# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(name:  "Example User",
             email: "a@a.lv",
             password:              "11111111",
             password_confirmation: "11111111",
             admin:     true,
            )

user2 = User.create!(name:  "Second User",
             email: "b@b.lv",
             password:              "11111111",
             password_confirmation: "11111111",
             admin:     false,
            )


users = [user1, user2]
            name = ["Grandma's birthday","Graduation", "House party", "Wedding", "Disco"]
            place = ['My home', "Central Park", "Big Al's Restaurant", "at Cindy's", "Beach"]
            tasks = ['Buy a cake', 'Order food', 'Invite guests', 'Find a band', 'Get a haircut']

        2.times do |n|
5.times do |i|
  users[n].events.create!(name: name[i],
                      event_date: "2021-#{rand(11)+1}-#{rand(30)+1}",
                      event_time: "2021-10-09 #{rand(20)+1}:#{[00,30,45].sample}:00 UTC",
                    place: place[i])

  users[n].events.first.tasks.create!(description: tasks[i])
end
end