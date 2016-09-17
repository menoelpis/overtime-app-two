# Overtime Application Workflow

## Initial Setup

- $ rails new overtime --database=postgresql
- $ git init
- $ git commit -m "Initial Commit"
- $ git remote add origin git@github.com:menoelpis/overtime.git

## Gemfile Addition

- [+] gem 'pg' '~> 0.18'
- [+] gem 'devise' '~> 4.2'
- [+-> group :development, :test] gem 'rspec-rails', '~> 3.0' 
- [+-> group :development, :test] gem 'capybara', '~> 2.8' 
- [+-> group :development, :test] gem 'database_cleaner', '~> 1.5' 