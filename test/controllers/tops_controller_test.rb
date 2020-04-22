require 'test_helper'

class TopsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    get tops_index_url
    assert_response :success
  end
end
