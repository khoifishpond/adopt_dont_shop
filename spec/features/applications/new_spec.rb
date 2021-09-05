require 'rails_helper'

describe 'new application page' do
  it 'has a new application form' do
    visit '/applications/new'

    fill_in :name, with: "Robert Smith"
    fill_in :street, with: "1111 Cure"
    fill_in :city, with: "Sad Face"
    fill_in :state, with: "CA"
    fill_in :zipcode, with: 90909

    click_on "Submit"
    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("#{Application.last.name}")
    expect(page).to have_content("#{Application.last.street}")
    expect(page).to have_content("#{Application.last.city}")
    expect(page).to have_content("#{Application.last.state}")
    expect(page).to have_content("#{Application.last.zipcode}")
  end

  it 'displays an error message' do
    visit '/applications/new'

    fill_in :name, with: "Robert Smith"
    # fill_in :street, with: "1111 Cure"
    # fill_in :city, with: "Sad Face"
    fill_in :state, with: "CA"
    fill_in :zipcode, with: 90909

    click_on "Submit"
    expect(page).to have_content("Error: Street can't be blank, City can't be blank")
  end
end