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
require 'csv'
require 'json'

AdminUser.find_or_create_by(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end if Rails.env.development?



# Create Pages
Page.find_or_create_by(title: 'About') do |page|
    page.content = 'EcoInnovate Store is a brand new e-commerce site. It dedicates to promote and sell environmentally friendly products developed by youth-led climate action innovation projects and other people who want to protect the environment and make some changes. We sell different second-hand products. They are great value and very reliable. Our goal is to become a leading platform for climate action and environmental sustainability solutions.'
  end
  
  Page.find_or_create_by(title: 'Contact') do |page|
    page.content = 'Contact us: cchen7@rrc.ca'
  end


# Use csv to create Categories
csv_file_path = '/Users/captainchenn/Desktop/3011 ruby/Data_project/ecommerce_project/Category.csv'
CSV.foreach(csv_file_path, headers: true) do |row|
  Category.find_or_create_by(name: row['Name'], description: row['Description'])
end

# Create 10 real products
Category.find_by(name: 'Electronics').products.create(
  name: 'iPhone 13',
  description: 'The latest iPhone model with advanced features.',
  price: 999.99,
  category_id: Category.find_by(name: 'Electronics').id
)
Category.find_by(name: 'Electronics').products.create(
  name: 'Samsung Galaxy Watch',
  description: 'A smartwatch with fitness tracking and health monitoring features.',
  price: 299.99,
  category_id: Category.find_by(name: 'Electronics').id
)

Category.find_by(name: 'Clothing').products.create(
  name: 'Adidas Ultraboost Shoes',
  description: 'Running shoes with responsive cushioning for a smooth run.',
  price: 149.99,
  category_id: Category.find_by(name: 'Clothing').id
)
Category.find_by(name: 'Clothing').products.create(
  name: 'Levi\'s 501 Jeans',
  description: 'Classic jeans with a straight fit and durable denim construction.',
  price: 59.99,
  category_id: Category.find_by(name: 'Clothing').id
)

Category.find_by(name: 'Home & Kitchen').products.create(
  name: 'Instant Pot Duo',
  description: 'A multi-functional pressure cooker for quick and easy cooking.',
  price: 79.99,
  category_id: Category.find_by(name: 'Home & Kitchen').id
)
Category.find_by(name: 'Home & Kitchen').products.create(
  name: 'Cuisinart Coffee Maker',
  description: 'An automatic coffee maker with programmable brewing options.',
  price: 129.99,
  category_id: Category.find_by(name: 'Home & Kitchen').id
)

Category.find_by(name: 'Books').products.create(
  name: 'The Great Gatsby',
  description: 'A classic novel by F. Scott Fitzgerald.',
  price: 12.99,
  category_id: Category.find_by(name: 'Books').id
)
Category.find_by(name: 'Books').products.create(
  name: 'Harry Potter and the Philosopher\'s Stone',
  description: 'The first book in the Harry Potter series by J.K. Rowling.',
  price: 9.99,
  category_id: Category.find_by(name: 'Books').id
)

Category.find_by(name: 'Furniture').products.create(
  name: 'IKEA Hemnes Bed Frame',
  description: 'A sturdy and stylish bed frame with storage drawers.',
  price: 299.99,
  category_id: Category.find_by(name: 'Furniture').id
)
Category.find_by(name: 'Furniture').products.create(
  name: 'West Elm Mid-Century Dresser',
  description: 'A mid-century modern dresser with sleek design.',
  price: 499.99,
  category_id: Category.find_by(name: 'Furniture').id
)

# Create 100 fake Products
Category.all.each do |category|
    100.times do
      Faker::Config.locale = 'en'
      product = Product.create(
        name: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price,
        category_id: category.id
      )
    end
  end


# Create province's rate data

provinces_data = [
{ name: 'Alberta', gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
{ name: 'British Columbia', gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.00 },
{ name: 'Manitoba', gst_rate: 0.05, pst_rate: 0.07, hst_rate: 0.00 },
{ name: 'New Brunswick', gst_rate: 0.00, pst_rate: 0.00, hst_rate: 0.15 },
{ name: 'Newfoundland and Labrador', gst_rate: 0.00, pst_rate: 0.00, hst_rate: 0.15 },
{ name: 'Nova Scotia', gst_rate: 0.00, pst_rate: 0.00, hst_rate: 0.15 },
{ name: 'Ontario', gst_rate: 0.00, pst_rate: 0.00, hst_rate: 0.13 },
{ name: 'Prince Edward Island', gst_rate: 0.00, pst_rate: 0.00, hst_rate: 0.15 },
{ name: 'Quebec', gst_rate: 0.05, pst_rate: 0.09975, hst_rate: 0.00 },
{ name: 'Saskatchewan', gst_rate: 0.05, pst_rate: 0.06, hst_rate: 0.00 },
{ name: 'Northwest Territories', gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
{ name: 'Nunavut', gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 },
{ name: 'Yukon', gst_rate: 0.05, pst_rate: 0.00, hst_rate: 0.00 }
]

provinces_data.each do |province_data|
  Province.create!(province_data)
end