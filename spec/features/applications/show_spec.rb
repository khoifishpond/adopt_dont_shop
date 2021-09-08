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
      @application = Application.create!(
        name: "Your Name",
        street: "1234 Your Street",
        city: "Your City",
        state: "YS",
        zipcode: 99999,
        description: "Your description of why you'd be a good home.",
        status: "Your Status"
      )
      ApplicationPet.create!(pet: @pet_1, application: @application)
      ApplicationPet.create!(pet: @pet_2, application: @application)
    end
    it 'shows application attributes' do
      visit "/applications/#{@application.id}"
      
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.street)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zipcode)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@application.status)
      expect(has_link?("#{@pet_1.name}")).to eq(true)
      expect(page).to have_content(@pet_1.name)
      expect(has_link?("#{@pet_2.name}")).to eq(true)
      expect(page).to have_content(@pet_2.name)
    end
  end

  describe 'applications not submitted' do
    before(:each) do
      @shelter = create(:shelter)
      @pet_1 = create(:pet, shelter: @shelter)
      @pet_2 = create(:pet, shelter: @shelter)
      @application = create(:application)

      visit "/applications/#{@application.id}"
    end

    it 'searches for pets for an application' do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in :search, with: "#{@pet_1.name}"
      click_button "Search"

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to_not have_content("#{@pet_2.name}")
    end

    it 'it has a button to adopt pet' do
      fill_in :search, with: "#{@pet_1.name}"
      click_button "Search"

      expect(page).to have_button("Adopt this Pet")
      
      click_button "Adopt this Pet"

      within("#pet-#{@pet_1.id}") do
        expect(has_link?("#{@pet_1.name}")).to eq(true)
      end
      
      expect(current_path).to eq("/applications/#{@application.id}")
    end

    it 'has a button to submit an application' do
      expect(page).to_not have_button("Submit")

      fill_in :search, with: "#{@pet_1.name}"
      click_button "Search"
      click_button "Adopt this Pet"
      fill_in :search, with: "#{@pet_2.name}"
      click_button "Search"
      click_button "Adopt this Pet"
      
      expect(page).to have_button("Submit")

      fill_in :description, with: "Because I'm rich"
      click_button "Submit"

      expect(page).to_not have_content("Add a Pet to this Applicaiton")
    end
  end
end