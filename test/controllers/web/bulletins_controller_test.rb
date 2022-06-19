# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @bulletin_user2 = bulletins(:two)
    @user = users(:one)
    @attrs = {
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph_by_chars(number: 200),
      category_id: categories(:one).id,
      image: fixture_file_upload('bulletin_4.jpg', 'image/jpg')
    }
  end

  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should show bulletin' do
    get bulletin_path @bulletin
    assert_response :success
  end

  test 'guest should raise error from new' do
    get new_bulletin_path
    assert_redirected_to root_path
  end

  test 'signin user should get new' do
    sign_in @user
    get new_bulletin_path
    assert_response :success
  end

  test 'guest cant create bulletin' do
    assert_no_difference('Bulletin.count') do
      post bulletins_path, params: { bulletin: @attrs }
      assert_redirected_to root_path
    end
  end

  test 'signed user can create bulletin' do
    sign_in @user

    post bulletins_path, params: { bulletin: @attrs }

    bulletin = Bulletin.find_by @attrs.except(:image)
    assert bulletin

    assert_redirected_to bulletin_url(bulletin)
  end

  test 'guest should raise error from edit' do
    get edit_bulletin_path @bulletin
    assert_redirected_to root_path
  end

  test 'signin user should get edit' do
    sign_in @user
    get edit_bulletin_path @bulletin
    assert_response :success
  end

  test 'signed user cant edit not his bulletin' do
    sign_in @user
    get edit_bulletin_path @bulletin_user2
    assert_redirected_to root_path
  end

  test 'guest cant update bulletin' do
    patch bulletin_path(@bulletin), params: { bulletin: @attrs }
    assert_redirected_to root_path

    bulletin = Bulletin.find_by @bulletin.attributes
    assert bulletin
  end

  test 'signed user can update his bulletin' do
    sign_in @user
    patch bulletin_path(@bulletin), params: { bulletin: @attrs }

    bulletin = Bulletin.find_by @attrs.except(:image)
    assert bulletin

    assert_redirected_to bulletin_url(bulletin)
  end

  test 'signed user cant update not his bulletin' do
    sign_in @user

    patch bulletin_path(@bulletin_user2), params: { bulletin: @attrs }
    assert_redirected_to root_path

    bulletin = Bulletin.find_by @bulletin_user2.attributes
    assert bulletin
  end

  test 'guest cant to moderate bulletin' do
    patch to_moderate_bulletin_path(@bulletin)
    assert_redirected_to root_path

    bulletin = Bulletin.find_by @bulletin.attributes
    assert bulletin.draft?
  end

#  test 'signed user can to moderate his bulletin' do
#    sign_in @user
#
#    patch to_moderate_bulletin_path(@bulletin)
#
#    bulletin = Bulletin.find_by @bulletin.attributes
#    assert bulletin.under_moderation?
#
#    assert_redirected_to profile_path
#  end

  test 'signed user cant to moderate not his bulletin' do
    sign_in @user

    patch to_moderate_bulletin_path(@bulletin_user2)

    bulletin = Bulletin.find_by @bulletin_user2.attributes
    assert bulletin.draft?
  end

  test 'guest cant archive bulletin' do
    patch archive_bulletin_path(@bulletin)
    assert_redirected_to root_path

    bulletin = Bulletin.find_by @bulletin.attributes
    assert bulletin.draft?
  end

#  test 'signed user can archive his bulletin' do
#    sign_in @user
#
#    patch archive_bulletin_path(@bulletin)
#
#    bulletin = Bulletin.find_by @bulletin.attributes
#    assert bulletin.archived?
#
#    assert_redirected_to profile_path
#  end

  test 'signed user cant archive not his bulletin' do
    sign_in @user

    patch archive_bulletin_path(@bulletin_user2)

    bulletin = Bulletin.find_by @bulletin_user2.attributes
    assert bulletin.draft?
  end
end

