# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.where state: :under_moderation
  end
end
