require 'test_helper'

class MemosControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get memos_show_url
    assert_response :success
  end

end
