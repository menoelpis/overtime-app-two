## Overtime App

# Key requirement: company needs documentation that salaried employees did or did not get overtime each week

# Models

- Post -> date:date rationale:text
- User -> Devise
- AdminUser -> STI

# Features:

- Approval Workflow
- SMS Sending -> link to approval or overtime input
- Administrate admin dashboard
- Block non admin adn guest users
- Email summary to managers for approval
- Need to be documented if employee did not log overtime

# UI:

- Bootstrap -> formatting
- Icons from Font Awesome
- Update the styles for forms

# Refactor TODOS:

- Refactor user association integration test in post_spec