require "test_helper"

class EventUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get user:references" do
    get event_users_user:references_url
    assert_response :success
  end

  test "should get event:references" do
    get event_users_event:references_url
    assert_response :success
  end
end
