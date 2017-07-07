require 'faker'

11.times do
    user_name = Faker::GameOfThrones.character
    User.create!(
        name: user_name,
        email: Faker::Internet.safe_email(user_name),
        password: Faker::Internet.password(8, 12),
        confirmed_at: Faker::Date.between(30.days.ago, Date.today)
    )
end

3.times do
    premium_name = Faker::LordOfTheRings.character
    User.create!(
        name: premium_name,
        email: Faker::Internet.safe_email(premium_name),
        password: Faker::Internet.password(8, 12),
        role: :premium,
        confirmed_at: Faker::Date.between(30.days.ago, Date.today)
    )
end

# test user
User.create!(name: 'Test User', email: 'test@t.com', password: 'testing', role: :premium, confirmed_at: Date.today)

users = User.all
premium_users = User.where(role: 1) # this doesn't work as User.where(role: :premium)

# For seeding with markdown, because Faker::Markdown is not yet released.
markdown_array = ['**', '*', '`', '```', '==', '~~', '_']

30.times do
    markdown_body = Faker::Hipster.paragraph
    4.times do
        mark = markdown_array.sample
        markdown_body += ' ' + '<br /><br />' + ' '
        markdown_body += mark
        markdown_body += Faker::Hipster.paragraph
        markdown_body += mark
    end
    Wiki.create!(
        user: users.sample,
        title: Faker::Hipster.sentence,
        body: markdown_body,
        created_at: Faker::Date.between(30.days.ago, Date.today)
    )
end

10.times do
    premium_md = Faker::Hipster.paragraph
    4.times do
        mark = markdown_array.sample
        premium_md += ' ' + '<br /><br />' + ' '
        premium_md += mark
        premium_md += Faker::Hipster.paragraph
        premium_md += mark
    end
    Wiki.create!(
        user: premium_users.sample,
        title: Faker::Hipster.sentence,
        body: premium_md,
        private: true,
        created_at: Faker::Date.between(30.days.ago, Date.today)
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
