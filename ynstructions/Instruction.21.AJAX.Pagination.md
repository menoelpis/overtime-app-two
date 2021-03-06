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

- $ touch app/assets/javascripts/pagination.js
- ![add](plus.png) [app/assets/javascripts/pagination.js]
```js
(function($) {
  // Make sure that every Ajax request sends the CSRF token
  function CSRFProtection(xhr) {
    var token = $('meta[name="csrf-token"]').attr('content');
    if (token) xhr.setRequestHeader('X-CSRF-Token', token);
  }
  if ('ajaxPrefilter' in $) $.ajaxPrefilter(function(options, originalOptions, xhr){ CSRFProtection(xhr) });
  else $(document).ajaxSend(function(e, xhr){ CSRFProtection(xhr) });

  // Triggers an event on an element and returns the event result
  function fire(obj, name, data) {
    var event = new $.Event(name);
    obj.trigger(event, data);
    return event.result !== false;
  }

  // Submits "remote" forms and links with ajax
  function handleRemote(element) {
    var method, url, data,
      dataType = element.attr('data-type') || ($.ajaxSettings && $.ajaxSettings.dataType);

    if (element.is('form')) {
      method = element.attr('method');
      url = element.attr('action');
      data = element.serializeArray();
      // memoized value from clicked submit button
      var button = element.data('ujs:submit-button');
      if (button) {
        data.push(button);
        element.data('ujs:submit-button', null);
      }
    } else {
      method = element.attr('data-method');
      url = element.attr('href');
      data = null;
    }

    $.ajax({
      url: url, type: method || 'GET', data: data, dataType: dataType,
      // stopping the "ajax:beforeSend" event will cancel the ajax request
      beforeSend: function(xhr, settings) {
        if (settings.dataType === undefined) {
          xhr.setRequestHeader('accept', '*/*;q=0.5, ' + settings.accepts.script);
        }
        return fire(element, 'ajax:beforeSend', [xhr, settings]);
      },
      success: function(data, status, xhr) {
        element.trigger('ajax:success', [data, status, xhr]);
      },
      complete: function(xhr, status) {
        element.trigger('ajax:complete', [xhr, status]);
      },
      error: function(xhr, status, error) {
        element.trigger('ajax:error', [xhr, status, error]);
      }
    });
  }

  // Handles "data-method" on links such as:
  // <a href="/users/5" data-method="delete" rel="nofollow" data-confirm="Are you sure?">Delete</a>
  function handleMethod(link) {
    var href = link.attr('href'),
      method = link.attr('data-method'),
      csrf_token = $('meta[name=csrf-token]').attr('content'),
      csrf_param = $('meta[name=csrf-param]').attr('content'),
      form = $('<form method="post" action="' + href + '"></form>'),
      metadata_input = '<input name="_method" value="' + method + '" type="hidden" />';

    if (csrf_param !== undefined && csrf_token !== undefined) {
      metadata_input += '<input name="' + csrf_param + '" value="' + csrf_token + '" type="hidden" />';
    }

    form.hide().append(metadata_input).appendTo('body');
    form.submit();
  }

  function disableFormElements(form) {
    form.find('input[data-disable-with]').each(function() {
      var input = $(this);
      input.data('ujs:enable-with', input.val())
        .val(input.attr('data-disable-with'))
        .attr('disabled', 'disabled');
    });
  }

  function enableFormElements(form) {
    form.find('input[data-disable-with]').each(function() {
      var input = $(this);
      input.val(input.data('ujs:enable-with')).removeAttr('disabled');
    });
  }

  function allowAction(element) {
    var message = element.attr('data-confirm');
    return !message || (fire(element, 'confirm') && confirm(message));
  }

  function requiredValuesMissing(form) {
    var missing = false;
    form.find('input[name][required]').each(function() {
      if (!$(this).val()) missing = true;
    });
    return missing;
  }

  $('a[data-confirm], a[data-method], a[data-remote]').live('click.rails', function(e) {
    var link = $(this);
    if (!allowAction(link)) return false;

    if (link.attr('data-remote') != undefined) {
      handleRemote(link);
      return false;
    } else if (link.attr('data-method')) {
      handleMethod(link);
      return false;
    }
  });

  $('form').live('submit.rails', function(e) {
    var form = $(this), remote = form.attr('data-remote') != undefined;
    if (!allowAction(form)) return false;

    // skip other logic when required values are missing
    if (requiredValuesMissing(form)) return !remote;

    if (remote) {
      handleRemote(form);
      return false;
    } else {
      // slight timeout so that the submit button gets properly serialized
      setTimeout(function(){ disableFormElements(form) }, 13);
    }
  });

  $('form input[type=submit], form button[type=submit], form button:not([type])').live('click.rails', function() {
    var button = $(this);
    if (!allowAction(button)) return false;
    // register the pressed submit button
    var name = button.attr('name'), data = name ? {name:name, value:button.val()} : null;
    button.closest('form').data('ujs:submit-button', data);
  });

  $('form').live('ajax:beforeSend.rails', function(event) {
    if (this == event.target) disableFormElements($(this));
  });

  $('form').live('ajax:complete.rails', function(event) {
    if (this == event.target) enableFormElements($(this));
  });
})( jQuery );
```

- ![edit](edit.png) [app/views/audit_logs/index.html.erb]
```rb
	.
	.
	.
	<tbody id="audit_logs">   <<<
		<%= render @audit_logs %>
	</tbody>
</table>

<div id="paginator">
	<%= paginate @audit_logs, remote: true %>   <<<
</div>
```

- ![edit](edit.png) [app/views/posts/index.html.erb]
```rb
	.
	.
	.
	<tbody id="posts">   <<<
		<%= render @posts %>
	</tbody>
</table>

<div id="paginator">
	<%= paginate @posts, remote: true %>   <<<
</div>
```

- $ touch app/views/posts/index.js.erb
- ![add](plus.png) [app/views/posts/index.js.erb]
```erb
$('#posts').html('<%= escape_javascript render(@posts) %>');
$('#paginator').html('<%= escape_javascript(paginate(@posts, remote: true).to_s) %>');
```

- $ touch app/views/audit_logs/index.js.erb
- ![add](plus.png) [app/views/audit_logs/index.js.erb]
```erb
$('#audit_logs').html('<%= escape_javascript render(@audit_logs) %>');
$('#paginator').html('<%= escape_javascript(paginate(@audit_logs, remote: true).to_s) %>');
```
