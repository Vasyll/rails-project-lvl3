# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  def show
    authorize Bulletin, policy_class: ProfilePolicy

    @q = Bulletin.where(user_id: current_user.id).ransack(params[:q])
    @bulletins = @q.result.page(params[:page])
  end
end
