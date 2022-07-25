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
  user = User.create(username: name, email: "#{name.delete(' ')}@example.com", password: 'password')
  assign_avatar!(user, index + 1)
end
