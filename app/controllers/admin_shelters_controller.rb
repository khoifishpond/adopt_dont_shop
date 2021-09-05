class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_shelter_order
    @pending = Shelter.pending_applications
  end
end