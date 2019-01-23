require 'test_helper'

class StaticControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get static_controller_index_url
    assert_response :success
  end

end
