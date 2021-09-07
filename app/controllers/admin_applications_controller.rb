class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
  end

  def update
    application_id = params[:application_id]
    pet_id = params[:pet_id]
    status = params[:status]
    application_pet = ApplicationPet.find_application(
      application_id,
      pet_id
    )
    application_pet.update(status: status)

    redirect_to "/admin/applications/#{application_id}"
  end
end