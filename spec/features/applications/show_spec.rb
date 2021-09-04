require 'rails_helper'

describe 'applications show page' do
  describe 'applications submitted' do
    before(:each) do
      @shelter = Shelter.create!(
        name: "A Shelter",
        foster_program: true,
        city: "A City",
        rank: 5
      )
      @pet_1 = @shelter.pets.create!(
        name: "Pet Name",
        age: 3,
        breed: "Pet Breed",
        adoptable: true
      )
      @pet_2 = @shelter.pets.create!(
        name: "Another Pet Name",
        age: 6,
        breed: "Another Pet Breed",
        adoptable: true
      )
      @app = Application.create!(
        name: "Your Name",
        street: "1234 Your Street",
        city: "Your City",
        state: "YS",
        zipcode: 99999,
        description: "Your description of why you'd be a good home.",
        status: "Your Status"
      )
      ApplicationPet.create!(pet: @pet_1, application: @app)
      ApplicationPet.create!(pet: @pet_2, application: @app)
    end
    it 'shows application attributes' do
      visit "/applications/#{@app.id}"
    
      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.street)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zipcode)
      expect(page).to have_content(@app.description)
      expect(page).to have_content(@app.status)
      expect(has_link?("#{@pet_1.name}")).to eq(true)
      expect(page).to have_content(@pet_1.name)
      expect(has_link?("#{@pet_2.name}")).to eq(true)
      expect(page).to have_content(@pet_2.name)
    end
  end

  describe 'applications not submitted' do
    before(:each) do
      @shelter = Shelter.create!(
        name: "A Shelter",
        foster_program: true,
        city: "A City",
        rank: 5
      )
      @pet_1 = @shelter.pets.create!(
        name: "Bob",
        age: 3,
        breed: "Pet Breed",
        adoptable: true
      )
      @pet_2 = @shelter.pets.create!(
        name: "Dodo",
        age: 6,
        breed: "Another Pet Breed",
        adoptable: true
      )
      @app = Application.create!(
        name: "Your Name",
        street: "1234 Your Street",
        city: "Your City",
        state: "YS",
        zipcode: 99999,
        description: "Your description of why you'd be a good home.",
        status: "Your Status"
      )
    end

    it 'searches for pets for an application' do
      visit "/applications/#{@app.id}"

      expect(page).to have_content("Add a Pet to this Application")

      fill_in :search, with: "#{@pet_1.name}"
      click_button "Search Pet"

      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to_not have_content("#{@pet_2.name}")
    end
  end
end