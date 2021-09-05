class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_shelter_order
  end
end