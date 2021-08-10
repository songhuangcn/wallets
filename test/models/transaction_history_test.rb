require "test_helper"

class TransactionHistoryTest < ActiveSupport::TestCase
  test "validate_money_with_kind_deposit" do
    th = transaction_histories(:deposit)
    [-1, 0].each do |invalid_money|
      th.update(kind: :deposit, money: invalid_money)
      assert_not th.valid?
      assert_includes th.errors, :money
    end

    [1, 100].each do |valid_money|
      th.update(kind: :deposit, money: valid_money)
      assert th.valid?
    end
  end

  test "validate_money_with_kind_withdraw" do
    th = transaction_histories(:withdraw)
    [-1, 0].each do |invalid_money|
      th.update(kind: :withdraw, money: invalid_money)
      assert_not th.valid?
      assert_includes th.errors, :money
    end

    [1, 100].each do |valid_money|
      th.update(kind: :withdraw, money: valid_money)
      assert th.valid?
    end
  end

  test "validate_money_with_kind_transfer" do
    th = transaction_histories(:transfer)
    [0].each do |invalid_money|
      th.update(kind: :transfer, money: invalid_money)
      assert_not th.valid?
      assert_includes th.errors, :money
    end

    [-10, 100].each do |valid_money|
      th.update(kind: :transfer, money: valid_money)
      assert th.valid?
    end
  end
end
