require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  
  test "guessing WIN results correctly" do
    match = matches(:home_win)
    assert_equal('W', match.guess_result)
  end

  test "guessing LOSS results correctly" do
    match = matches(:away_win)
    assert_equal(match.result, match.guess_result)
  end
end
