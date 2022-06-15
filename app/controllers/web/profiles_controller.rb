# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  def show
    @q = Bulletin.where(user_id: current_user.id).ransack(params[:q])
    @bulletins = @q.result
  end
end
