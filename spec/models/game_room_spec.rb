require 'rails_helper'

RSpec.describe GameRoom, type: :model do
  let(:game_room) {build(:game_room)}
  let(:saved_room) {create(:game_room)}
  let(:saved_won_room) {create(:game_room, status: 1)}
  let(:word) {create(:word)}
  let(:user) { create(:user)}
  let(:user1) { create(:user1)}


before(:each) do
  user; word
end

  describe 'validations' do
    it "should accept valid model" do
      expect(game_room).to be_valid
    end

    describe 'name' do
      it "should be present" do
        game_room.name = ''
        expect(game_room).to be_invalid
      end

      it "should be longer than 5 characters" do
        game_room.name = "aaaaa"
        expect(game_room).to be_invalid
      end

      it "should be shorther than 65 characters" do
        game_room.name = "a"*65
        expect(game_room).to be_invalid
      end
    end

    describe 'description' do
      it "should be present" do
        game_room.description = ''
        expect(game_room).to be_invalid
      end
      it "should be longer than 2 characters" do
        game_room.description = "aa"
        expect(game_room).to be_invalid
      end
      it "should be shorther than 257 characters" do
        game_room.description = "a"*257
        expect(game_room).to be_invalid
      end
    end
  end

  describe 'word' do
    it "should choose a random word" do
      game_room.save
      expect(game_room.word).to eq(word)
    end
  end

  describe '.won?' do
    it "returns false when not won" do
      expect(saved_room.won?).to be_falsey
    end

    it "returns true when won" do
      expect(saved_won_room.won?).to be_truthy
    end
  end

  describe '.end_game' do
    it "changes status to 1" do
      saved_room.end_game(user)
      expect(saved_room.status).to eq(1)
    end

    it "raises the score of creator and winner" do
      user
      saved_room.end_game(user1)
      user1.reload; user.reload
      expect(user1.score).to eq(10)
      expect(user.score).to eq(10)
    end

    it "set user as winner" do
      user
      saved_room.end_game(user1)
      saved_room.reload
      expect(saved_room.winner).to eq(user1)
    end
  end

  describe 'full_name' do
    it "returns only name if game is not won" do
      expect(saved_room.full_name).to eq(saved_room.name)
    end

    it "returns name + [CLOSED] if game is won" do
      expect(saved_won_room.full_name).to eq(saved_room.name + " [CLOSED]")
    end
  end
end
