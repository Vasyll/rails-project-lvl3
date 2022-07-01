# frozen_string_literal: true

require 'test_helper'

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user)
  end

  test 'signed user can show profile' do
    sign_in @user

    get profile_path
    assert_response :success
  end

  test 'guest cant show profile' do
    get profile_path
    assert_redirected_to root_path
  end
end
