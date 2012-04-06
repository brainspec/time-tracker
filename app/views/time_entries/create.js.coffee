todo = ($ "#todo-<%= @time_entry.todo_id %>")
($ 'form', todo).remove()
($ '.post-time', todo).show()
