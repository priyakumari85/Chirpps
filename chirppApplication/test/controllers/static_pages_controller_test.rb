require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  def setup
    @base_title = "ChirppApplication"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

end
