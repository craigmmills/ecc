class News < ActiveRecord::Base
  has_attached_file :pics, :styles => { :main => "940x525>", :thumb => "100x100>" }
  #scope :latest_news, limit(10).news.order("news.created_at DESC")
  scope :latest_news, order("news.created_at DESC")
end
