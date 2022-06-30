# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    email = auth[:info][:email].downcase
    user = User.find_or_initialize_by(email: email)
    user.name = auth[:info][:name]

    if user.save
      sign_in user
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, alert: t('.failure')
    end
  end

  def logout
    sign_out
    redirect_to root_path, notice: t('.success')
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
