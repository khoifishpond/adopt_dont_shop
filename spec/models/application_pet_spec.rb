require 'rails_helper'

describe ApplicationPet do
  describe 'relationships' do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  describe 'class methods' do
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
      @application = Application.create!(
        name: "Your Name",
        street: "1234 Your Street",
        city: "Your City",
        state: "YS",
        zipcode: 99999,
        description: "Your description of why you'd be a good home.",
        status: "Your Status"
      )
      @application_pet = ApplicationPet.create!(pet: @pet_1, application: @application)
    end
    
    it '#find_applications' do
      expect(ApplicationPet.find_application(@application.id, @pet_1.id)).to eq(@application_pet)
    end
  end
end