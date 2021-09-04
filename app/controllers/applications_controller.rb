class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    if params[:pet_id]
      @pet = Pet.find(params[:pet_id])
      ApplicationPet.create(pet: @pet, application: @application)
    elsif params[:search]
      @pets = Pet.search(params[:search])
    end
  end

  def new
    
  end

  def create
    application = Application.create(application_params)
    
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private

  def application_params
    params
      .permit(:name, :street, :city, :state, :zipcode)
      .with_defaults(status: "In Progress")
  end
end