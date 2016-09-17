# Overtime Application Workflow 02

## Initial Test

- $ mkdir spec/features
- $ touch spec/features/static_spec.rb
- ![add](plus.png) [spec/features/static_spec.rb] 
```ruby	
require 'rails_helper'

describe 'navigate' do
	describe 'homepage' do
		it 'can be reached successfully' do
			visit root_path
			expect(page.status_code).to eq(200)
		end
	end
end
```
- $ rails db:migrate
- $ rspec [which will result in failed test]
- ![add](plus.png) [config/routes.rb] root to: 'static#homepage'
- $ touch app/controllers/static_controller.rb
- ![add](plus.png) [app/controllers/static_controller.rb]
```ruby	
class StaticController < ApplicationController
	def homepage
	end
end
```
- $ mkdir app/views/static
- $ touch app/views/static/homepage.html.erb
- ![add](plus.png) [app/views/static/homepage.html.erb]
```html
<h1>This is Homepage Text for Test</h1>
```
- $ rspec [which will succeed!]
