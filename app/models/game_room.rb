class GameRoom < ApplicationRecord
  extend FriendlyId
    friendly_id :name, use: :slugged

  before_validation :get_random_word

  belongs_to :word

  validates :name, presence: true, length: { minimum: 3, maximum: 64}

  protected
    def get_random_word
      self.word_id = Word.ids.sample if self.word_id.nil?
    end
end
