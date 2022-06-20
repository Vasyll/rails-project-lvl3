# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:two)
    @bulletin = bulletins(:three)
  end

  test 'admin can get bulletins index' do
    sign_in @admin
    get admin_bulletins_path
    assert_response :success
  end

  test 'admin can publish bulletin' do
    sign_in @admin
    patch publish_admin_bulletin_path(@bulletin)
    @bulletin.reload
    assert @bulletin.published?
    assert_redirected_to admin_root_path
  end

  test 'admin can reject bulletin' do
    sign_in @admin
    patch reject_admin_bulletin_path(@bulletin)
    @bulletin.reload
    assert @bulletin.rejected?
    assert_redirected_to admin_root_path
  end

  test 'admin can archive bulletin' do
    sign_in @admin
    patch archive_admin_bulletin_path(@bulletin)
    @bulletin.reload
    assert @bulletin.archived?
    assert_redirected_to admin_root_path
  end
end
