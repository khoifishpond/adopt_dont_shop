# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
Application.destroy_all
ApplicationPet.destroy_all

shelters = FactoryBot.create_list(:shelter, 3)

FactoryBot.create_list(:pet, 5, shelter: shelters[0])
FactoryBot.create_list(:pet, 10, shelter: shelters[1])
FactoryBot.create_list(:pet, 8, shelter: shelters[2])
FactoryBot.create_list(:application, 2)