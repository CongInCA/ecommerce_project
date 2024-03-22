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


# Use csb to create Categories

csv_file_path = '/Users/captainchenn/Desktop/3011 ruby/Data_project/ecommerce_project/Category.csv'
CSV.foreach(csv_file_path, headers: true) do |row|
  Category.find_or_create_by(name: row['Name'], description: row['Description'])
end

# Create Products

100.times do
    Faker::Config.locale = 'en'
    product = Product.create(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price,
      category_id: Category.pluck(:id).sample
    )
    
    # search_terms = product.name.downcase.split(/\s+/).join(',')
    # response = URI.open("https://api.unsplash.com/photos/random?query=#{search_terms}&client_id=El6ZyuhqcDfDXiqyvcYm-VUVWZYGGqz5UvxeOnEfEWY")
    # data = JSON.parse(response.read)
    # image_url = data['urls']['regular']
    
    # response = URI.open(image_url)
    # product.image.attach(io: response, filename: "#{product.name.parameterize(separator: '_')}.jpg")

    # Use image name as search key word to get the picture.
    # image_name = product.name.downcase.gsub(' ', '_')
    # image_url = Faker::LoremFlickr.image(size: "300x300", search_terms: [image_name])
    
    # # Download image and attach to the product.
    # response = URI.open(image_url)
    # product.image.attach(io: response, filename: "#{image_name}.jpg")

end