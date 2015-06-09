require 'test_helper'

class Admin::MenuclientesControllerTest < ActionController::TestCase
  test "should get indedx" do
    get :indedx
    assert_response :success
  end

end
