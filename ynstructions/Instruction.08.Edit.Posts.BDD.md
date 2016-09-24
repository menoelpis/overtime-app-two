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