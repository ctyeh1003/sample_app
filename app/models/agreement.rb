class Agreement < ActiveRecord::Base
  attr_accessible :agreed_id, :agreer_id, :nested

  belongs_to :agreer, class_name: "Micropost"
  belongs_to :agreed, class_name: "Micropost"

  validates :agreer_id, presence: true, :unless => :nested
  attr_accessor :nested
  validates :agreed_id, presence: true
end
