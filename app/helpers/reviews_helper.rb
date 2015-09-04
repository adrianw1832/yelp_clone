module ReviewsHelper
  def star_rating(rating)
    return rating unless rating.respond_to?(:round)
    "★" * rating.round + "☆" * (5 - rating)
  end

  def created_since(time)
    hour = (Time.now - time) / 3600
    pluralize(hour.round, 'hour')
  end
end
