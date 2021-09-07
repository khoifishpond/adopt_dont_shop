require 'rails_helper'

describe 'admin applications show page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application_1 = Application.create!(name: "Khoi Nguyen", street: "1234 My Street", city: "My City", state: "YS", zipcode: 99999, description: "I'm a God", status: "Pending")
    @application_2 = Application.create!(name: "Duy Nguyen", street: "3214 My Street", city: "His City", state: "HS", zipcode: 88888, description: "He's a God", status: "Pending")

    ApplicationPet.create!(pet: @pet_1, application: @application_1)
    ApplicationPet.create!(pet: @pet_2, application: @application_1)
    ApplicationPet.create!(pet: @pet_1, application: @application_2)
  end

  it 'can approve a pet for adoption' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      expect(has_button?("Approve")).to eq(true)
      
      click_button "Approve"

      expect(has_content?("Approved")).to eq(true)
      expect(has_button?("Approve")).to eq(false)
    end

    within("#pet-#{@pet_2.id}") do
      expect(has_button?("Approve")).to eq(true)
    end
  end

  it 'can reject a pet for adoption' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      expect(has_button?("Approve")).to eq(true)
      expect(has_button?("Reject")).to eq(true)
      
      click_button "Approve"

      expect(has_content?("Approved")).to eq(true)
      expect(has_button?("Approve")).to eq(false)
      expect(has_button?("Reject")).to eq(false)
    end

    within("#pet-#{@pet_2.id}") do
      expect(has_button?("Approve")).to eq(true)
      expect(has_button?("Reject")).to eq(true)
      
      click_button "Reject"

      expect(has_content?("Rejected")).to eq(true)
      expect(has_button?("Approve")).to eq(false)
      expect(has_button?("Reject")).to eq(false)
    end
  end

  it 'updates the status of a pet on one application and not another' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      click_button "Approve"
      expect(has_content?("Approved")).to eq(true)
    end

    visit "/admin/applications/#{@application_2.id}"

    within("#pet-#{@pet_1.id}") do
      expect(has_button?("Approve")).to eq(true)
      expect(has_button?("Reject")).to eq(true)
    end
  end
end