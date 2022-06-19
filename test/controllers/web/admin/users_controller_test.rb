# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:two)
    @attrs = {
      name: Faker::Name.name,
      email: Faker::Internet.email
    }
  end

  test 'guest cant edit user' do
    get edit_admin_user_path @user
    assert_redirected_to root_path
  end

  test 'guest cant update user' do
    patch admin_user_path(@user), params: { user: @attrs }
    assert_redirected_to root_path

    user = User.find_by @user.attributes
    assert user
  end

  test 'guest cant destroy user' do
    delete admin_user_path(@user)
    assert_redirected_to root_path

    user = User.find_by @user.attributes
    assert user
  end
end
