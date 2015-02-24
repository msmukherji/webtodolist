class Item < ActiveRecord::Base
  belongs_to :list

  def add_duedate duedate #self.add_duedate?
    update due: Date.parse(duedate)
  end

  def done!
    update completed: true
  end
end