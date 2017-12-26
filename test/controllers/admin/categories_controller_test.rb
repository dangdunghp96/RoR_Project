require 'test_helper'

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get admin_categories_create_url
    assert_response :success
  end

end
