require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get products_new_url
    assert_response :success
  end

  test 'should get create' do
    get products_create_url
    assert_response :success
  end

  test 'should get destroy' do
    get products_destroy_url
    assert_response :success
  end
end
