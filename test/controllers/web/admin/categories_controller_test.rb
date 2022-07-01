# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @category = categories(:one)
    @attrs = {
      name: Faker::Book.title
    }
  end

  test 'admin can get categories index' do
    sign_in @admin
    get admin_categories_path
    assert_response :success
  end

  test 'admin can get new category' do
    sign_in @admin
    get new_admin_category_path
    assert_response :success
  end

  test 'admin can create category' do
    sign_in @admin
    post admin_categories_path, params: { category: @attrs }
    category = Category.find_by @attrs
    assert { category }
    assert_redirected_to admin_categories_path
  end

  def edit
    sign_in @admin
    get edit_admin_category_path(@category)
    assert_response :success
  end

  def update
    sign_in @admin
    patch admin_category_path, params: { category: @attrs }
    category = Category.find_by @attrs
    assert { category }
    assert_redirected_to admin_categories_path
  end

  def destroy
    sign_in @admin
    delete admin_category_path(@category)

    assert { !Category.find_by @category.attributes }
    assert_redirected_to admin_categories_path
  end
end
