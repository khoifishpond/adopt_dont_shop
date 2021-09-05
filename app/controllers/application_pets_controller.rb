class ApplicationPetsController < ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    app = Application.find(params[:application_id])
    ApplicationPet.create!(pet: pet, application: app)
    redirect_to "/applications/#{app.id}"
  end
end