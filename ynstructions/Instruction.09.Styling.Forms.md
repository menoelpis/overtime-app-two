 Overtime Application Workflow 09

 ## Styling Forms for Session LogIn

 - ![edit](edit.png) [app/views/devise/sessions/new.html.erb] *restyle session login form using bootstrap*
```erb
<h2>Log in</h2>

<div class="row">
  <div class="col-md-4">
      <%= form_for(resource, as: resource_name, url: session_path(resource_name), class: "form-horizontal") do |f| %>
        <div class="form-group">
          <%= f.label :email %><br />
          <%= f.email_field :email, autofocus: true, class: "form-control" %>
        </div>

        <div class="form-group">
          <%= f.label :password, class: "control-label" %><br />
          <%= f.password_field :password, autocomplete: "off", class: "form-control" %>
        </div>

        <% if devise_mapping.rememberable? -%>
          <div class="form-group">
            <%= f.check_box :remember_me %>
            <%= f.label :remember_me, class: "control-label" %>
          </div>
        <% end -%>

        <div class="form-group">
          <%= f.submit "Log in", class: "btn btn-primary" %>
        </div>
      <% end %>

    <%= render "devise/shared/links" %>
  </div>
</div>
```

 - ![edit](edit.png) [config/routes.rb] *remove registrations routes*
```rb
Rails.application.routes.draw do
  resources :posts
  devise_for :users, skip: [:registrations]   <<<
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static#homepage'
end
```

- ![edit](edit.png) [app/views/devise/shared/_links.html.erb] *erase all other links except below*
```erb
<%- if controller_name != 'sessions' %>
  <%= link_to "Log in", new_session_path(resource_name) %><br />
<% end -%>

<%- if devise_mapping.recoverable? && controller_name != 'passwords' && controller_name != 'registrations' %>
  <%= link_to "Forgot your password?", new_password_path(resource_name) %><br />
<% end -%>
```

- ![edit](edit.png) [app/views/shared/_nav.html.erb] *temporary fix for admin dashboard link*
```erb
<div class="logo">
	<h1>Time Tracker</h1>
</div>
.
.
.
	<li class="dropdown pull-right">
		 <a href="#" data-toggle="dropdown" class="dropdown-toggle">Account<strong class="caret"></strong></a>
		<ul class="dropdown-menu">
			<li>
				<%= link_to "TODO: Admin Dashboard", root_path %>   <<<
			</li>
			.
			.
			.
		</ul>
	</li>
</ul>