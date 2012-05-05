#= require jquery
#= require jquery_ujs
#= require bootstrap-datepicker


jQuery ($) ->
  form = ($ '#time-entry-form')

  ($ '.todo').delegate '.cancel', 'click', ->
    ($ @).closest('form').remove()

  ($ '.todo .post-time').click ->
    todo = ($ @).closest('.todo')
    ($ 'form', todo).remove()
    todo.append form.html()
    ($ '#time_entry_project_id', todo).val todo.data('project_id')
    ($ '#time_entry_todo_id',    todo).val todo.data('id')
    ($ '#time_entry_title',      todo).val todo.data('title')
    ($ '#time_entry_hours', todo).focus()

  ($ '.datepicker').datepicker(format: "yyyy-mm-dd")
