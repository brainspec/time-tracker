#= require jquery
#= require jquery_ujs

jQuery ($) ->
  form = ($ '#time-entry-form')

  ($ '.todo').delegate '.cancel', 'click', ->
    ($ @).closest('form').remove()

  ($ '.todo .post-time').click ->
    todo = ($ @).closest('.todo')
    ($ 'form', todo).remove()
    todo.append form.html()
    ($ '#time_entry_todo_id', todo).val todo.data('id')
    ($ '#time_entry_title',   todo).val todo.data('title')
    ($ '#time_entry_hours', todo).focus()
