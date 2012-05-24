class TodoDecorator < ApplicationDecorator
  decorates :todo

  def total_hours
    total = model.total_hours
    total.round(2)
  end
end
