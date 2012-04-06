#= require jquery
#= require jquery_ujs

jQuery ($) ->
  form = ($ '#time-entry-form')

  ($ '.todo').delegate '.cancel', 'click', ->
    ($ @).closest('.todo').find('.post-time').show()
    ($ @).closest('form').remove()

  ($ '.todo .post-time').click ->
    ($ @).hide()
    todo = ($ @).closest('.todo')
    todo.append form.html()
    ($ '#time_entry_todo_id', todo).val todo.data('id')
