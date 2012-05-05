todo = ($ "#todo-<%= @time_entry.todo.bcx_id %>")
<% if @time_entry.errors.any? %>
($ 'form', todo).replaceWith '<%= j render 'time_entries/form', time_entry: @time_entry %>'
<% else %>
($ 'form', todo).remove()
<% todo_total = @time_entry.todo.total_hours %>
($ '.total-todo-time', todo).html('<%= todo_total %>')
<% if todo_total && todo_total > 0 %>
($ '.total-todo-time', todo).removeClass('hidden')
<% end %>
($ 'li.total-posted-time > a').html('<%= j "Today posted time: #{current_user.today_total_time} hours" %>')
<% end %>
