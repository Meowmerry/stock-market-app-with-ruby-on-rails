class Stock < ApplicationRecord
  belongs_to :user
  validates :ticker, presence: true
  validates :ticker, format: { without: /\s/, message: "must not contain spaces" }
end
