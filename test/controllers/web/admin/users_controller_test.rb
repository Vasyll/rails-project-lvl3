# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:two)
    @attrs = {
      admin: true
    }
  end

  test 'guest cant edit user' do
    get edit_admin_user_path @user
    assert_redirected_to root_path
  end

  test 'user cant edit user' do
    sign_in @user
    get edit_admin_user_path @user
    assert_redirected_to root_path
  end

  test 'admin can edit user' do
    sign_in @admin
    get edit_admin_user_path @user
    assert_response :success
  end

  test 'admin can update user' do
    sign_in @admin

    assert_not @user.admin?
    patch admin_user_path(@user), params: { user: @attrs }

    @user.reload
    assert @user.admin?
    assert_redirected_to admin_users_path
  end

  test 'admin can destroy user' do
    sign_in @admin

    delete admin_user_path(@user)

    assert { !User.find_by @user.attributes }
    assert_redirected_to admin_users_path
  end
end
