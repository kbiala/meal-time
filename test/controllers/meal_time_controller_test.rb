require 'test_helper'

class MealTimeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get meal_time_index_url
    assert_response :success
  end

end
