# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'

AdminUser.find_or_create_by(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end if Rails.env.development?

# Create Categories
Category.create(name: 'Electronics')
Category.create(name: 'Clothing')
Category.create(name: 'Home & Kitchen')
Category.create(name: 'Books')
Category.create(name: 'Furniture')
Category.create(name: 'Toys')
Category.create(name: 'Sporting Goods')
Category.create(name: 'Tools')
Category.create(name: 'Musical Instruments')
Category.create(name: 'Jewelry')

# Create Products

100.times do
  # En doesn't work.
  Faker::Config.locale = 'en'
  product = Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price,
    category_id: Category.pluck(:id).sample
  )
  # Use image name as search key word to get the picture.
  image_name = product.name.downcase.gsub(' ', '_')
  image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: [image_name])
  
  # Download image and attach to the product.
  response = URI.open(image_url)
  product.image.attach(io: response, filename: "#{image_name}.jpg")
end