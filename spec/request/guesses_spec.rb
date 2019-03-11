require 'rails_helper'

RSpec.describe 'Guesses', :type => :request do
  let(:game_room) {create(:game_room)}
  let(:word)      {create(:word)}

  before(:each) do
    word; game_room
  end

  describe 'POST' do
    it "create a new guess when valid" do
      expect{ post game_room_guesses_path(game_room), params: {guess: attributes_for(:guess)}}.
      to change(Guess, :count).by(1)
    end

    it "associates guess with correct game room" do
      post game_room_guesses_path(game_room), params: {guess: attributes_for(:guess)}
      expect(Guess.last.game_room).to eq(game_room)
    end

    it "dont change game room when guessed incorrectly" do
      post game_room_guesses_path(game_room), params: {guess: attributes_for(:guess)}
      expect(game_room.status).to eq(0)
    end

    it "change game room when guessed correctly" do
      post game_room_guesses_path(game_room), params: {guess: attributes_for(:guess, text: word.name)}
      game_room.reload
      expect(game_room.status).to eq(1)
    end

    it "do nothing when invalid" do
      expect{post game_room_guesses_path(game_room),
         params: {guess: attributes_for(:guess, text: '')}}.not_to change(Guess, :count)
    end
  end
end
