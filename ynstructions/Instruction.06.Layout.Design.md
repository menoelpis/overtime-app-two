 Overtime Application Workflow 06

## Layout Design with Bootstrap 


- ![add](plus.png) [Gemfile]
```rb
gem 'bootstrap-sass', '~> 3.3'
```

- $ bundle install

- $ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.css.scss 

- ![add](plus.png) [app/assets/stylesheets/application.css.scss]
```scss
@import "bootstrap-sprockets";
@import "bootstrap";
@import "posts.scss";
```
- ![edit](edit.png) [app/assets/javascripts/application.js]
```js
//= require jquery
//= require bootstrap-sprockets <<<
//= require jquery_ujs
//= require turbolinks
//= require_tree .
```
- ![edit](edit.png) [app/views/layouts/application.html.erb]
```erb
<body class="container"> <<<
  <%= yield %>
</body>
 ```

## Bootstrap DateTimePicker Install

- ![add](plus.png) [Gemfile]
```rb
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.42'
```

- $ bundle install

- ![add](plus.png) [app/assets/javascripts/application.js]
```js
//= require moment
//= require bootstrap-datetimepicker
```

- ![edit](edit.png) [app/assets/stylesheets/application.css.scss]
```scss
@import 'bootstrap-sprockets';
@import 'bootstrap';
@import 'bootstrap-datetimepicker'; <<<
```

- ![edit](edit.png) [app/views/posts/new.html.erb]
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

<script type="text/javascript">
    $(function () {
        $('#datetimepicker1').datetimepicker({
            viewMode: 'years',
            format: 'DD/MM/YYYY'
        });
    });
</script>
```

- $ mkdir app/views/shared
- $ touch app/views/shared/_nav.html.erb
- $ rails routes | grep user

- ![add](plus.png) [app/views/shared/_nav.html.erb]
```erb
<div class="logo">
  <h1>Time Tracker</h1>
</div>

<ul class="custom-nav nav nav-tabs">
  <li class="active">
    <%= link_to "Home", root_path %>
  </li>
  <li>
    <%= link_to "Time Entries", posts_path %>
  </li>
  <li class="dropdown pull-right">
     <a href="#" data-toggle="dropdown" class="dropdown-toggle">Account<strong class="caret"></strong></a>
    <ul class="dropdown-menu">
      <li>
        <%= link_to "Edit Details", edit_user_registration_path %>
      </li>
      <li class="divider">
      </li>
      <li>
        <%= link_to "Logout", destroy_user_session_path, method: :delete %>
      </li>
    </ul>
  </li>
</ul>
```

- ![edit](edit.png) [app/assets/stylesheets/application.css.scss]
```scss
.custom-nav {
  margin-top: 20px;
}
```

- ![edit](edit.png) [app/views/layouts/application.html.erb]
```erb
.
.
.
<div class="container"> 
  <div class="row">
    <div class="col-md-12">
      <%= render 'shared/nav' %>
      <%= yield %>
    </div>
  </div>
</div>
.
.
.
```

- ![edit](edit.png) [app/views/static/homepage.html.erb]
```erb
<div class="jumbotron">
  <h2>
    Hello, world!
  </h2>
  <p>
    This is a template for a simple marketing or informational website. It includes a large callout called the hero unit and three supporting pieces of content. Use it as a starting point to create something more unique.
  </p>
  <p>
    <a class="btn btn-primary btn-large" href="#">Learn more</a>
  </p>
</div>
```

