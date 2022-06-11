# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
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
    bulletins_count = Bulletin.count

    post bulletins_path, params: { bulletin: @attrs }

    assert { Bulletin.count == bulletins_count }
    assert_redirected_to root_path
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

  test 'guest cant update bulletin' do
    patch bulletin_path(@bulletin), params: { bulletin: @attrs }

    bulletin = Bulletin.find_by @bulletin.attributes
    assert bulletin

    assert_redirected_to root_path
  end

  test 'signed user can update bulletin' do
    sign_in @user

    patch bulletin_path(@bulletin), params: { bulletin: @attrs }

    bulletin = Bulletin.find_by @attrs.except(:image)
    assert bulletin

    assert_redirected_to bulletin_url(bulletin)
  end
end
