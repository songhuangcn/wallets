require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validate balance" do
    user = users.first
    [-1, 0].each do |invalid_balance|
      user.update(balance: -1)
      assert_not user.valid?
      assert_includes user.errors, :balance
    end
  end

  test "#deposit!" do
    user = users.first
    assert_difference "user.balance", 100 do
      assert_difference "user.transaction_histories.count" do
        user.deposit!(100)
      end
    end
    assert_equal ["deposit", 100], user.transaction_histories.last.values_at(:kind, :money)
  end

  test "#withdraw!" do
    user = users.first
    assert_difference "user.balance", -100 do
      assert_difference "user.transaction_histories.count" do
        user.withdraw!(100)
      end
    end
    assert_equal ["withdraw", 100], user.transaction_histories.last.values_at(:kind, :money)
  end

  test "#transfer!" do
    user_one = users.first
    user_two = users.second
    assert_difference "user_one.balance", -100 do
      assert_difference "user_two.balance", +100 do
        assert_difference "user_one.transaction_histories.count" do
          assert_difference "user_two.transaction_histories.count" do
            user_one.transfer!(user_two, 100)
          end
        end
      end
    end
    assert_equal ["transfer", -100], user_one.transaction_histories.last.values_at(:kind, :money)
    assert_equal ["transfer", +100], user_two.transaction_histories.last.values_at(:kind, :money)
  end
end
