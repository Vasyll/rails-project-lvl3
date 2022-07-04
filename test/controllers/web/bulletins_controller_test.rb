# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
    @other_user_bulletin = bulletins(:two)
    @user = users(:user)
    @attrs = {
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph_by_chars(number: 200),
      category_id: categories(:one).id,
      image: fixture_file_upload('bulletin_4.jpg', 'image/jpg')
    }
  end

  test 'should get bulletins index' do
    get bulletins_path
    assert_response :success
  end

  test 'signin user can show draft bulletin' do
    sign_in @user
    get bulletin_path @bulletin
    assert_response :success
  end

  test 'signin user can new bulletin' do
    sign_in @user
    get new_bulletin_path
    assert_response :success
  end

  test 'signed user can create bulletin' do
    sign_in @user
    post bulletins_path, params: { bulletin: @attrs }
    bulletin = Bulletin.find_by @attrs.except(:image)
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end

  test 'signin user can edit his bulletin' do
    sign_in @user
    get edit_bulletin_path @bulletin
    assert_response :success
  end

  test 'signed user cant edit not his bulletin' do
    sign_in @user
    get edit_bulletin_path @other_user_bulletin
    assert_redirected_to root_path
  end

  test 'signed user can update his bulletin' do
    sign_in @user
    patch bulletin_path(@bulletin), params: { bulletin: @attrs }
    bulletin = Bulletin.find_by @attrs.except(:image)
    assert { bulletin }
    assert_redirected_to bulletin_url(bulletin)
  end

  test 'signed user cant update not his bulletin' do
    sign_in @user
    patch bulletin_path(@other_user_bulletin), params: { bulletin: @attrs }
    assert_redirected_to root_path
    bulletin = Bulletin.find_by @other_user_bulletin.attributes
    assert { bulletin }
  end

  test 'signed user can to moderate his bulletin' do
    sign_in @user
    patch to_moderate_bulletin_path(@bulletin)
    @bulletin.reload
    assert { @bulletin.under_moderation? }
    assert_redirected_to profile_path
  end

  test 'signed user cant to moderate not his bulletin' do
    sign_in @user
    patch to_moderate_bulletin_path(@other_user_bulletin)
    @other_user_bulletin.reload
    assert { @other_user_bulletin.draft? }
  end

  test 'signed user can archive his bulletin' do
    sign_in @user
    patch archive_bulletin_path(@bulletin)
    @bulletin.reload
    assert { @bulletin.archived? }
    assert_redirected_to profile_path
  end

  test 'signed user cant archive not his bulletin' do
    sign_in @user
    patch archive_bulletin_path(@other_user_bulletin)
    @other_user_bulletin.reload
    assert { @other_user_bulletin.draft? }
  end
end
