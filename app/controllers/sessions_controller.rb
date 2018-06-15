# frozen_string_literal: true

# Sessions Controller
class SessionsController < Devise::SessionsController
  respond_to :html, :json, :js

  def create
    @employee = Employee.find_by(email: params[:employee][:email])
    if @employee
      if @employee.valid_password?(params[:employee][:password])
      else
        respond_to do |format|
          format.html { render}
          format.js { render}
          format.json {render }
        end
      end
    else
      respond_to do |format|
        format.html { render}
        format.js { render}
        format.json {render }
      end
    end
  end
end
