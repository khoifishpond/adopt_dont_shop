require 'rails_helper'

describe 'applications index page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application = Application.create!(name: "Khoi Nguyen",  street: "1234 My Street", city: "My City", state: "YS", zipcode: 99999, description: "I'm a God", status: "Pending")

    ApplicationPet.create!(pet: @pet_1, application: @application)
  end
  
  it 'shows all applications' do
    visit '/applications'
    save_and_open_page
    expect(page).to have_content(@application.name)
    expect(page).to have_link("#{@application.name}")
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zipcode)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
    expect(has_link?("#{@pet_1.name}")).to eq(true)
    expect(page).to have_content(@pet_1.name)
  end
end