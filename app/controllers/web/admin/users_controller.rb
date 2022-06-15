# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('.success')
    else
      render :edit, alert: t('.failure')
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to admin_users_path, notice: t('.success')
    else
      redirect_to admin_users_path, alert: t('.failure')
    end
  end

  private

  def user_params
    params.required(:user).permit(:admin)
  end
end
