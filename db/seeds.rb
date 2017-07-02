require 'random_data'

11.times do
    User.create!(
        name: RandomData.random_name,
        email: RandomData.random_email,
        password: RandomData.random_password,
        confirmed_at: Date.today
    )
end

3.times do
    User.create!(
        name: RandomData.random_name,
        email: RandomData.random_email,
        password: RandomData.random_password,
        role: :premium,
        confirmed_at: Date.today
    )
end

# test user
User.create!(name: 'Test User', email: 'test@t.com', password: 'testing', role: :premium, confirmed_at: Date.today)

users = User.all

# this doesn't work as User.where(role: :premium)
premium_users = User.where(role: 1)

30.times do
    Wiki.create!(
        user: users.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
end

10.times do
    Wiki.create!(
        user: premium_users.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        private: true
    )
end

puts "Seed finished."

# this doesn't work as User.where(role: :standard) or User.where(role: :premium)
puts "#{User.where(role: 0).size} standard users created."
puts "#{User.where(role: 1).size} premium users created."
puts "#{User.count} total users created."

puts "#{Wiki.where(private: false).size} public wikis created."
puts "#{Wiki.where(private: true).size} private wikis created."
puts "#{Wiki.count} total wikis created."
