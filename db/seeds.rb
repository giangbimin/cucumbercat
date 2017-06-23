gender = %w(male female)
4.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    avatar_url: Faker::Avatar.image,
    gender: gender[rand(2)],
    password: '1234567'
  )
end
4.times do
  Chanel.create(avatar_url: Faker::Avatar.image)
end
chanels = Chanel.pluck(:id).uniq
users = User.pluck(:id).uniq
User.all.each do |user|
  user.user_chanels.create(chanel_id: chanels[rand(Chanel.count)])
end
users.each do |user|
  UserChanel.create(user_id: user, chanel_id: chanels[rand(Chanel.count)])
end
