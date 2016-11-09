@user = User.create(email: "test@test.com", 
										password: "asdfasdf", 
										password_confirmation: "asdfasdf", 
										first_name: "Daniel", 
										last_name: "Park",
										phone: "1076580774")

puts "1 user created"

AdminUser.create(email: "admin@test.com", 
								 password: "asdfasdf", 
								 password_confirmation: "asdfasdf", 
								 first_name: "Admin", 
								 last_name: "Park",
								 phone: "1076580774")

puts "1 admin user created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user_id: @user.id, overtime_request: 2.5)
end

puts "100 posts have been created!"

100.times do |audit_log|
	AuditLog.create!(user_id: User.last.id, status: 0, start_date: (Date.today - 6.days))
end

puts "100 audit logs have been created"