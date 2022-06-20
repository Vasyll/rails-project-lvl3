# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:two)
  end

  test 'admin can should get index' do
    sign_in @admin
    get admin_root_path
    assert_response :success
  end
end
