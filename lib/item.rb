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
    i = 0 # => I think this fixes it so the right thing is returned?
    loop do
      i = Item.order("RANDOM()").first
      #return i
      break if i.completed == nil
      #return i
      binding.pry
    end
    return i
  end
end