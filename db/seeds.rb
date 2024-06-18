# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

# Clear existing data
Product.destroy_all
Category.destroy_all

# Seed categories and products from CSV
csv_file = Rails.root.join('db', 'products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

products.each do |row|
  category_name = row['category_name'].strip

  # Find or create category
  category = Category.find_or_create_by(name: category_name)

  # Create product associated with the category
  Product.create!(
    title: row['title'],
    description: row['description'],
    price: row['price'].to_d,
    stock_quantity: row['stock_quantity'].to_i,
    category: category
  )
end