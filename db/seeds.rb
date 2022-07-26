# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def assign_avatar!(user, index)
  filename = "#{index}.jpg"
  path = Rails.root.join('app/assets/images/seed avatars', filename)
  File.open(path) do |io|
    user.avatar.attach(io: io, filename: filename)
  end
end

@users = []

names = [
  'Cole Owens',
  'Bennett Ramirez',
  'Sung Vaughan',
  'Bernadine Petersen',
  'Omer Fry',
  'Theresa Cohen',
  'Nichole Hayes',
  'Chuck Dawson',
  'Charlotte Ortiz',
  'Tracie Lam',
  'Tim Aguirre',
  'Tanya Curtis',
  'Al House',
  'Donte Ware',
  'Ann Cook',
  'Joy Franco',
  'Reuben Bradford',
  'Arlen Goodwin',
  'Meghan Harding',
  'Clinton May',
  'Rob Chan',
  'Dale Johnson',
  'Franklin Gentry',
  'Clay Camacho',
  'Morgan Luna',
  'Lyndon Moran',
  'Graig Valdez',
  'Hyman Clark',
  'Brigitte Farley',
  'Tomas Mcclain'
]

names.each_with_index do |name, index|
  date = Faker::Date.between(from: 2.years.ago, to: Date.today)
  user = User.create(username: name, email: "#{name.delete(' ')}@example.com", password: 'password', created_at: date)
  assign_avatar!(user, index + 1)
  @users << user
end

posts = []
180.times do |i|
  date = Faker::Date.between(from: 2.years.ago, to: Date.today)
  body = case i
         when 0..36 then Faker::GreekPhilosophers.quote
         when 37..72 then Faker::Quotes::Shakespeare.hamlet_quote
         when 73..108 then Faker::Quotes::Shakespeare.as_you_like_it_quote
         when 109..144 then Faker::Quotes::Shakespeare.king_richard_iii_quote
         else Faker::Quotes::Shakespeare.romeo_and_juliet_quote
         end
  posts << Post.create!(
    body: body,
    user_id: (@users[rand(@users.length)]).id,
    created_at: date,
    updated_at: date
  )
end

user_indices = User.all.ids
user_indices.length.times do |i|
  user_indices_shuffle = user_indices.shuffle
  (user_indices.length / 3).times do
    Invitation.create!(user_id: user_indices[i], friend_id: user_indices_shuffle.sample, confirmed: true)
  end
end
