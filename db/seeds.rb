User.create!(name: 'admin', email: 'admin@gmail.com', password: "12345678", gender:'male')

10.times do
  User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: "12345678", gender: 'male')
end

User.all.each do |user|
  recipient = User.all.sample
  conversation = user.conversations.create(recipient: recipient)
  Message.create(conversation: conversation, user: user, body: Faker::Lorem.sentence)
  Message.create(conversation: conversation, user: recipient, body: Faker::Lorem.sentence)
end
