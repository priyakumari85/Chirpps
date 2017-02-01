require 'test_helper'

class ChirppTest < ActiveSupport::TestCase
  def setup
    @user_profile_id = chirpps(:one)
    @chirpp = Chirpp.new(content: @user_profile_id.content, user_profile_id: @user_profile_id.id)
  end

  test "should be valid" do
    assert @chirpp.valid?
  end

  test "user profile id should be present" do
    @chirpp.user_profile_id = nil
    assert_not @chirpp.valid?
  end

  test "content should be present" do
    @chirpp.content = '   '
    assert_not @chirpp.valid?
  end

  test "content should be at most 140 characters" do
    @chirpp.content = "a" * 141
    assert_not @chirpp.valid?
  end

  test "order should be most recent first" do
    assert_equal chirpps(:latest), Chirpp.first
  end
end
