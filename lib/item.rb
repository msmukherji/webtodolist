class Item < ActiveRecord::Base
  belongs_to :list

  def add_duedate duedate
    update due: Date.parse(duedate)
  end

  def done!
    update completed: true
  end

  def self.next_item
  # Item.where(completed != true) => doesn't recognize this
    loop do
      i = Item.order("RANDOM()").first
      return i
      break if i.completed != true
    end
  end
end