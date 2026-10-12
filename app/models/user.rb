class User < ApplicationRecord

  enum :role, {
    admin: 0,
    employee: 1
  }

  has_many :projects, foreign_key: :owner_id, dependent: :destroy
  has_many :project_members, dependent: :destroy
  has_many :member_projects, through: :project_members, source: :project
  has_many :comments, dependent: :destroy
  
end
