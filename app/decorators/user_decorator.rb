class UserDecorator < ApplicationDecorator
  decorates :user

  def today_total_time
    total = model.today_total_time
    h.link_to "Today posted time: #{total} #{'hour'.pluralize(total)}", [:time_entries]
  end
end
