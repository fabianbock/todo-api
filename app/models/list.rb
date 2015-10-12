class List < ActiveRecord::Base
  belongs_to :user
  validates :permissions, inclusion: {in: ['open', 'viewable', 'private']}
  validates :user, presence: true
end
