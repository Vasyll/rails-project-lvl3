# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    email = auth[:info][:email].downcase
    existing_user = User.find_by(email: email)

    redirect_to root_path if existing_user

    user = User.new name: auth[:info][:name], email: auth[:info][:email]

    if user.save
      sign_in user
      redirect_to root_path, notice: 'Успешно' # t('.success')
    else
      redirect_to root_path, alert: 'Что-то пошло не так....' # t('.failure')
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
