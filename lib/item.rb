class Item < ActiveRecord::Base
  belongs_to :list

  def add_duedate duedate
    #Item.due = duedate.date.parse
  end

  def add_done
    Item.completed = "true"
  end
end