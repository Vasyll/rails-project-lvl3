# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  def index
    @bulletins = Bulletin.where user_id: current_user.id
  end
end
