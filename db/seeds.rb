require 'random_data'

14.times do
    User.create!(
        email: RandomData.random_email,
        password: RandomData.random_password,
        confirmed_at: Date.today
    )
end

# test user
User.create!(email: 'test@t.com', password: 'testing', confirmed_at: Date.today)

users = User.all

30.times do
    Wiki.create!(
        user: users.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
end

puts "Seed finished."
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."