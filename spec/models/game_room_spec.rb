require 'rails_helper'

RSpec.describe GameRoom, type: :model do
  let(:game_room) {build(:game_room)}
  let(:word) {create(:word)}

  before(:each) do
    word
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
      it "should be longer than 2 characters" do
        game_room.name = "aa"
        expect(game_room).to be_invalid
      end
      it "should be shorther than 65 characters" do
        game_room.name = "a"*65
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
end
