require "test_helper"

class EventUsersControllerTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should get user:references" do
    get event_users_user:references_url
    assert_response :success
  end

  test "should get event:references" do
    get event_users_event:references_url
    assert_response :success
  end
>>>>>>> 52ddb007db23d5f9acebebcf1bd7047c1c8faaa0
end
