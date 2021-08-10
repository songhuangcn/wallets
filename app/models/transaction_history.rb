class TransactionHistory < ApplicationRecord
  belongs_to :user
  validates :kind, presence: true
  validates :money, presence: true, numericality: true
  validate :validate_money_with_kind

  enum kind: {
    deposit: 0,
    withdraw: 1,
    transfer: 2
  }

  private

  def validate_money_with_kind
    error = if deposit? && money <= 0
      "Depost money should not less than and equal to 0"
    elsif withdraw? && money <= 0
      "Withdraw money should not less than and equal to 0"
    elsif transfer? && money == 0
      "Transfer money should not equal to 0"
    end
    errors.add(:money, error) if error
  end
end
