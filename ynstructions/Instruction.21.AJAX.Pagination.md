# Overtime Application Workflow 21

## Implementing AJAX Based Pagination

## Gemfile Addition

* ![add](plus.png) gem 'kaminari', '~> 0.17'

- ![add](plus.png) [app/views/posts/index.html.erb]
```rb
<h1>Posts Index</h1>
<table>
.
.
.
</table>
<%= paginate @posts %>
```

- ![edit](edit.png) [app/controllers/post_controller.rb]
```rb
class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.posts_by(current_user).page(params[:page]).per(10)   <<<
	end
	.
	.
	.
end
```

- ![edit](edit.png) [app/controllers/audit_logs_controller.rb]
```rb
class AuditLogsController < ApplicationController
	def index
		@audit_logs = AuditLog.page(params[:page]).per(10)   <<<
		authorize @audit_logs
	end
end
```

- ![add](plus.png) [app/views/audit_logs/index.html.erb]
```rb
<h1>Audit Log Dashboard</h1>
.
.
.
<%= paginate @audit_logs %>
```

- $ rails g kaminari:views bootstrap3