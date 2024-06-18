# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require "csv" 

# Seed categories
categories = {}

CSV.foreach(Rails.root.join('db', 'products.csv'), headers: true) do |row|
  category_name = row['category_name'].strip
  unless categories.key?(category_name)
    categories[category_name] = Category.create!(name: category_name)
  end

  Product.create!(
    title: row['title'],
    description: row['description'],
    price: row['price'].to_d,
    stock_quantity: row['stock_quantity'].to_i,
    category: categories[category_name]
  )
end