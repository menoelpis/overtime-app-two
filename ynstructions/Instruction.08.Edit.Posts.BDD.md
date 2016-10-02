 Overtime Application Workflow 08

 ## Implement Ability to Edit Posts via BDD

 - ![add](plus.png) [spec/features/post_spec.rb]
 ```rb
 describe 'navigate' do
 .
 .
 .
	describe 'edit' do   <<<
		before do
			@post = FactoryGirl.create(:post)
		end

		it 'cat be reached by clicking edit on index page' do
			post = FactoryGirl.create(:post)
			visit posts_path

			click_link("edit_#{@post.id}")
			expect(page.status_code).to eq(200)
		end

		it 'can be edited' do
			visit edit_post_path(@post)

			fill_in 'post[date]', with: Date.today
			fill_in 'post[rationale]', with: "Edited Content"
			click_on "Save"

			expect(page).to have_content("Edited Content")
		end
	end

end
```

- ![edit](edit.png) [app/views/posts/index.html.erb]
```erb
<h1>Posts Index</h1>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			.
			.
			.
			<th>
				Rationale
			</th>
			<th></th>   <<<
		</tr>
	</thead>
	<tbody>
		<%= render @posts %>
	</tbody>
</table>
```

- ![edit](edit.png) [app/views/posts/_post.html.erb]
```erb
<tr>
.
.
.
	<td>
		<%= link_to 'Edit', edit_post_path(post), id: "edit_#{post.id}" %>   <<<
	</td>
</tr>
```

- ![edit](edit.png) [app/controllers/posts_controller.rb]
```rb
class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update]
	.
	.
	.
	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to @post, notice: 'Your post was edited successfully'
		else
			render :edit
		end
	end

	def show
	end
	.
	.
	.
end
```

- $ touch app/views/posts/_form.html.erb
- ![add](plus.png) [app/views/posts/_form.html.erb]
```erb
<%= form_for @post do |f| %>
    <div class="col-sm-3">
      <div class="form-group">
          <div class='input-group date' id='datetimepicker1'>
              <%= f.date_field :date %>
              <span class="input-group-addon">
                  <span class="glyphicon glyphicon-calendar">
                  </span>
              </span>
          </div>
      </div>
    </div>
    <div class="col-sm-3">
        <div class="form-group">
            <div class='input-group text'>
                <%= f.text_area :rationale %>
            </div>
        </div>
    </div>
	
	<%= f.submit 'Save' %>

<% end %>
```

- ![edit](edit.png) [app/views/posts/new.html.erb]
```erb
<h1>New</h1>

<%= render 'form' %>

<script type="text/javascript">
    $(function () {
        $('#datetimepicker1').datetimepicker({
            viewMode: 'years',
            format: 'YYYY-MM-DD'   <<<
        });
    });
</script>
```

- ![edit](edit.png) [app/views/posts/edit.html.erb]
```erb
<h1>Edit</h1>

<%= render 'form' %>

<script type="text/javascript">
    $(function () {
        $('#datetimepicker1').datetimepicker({
            viewMode: 'years',
            format: 'YYYY-MM-DD'   <<<
        });
    });
</script>
```

- ![add](plus.png) [spec/features/post_spec.rb]
```rb
describe 'navigate' do
.
.
.
	describe 'new' do   <<<
		it 'has a link from the home page' do
			visit root_path

			click_link("new_post_from_nav")
			expect(page.status_code).to eq(200)
		end
	end

	describe 'creation' do
	.
	.
	.
	end

	describe 'edit' do
	.
	.
	.
	end
end

- ![add](plus.png) [app/views/shared/_nav.html.erb]
```erb
<ul class="custom-nav nav nav-tabs">
	<li class="<%= active?(root_path) %>">
		<%= link_to "Home", root_path %>
	</li>
	<li class="<%= active?(posts_path) %>">
		<%= link_to "Time Entries", posts_path %>
	</li>
	<li class="<%= active?(new_post_path) %>">   <<<
		<%= link_to "Add New Entry", new_post_path, id: 'new_post_from_nav' %>
	</li>
	.
	.
	.
</ul>
```

- ![add](plus.png) [spec/features/post_spec.rb]
```rb
describe 'navigate' do
.
.
.
	describe 'new' do   
	.
	.
	.
	end

	describe 'delete' do   <<<
		it 'can be deleted' do
			@post = FactoryGirl.create(:post)
			visit posts_path

			click_link("delete_post_#{@post.id}_from_index")
			expect(page.status_code).to eq(200)
		end
	end
	.
	.
	.
end
```

- $ rspec [which fails: unable to find link "delete_post..."]

- ![add](plus.png) [app/views/posts/index.html.erb] *add empty table header*
```erb
<h1>Posts Index</h1>

<table class="table table-striped table-hover">
	<thead>
		<tr>
			<th>
				#
			</th>
			<th>
				Date
			</th>
			<th>
				User
			</th>
			<th>
				Rationale
			</th>
			<th></th>
			<th></th>   <<<
		</tr>
	</thead>
	<tbody>
		<%= render @posts %>
	</tbody>
</table>
```

- ![add](plus.png) [app/views/posts/_post.html.erb] 
```erb
<tr>
	<td>
		<%= post.id %>
	</td>
	<td>
		<%= post.date %>
	</td>
	<td>
		<%= post.user.full_name %>
	</td>
	<td>
		<%= truncate(post.rationale) %>
	</td>
	<td>
		<%= link_to 'Edit', edit_post_path(post), id: "edit_#{post.id}" %>
	</td>
	<td>   <<<
		<%= link_to 'Delete', post_path(post), method: :delete, id: "delete_post_#{post.id}_from_index", data: { confirm: 'Are you sure?'}  %>
	</td>
</tr>
```

- $ rspec [which fails: the action 'destroy' could not be...]

- ![add](plus.png) [app/controllers/posts_controller.rb] 
```rb
class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]   <<<
	.
	.
	.

	def show
	end

	def destroy   <<<
		@post.delete
		redirect_to posts_path, notice: 'Your post was deleted successfully'
	end
	.
	.
	.
end
```
- $ rspec [which will succeed]

- ![edit](edit.png) [app/views/posts/_form.html.erb] *erase everything and replace*
```erb
<%= form_for @post, class: "form-horizontal" do |f| %>
  
  <div class="form-group">
    <%= f.label :date, class: "col-sm-2 control-label" %>
    <%= f.date_field :date, class: "form-control" %>
  </div>

  <div class="form-group">
    <%= f.label :rationale, class: "col-sm-2 control-label" %>
    <%= f.text_area :rationale, class: "form-control" %>
  </div>

  <%= f.submit 'Save', class: 'btn btn-primary btn-block' %>

<% end %>
```
- *remove script partials for datetime picker from new and edit post erb files*

- ![add](plus.png) [Gemfile] 
```rb
gem 'gritter', '1.2.0'

- ![add](plus.png) [app/assets/javascripts/application.js] 
```js
.
.
.
//= require bootstrap-sprockets
//= require gritter   <<<
.
.
.
```

- ![add](plus.png) [app/assets/stylesheets/application.css.scss] 
```scss
.
.
.
@import "gritter";   <<<
.
.
.
```

- ![add](plus.png) [app/views/layouts/application.html.erb]
```erb
	.
  .
	. 
	<%= js add_gritter(flash[:notice], title: "Overtime App Notification", sticky: false) %>   <<<

	</body>
</html>
```