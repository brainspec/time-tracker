todo = ($ "#todo-<%= @time_entry.todo_id %>")
<% if @time_entry.errors.any? %>
($ 'form', todo).replaceWith '<%= j render 'time_entries/form', time_entry: @time_entry %>'
<% else %>
($ 'form', todo).remove()
($ '.post-time', todo).show()
<% todo_total = TimeEntry.todo_total_time(@time_entry.todo_id) %>
($ '.total-todo-time', todo).html('<%= todo_total %>')
<% if todo_total && todo_total > 0 %>
($ '.total-todo-time', todo).removeClass('hidden')
<% end %>
<% end %>
