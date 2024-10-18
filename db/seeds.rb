# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
api_handler = ApiHandler.new('f0703cdc-5429-4f8e-bfb5-bb3f1c19a3b2', '89ab7a35-c473-4d20-bcca-df1f6e9136ed') # KEYS should not be hardcoded
@amounts = api_handler.fetch_amount
Account.create(balance: @amounts)
