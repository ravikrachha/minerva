require 'test_helper'

class JournelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get journels_index_url
    assert_response :success
  end

  test "should get show" do
    get journels_show_url
    assert_response :success
  end

  test "should get create" do
    get journels_create_url
    assert_response :success
  end

end
