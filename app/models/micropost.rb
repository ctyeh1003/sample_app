class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  has_many :agreements, foreign_key: "agreer_id", dependent: :destroy
  has_many :agreed_microposts, through: :agreements, source: :agreed
  has_many :reverse_agreements, foreign_key: "agreed_id",
                                   class_name:  "Agreement",
                                   dependent:   :destroy
  has_many :agreers, through: :reverse_agreements, source: :agreer

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 14000}

  default_scope order: 'microposts.created_at DESC'

  def agreeing?(other_micropost)
    agreements.find_by_agreed_id(other_micropost.id)
  end

  def agree!(other_micropost)
    agreements.create!(agreed_id: other_micropost.id)
  end

  def unagree!(other_micropost)
  	agreements.find_by_agreed_id(other_micropost.id).destroy
  end

end
