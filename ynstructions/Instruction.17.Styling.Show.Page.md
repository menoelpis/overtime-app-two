# Overtime Application Workflow 17

## Styling the Show Page View Template

- ![edit](edit.png) [app/views/posts/_post.html.erb]
```erb
.
.
.
<%= link_to truncate(post.rationale), post %>   <<<
.
.
.
```

- ![edit](edit.png) [app/views/posts/show.html.erb]
```erb
<div>
	<h2><%= @post.rationale %></h2>
</div>

<div class="well">
	<div>
		<h3><span>Overtime Amount Requested:</span> <%= @post.overtime_request %></h3>
	</div>

	<div>
		<h3><span>Employee:</span> <%= @post.user.full_name %></h3>
	</div>

	<div>
		<h3><span>Date:</span> <%= @post.overtime_request %></h3>
	</div>

	<div>
		<h3><span>Current Stage of Approval:</span> <%= @post.status %></h3>
	</div>	
</div>

<%= link_to 'Edit', edit_post_path(@post), class: 'btn btn-primary' if policy(@post).update? %>
```

## Add Glyphicons to Edit and Delete for Posts Index

- ![edit](edit.png) [app/views/posts/_post.html.erb]
```erb
	.
	.
	.
		<%= link_to '', edit_post_path(post), id: "edit_#{post.id}", class: 'glyphicon glyphicon-pencil icons-edit-index' if policy(post).update? %>   <<<
	</td>
	<td>
		<%= link_to '', post_path(post), method: :delete, id: "delete_post_#{post.id}_from_index", class: 'glyphicon glyphicon-trash icons-delete-index', data: { confirm: 'Are you sure?'} %>   <<<
	</td>
</tr>
```

- ![add](plus.png) [app/assets/stylesheets/posts.scss]
```scss
.icons-edit-index {
	font-size: 1.2em;
	text-decoration: none;
	color: #058225;
}

.icons-delete-index {
	font-size: 1.2em;
	text-decoration: none;
	color: #ab0303;
}
```