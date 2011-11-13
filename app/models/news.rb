class News < ActiveRecord::Base

  #scope :latest_news, limit(10).news.order("news.created_at DESC")
  scope :latest_news, order("news.created_at DESC")
end
