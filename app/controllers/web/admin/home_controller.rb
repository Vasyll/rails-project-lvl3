# frozen_string_literal: true

class Web::Admin::HomeController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.all
  end
end