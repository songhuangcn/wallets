# Wallets

Wallets is a Wallet Application by Rails.

## Features

- User can deposit money into her wallet

```rb
begin
  User.first.deposit!(100)
  # Will create a deposit transaction history of the operating user.
rescue ActiveRecord::ActiveRecordError => exception
  puts "Operate failed: #{exception.message}"
end
```

- User can withdraw money from her wallet

```rb
begin
  User.first.withdraw!(100)
  # Will create a withdraw transaction history of the operating user.
rescue ActiveRecord::ActiveRecordError => exception
  puts "Operate failed: #{exception.message}"
end
```

- User can send money to another user

```rb
begin
  User.first.transfer!(User.second, 100)
  # Will create two transfer transaction histories of the two, the transaction history money of payer will be negative and one of payee will be positive.
rescue ActiveRecord::ActiveRecordError => exception
  puts "Operate failed: #{exception.message}"
end
```

- User can check her wallet balance


```rb
User.first.balance
# The balance is restricted to a non-negative number, which is 0 at initialization.
```

- User can see her wallet transaction history

```rb
User.first.transaction_histories
# There are three kinds of the transaction history: Deposit, Withdraw and Transfer.
```

## Setup

Dependency: Ruby 2.6.5, sqlite3 1.4.2

```bash
bin/setup
# Optional, insert initial data 
# bin/rails db:seed
```

## Code Style Lint

```bash
bin/lint
```

## Test

```bash
bin/rake
```

## Drawback or future consideration

- Need to improve transaction scenarios, such as transaction channels and transaction notes.
- Need a pessimistic locking strategy to solve possible high competition issues.
- Need to deal with wallet security issues, reject high-frequency operations caused by robots and other unreasonable operations.
- Need to improve the query and screening of transaction history, this record can easily become very large, and may need to be processed with "data warehouse" technology.
