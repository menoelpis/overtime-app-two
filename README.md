# Overtime App

## Key requirement: company needs documentation that salaried employees did or did not get overtime each week

## Models

- ![check](ynstructions/check.png) Post -> date:date rationale:text
- ![check](ynstructions/check.png) User -> Devise
- ![check](ynstructions/check.png) AdminUser -> STI(Single Table Inheritance)

## Features:

- Approval Workflow
- SMS Sending -> link to approval or overtime input
- ![check](ynstructions/check.png) Administrate admin dashboard
- ![check](ynstructions/check.png) Block non admin adn guest users
- Email summary to managers for approval
- Need to be documented if employee did not log overtime

## UI:

- ![check](ynstructions/check.png) Bootstrap -> formatting
- Icons from Font Awesome
- ![check](ynstructions/check.png) Update the styles for forms

## Refactor TODOS:
- ![check](ynstructions/check.png) Add full_name method for users
- Refactor user association integration test in post_spec