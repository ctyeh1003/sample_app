class Micropost < ActiveRecord::Base
  attr_accessible :content, :agreements_attributes, :disagreements_attributes
  
  belongs_to :user
  
  has_many :agreements, foreign_key: "agreer_id", dependent: :destroy
  has_many :agreed_microposts, through: :agreements, source: :agreed
  has_many :reverse_agreements, foreign_key: "agreed_id",
                                   class_name:  "Agreement",
                                   dependent:   :destroy
  has_many :agreers, through: :reverse_agreements, source: :agreer

  has_many :disagreements, foreign_key: "disagreer_id", dependent: :destroy
  has_many :disagreed_microposts, through: :disagreements, source: :disagreed
  has_many :reverse_disagreements, foreign_key: "disagreed_id",
                                   class_name:  "Disagreement",
                                   dependent:   :destroy
  has_many :disagreers, through: :reverse_disagreements, source: :disagreer

  accepts_nested_attributes_for :agreements, :disagreements

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 14000}

  default_scope order: 'microposts.created_at DESC'

  def feed
    Micropost.where("micropost_id = ?", id)
  end

  def agreeing?(other_micropost)
    agreements.find_by_agreed_id(other_micropost.id)
  end

  def agree!(other_micropost)
    agreements.create!(agreed_id: other_micropost.id)
  end

  def unagree!(other_micropost)
  	agreements.find_by_agreed_id(other_micropost.id).destroy
  end

  def disagreeing?(other_micropost)
    disagreements.find_by_disagreed_id(other_micropost.id)
  end

  def disagree!(other_micropost)
    disagreements.create!(disagreed_id: other_micropost.id)
  end

  def undisagree!(other_micropost)
    disagreements.find_by_disagreed_id(other_micropost.id).destroy
  end

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

end
