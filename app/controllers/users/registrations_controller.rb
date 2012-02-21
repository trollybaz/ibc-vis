class Users::RegistrationsController < Devise::RegistrationsController
  def create
    head :forbidden
  end
end
