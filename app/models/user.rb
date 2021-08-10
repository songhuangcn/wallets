class User < ApplicationRecord
  RETRY_TIMES = 3
  validates :balance, numericality: {greater_than_or_equal_to: 0}
  has_many :transaction_histories

  def deposit!(money)
    retry_times = RETRY_TIMES
    transaction do
      update!(balance: balance + money)
      transaction_histories.create!(kind: :deposit, money: money)
    rescue ActiveRecord::StaleObjectError
      if retry_times <= 0
        raise
      else
        retry_times -= 1
        reload
        retry
      end
    end
  end

  def withdraw!(money)
    retry_times = RETRY_TIMES
    transaction do
      update!(balance: balance - money)
      transaction_histories.create!(kind: :withdraw, money: money)
    rescue ActiveRecord::StaleObjectError
      if retry_times <= 0
        raise
      else
        retry_times -= 1
        reload
        retry
      end
    end
  end

  def transfer!(other, money)
    retry_times = RETRY_TIMES
    transaction do
      other.update!(balance: balance + money)
      other.transaction_histories.create!(kind: :transfer, money: money)
      update!(balance: balance - money)
      transaction_histories.create!(kind: :transfer, money: -money)
    rescue ActiveRecord::StaleObjectError
      if retry_times <= 0
        raise
      else
        retry_times -= 1
        reload
        other.reload
        retry
      end
    end
  end
end
