class Disagreement < ActiveRecord::Base
  attr_accessible :disagreed_id, :disagreer_id, :nested

  belongs_to :disagreer, class_name: "Micropost"
  belongs_to :disagreed, class_name: "Micropost"

  validates :disagreer_id, presence: true, :unless => :nested
  attr_accessor :nested
  validates :disagreed_id, presence: true
end
