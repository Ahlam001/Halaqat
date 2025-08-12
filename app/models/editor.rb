class Editor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: { editor: "editor", admin: "admin" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :episodes, dependent: :nullify
end
