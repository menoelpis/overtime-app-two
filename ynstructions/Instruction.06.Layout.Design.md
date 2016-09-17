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