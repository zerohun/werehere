class History < ActiveRecord::Base
  has_many :users
  has_many :comments
  belongs_to :user

  @@last_id = -1

  def self.set_last_id(id)
    @@last_id = id
  end

  def self.last_id
    @@last_id
  end

end
