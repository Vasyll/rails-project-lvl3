# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  def show
    authorize Bulletin, policy_class: ProfilePolicy

    @q = current_user.bulletins.order(created_at: :desc).ransack(params[:q])
    @bulletins = @q.result.page(params[:page])
  end
end
