# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

3.times do
  Category.create(
    name: Faker::Commerce.vendor
  )
end

User.create(name: 'Vyacheslav Ryzhov', email: 'chju@mail.ru', admin: true)
User.create(name: 'Test 1', email: 'test1@mail.ru', admin: false)
User.create(name: 'Test 2', email: 'test2@mail.ru', admin: true)

90.times do
  bulletin = Bulletin.new(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraphs.join("\n\n"),
    user_id: [1, 2, 3].sample,
    category_id: [1, 2, 3].sample,
    state: Bulletin.aasm.states.map(&:name).sample
  )
  bulletin.image.attach(io: File.open(Rails.root.join('test/fixtures/files/bulletin_4.jpg')), filename: 'bulletin_4.jpg', content_type: 'image/jpeg')
  bulletin.save
end
