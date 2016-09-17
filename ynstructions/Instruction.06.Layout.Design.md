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