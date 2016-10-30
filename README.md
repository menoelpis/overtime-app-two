# Overtime App

## Key requirement: company needs documentation that salaried employees did or did not get overtime each week

## Models

- ![check](ynstructions/check.png) Post -> date:date rationale:text
- ![check](ynstructions/check.png) User -> Devise
- ![check](ynstructions/check.png) AdminUser -> STI(Single Table Inheritance)
- AuditLog

## Features:

- Approval Workflow
- SMS Sending -> link to approval or overtime input
- ![check](ynstructions/check.png) Administrate admin dashboard
- ![check](ynstructions/check.png) Block non admin adn guest users
- Email summary to managers for approval
- Need to be documented if employee did not log overtime

## UI:

- ![check](ynstructions/check.png) Bootstrap -> formatting
- ![check](ynstructions/check.png) Icons from Font Awesome
- ![check](ynstructions/check.png) Update the styles for forms

## Refactor TODOS:
- ![check](ynstructions/check.png) Add full_name method for users
- ![check](ynstructions/check.png) Refactor user association integration test in post_spec
- ![check](ynstructions/check.png) Refactor posts/_form for admin user with status
- ![check](ynstructions/check.png) Fix post_spec.rb: to use factories
- ![check](ynstructions/check.png) Fix post_spec.rb to have correct user reference and not require update
- Integrate validation for phoe attr in User:
	# No spaces or dashes
	# all characters have to be a number
	# exactly 10 characters