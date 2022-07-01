# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
  end

  test 'admin can get admin root' do
    sign_in @admin
    get admin_root_path
    assert_response :success
  end
end
