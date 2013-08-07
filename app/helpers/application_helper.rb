module ApplicationHelper
  def amount_class(amount)
    if amount > 0
      "text-success"
    elsif amount < 0
      "text-danger"
    else
      ""
    end
  end
end
