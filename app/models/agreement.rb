class Agreement < ActiveRecord::Base
  attr_accessible :agreed_id

  belongs_to :agreer, class_name: "Micropost"
  belongs_to :agreed, class_name: "Micropost"

  validates :agreer_id, presence: true
  validates :agreed_id, presence: true
end
