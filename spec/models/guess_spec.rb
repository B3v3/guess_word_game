require 'rails_helper'

RSpec.describe Guess, type: :model do
  let(:game_room) {create(:game_room)}
  let(:word)      {create(:word)}
  let(:guess)     {build(:guess)}

  before(:each) do
    word; game_room
  end

  describe 'validations' do
    it "should accept a valid guess" do
      expect(guess).to be_valid
    end

    describe 'text' do
      it "should be present" do
        guess.text = ''
        expect(guess).to be_invalid
      end

      it "should be longer than 2 characters" do
        guess.text = 'aa'
        expect(guess).to be_invalid
      end

      it "should be shorter than 33 character" do
        guess.text = 'a' * 33
        expect(guess).to be_invalid
      end
    end

    describe 'game_room' do
      it "should be present" do
        guess.game_room_id = ''
        expect(guess).to be_invalid
      end
    end
  end

  describe 'relationships' do
    it "should have a game room" do
      expect(guess.game_room).to eq(game_room)
    end
  end
end
