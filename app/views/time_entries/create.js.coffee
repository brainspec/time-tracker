todo = ($ "#todo-<%= @time_entry.todo_id %>")
<% if @time_entry.errors.any? %>
($ 'form', todo).replaceWith '<%= j render 'time_entries/form', time_entry: @time_entry %>'
<% else %>
($ 'form', todo).remove()
($ '.post-time', todo).show()
<% end %>
