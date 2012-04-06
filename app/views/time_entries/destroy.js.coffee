($ 'div.time-entries').html '<%= j render 'time_entries/table', time_entries: @time_entries %>'
($ 'li.total-posted-time > a').html('<%= j "Today posted time: #{current_user.today_total_time} hours" %>')
