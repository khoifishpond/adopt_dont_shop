require 'rails_helper'

describe 'admin shelter index page' do
  before(:each) do
    @shelters = create_list(:shelter, 3)
    create_list(:pet, 5, shelter: @shelters[0])
    create_list(:pet, 4, shelter: @shelters[1])
    create_list(:pet, 7, shelter: @shelters[2])
    create(:application)
  end
  
  it 'sorts shelters alphabetically in reverse' do
    visit "/admin/shelters"

    names = [@shelters[0].name, @shelters[1].name, @shelters[2].name].sort

    expect(names[2]).to appear_before(names[1])
    expect(names[1]).to appear_before(names[0])
  end
end