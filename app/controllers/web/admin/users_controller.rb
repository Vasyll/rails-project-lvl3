# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.all
  end
end
