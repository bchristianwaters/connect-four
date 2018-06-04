 class Message < ApplicationRecord
   belongs_to :user
   belongs_to :game
   validates :content, length: { minimum: 1 }, presence: true
   validates :user, presence: true
   validates :game, presence: true
 end
