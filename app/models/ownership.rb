class Ownership < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  def sefl.ranking
    self.group(:item_id).order('count_item_id DESC').limit(10).count(:item_id)
  end
end
