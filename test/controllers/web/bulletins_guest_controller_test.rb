# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsGuestControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulletin = bulletins(:one)
  end

  test 'guest cant show draft bulletin' do
    get bulletin_path @bulletin
    assert_redirected_to root_path
  end

  test 'guest can new bulletin' do
    get new_bulletin_path
    assert_redirected_to root_path
  end

  test 'guest cant create bulletin' do
    assert_no_difference('Bulletin.count') do
      post bulletins_path, params: { bulletin: @attrs }
      assert_redirected_to root_path
    end
  end

  test 'guest cant edit bulletin' do
    get edit_bulletin_path @bulletin
    assert_redirected_to root_path
  end

  test 'guest cant update bulletin' do
    patch bulletin_path(@bulletin), params: { bulletin: @attrs }
    assert_redirected_to root_path
    bulletin = Bulletin.find_by @bulletin.attributes
    assert { bulletin }
  end

  test 'guest cant to moderate bulletin' do
    patch to_moderate_bulletin_path(@bulletin)
    assert_redirected_to root_path
    @bulletin.reload
    assert { @bulletin.draft? }
  end

  test 'guest cant archive bulletin' do
    patch archive_bulletin_path(@bulletin)
    assert_redirected_to root_path
    @bulletin.reload
    assert { @bulletin.draft? }
  end
end
