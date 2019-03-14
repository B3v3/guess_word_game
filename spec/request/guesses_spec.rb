require 'rails_helper'

RSpec.describe 'Guesses', :type => :request do
  let(:game_room)   {create(:game_room)}
  let(:game_room1)  {create(:game_room, user_id: 2)}
  let(:won_game_room) {create(:game_room, status: 1)}
  let(:word)        {create(:word)}
  let(:user)        {create(:user)}

  describe 'logged in' do
    before(:each) do
      sign_in(user)
      word; game_room
    end

    describe 'POST' do
      it "create a new guess when valid" do
        create(:user1)
        expect{ post game_room_guesses_path(game_room1), params: {guess: attributes_for(:guess)}}.
        to change(Guess, :count).by(1)
      end

      it "associates guess with correct game room" do
        create(:user1)
        post game_room_guesses_path(game_room1), params: {guess: attributes_for(:guess)}
        expect(Guess.last.game_room).to eq(game_room1)
      end

      it "dont change game room when guessed incorrectly" do
        create(:user1)
        post game_room_guesses_path(game_room1), params: {guess: attributes_for(:guess)}
        expect(game_room1.status).to eq(0)
      end

      it "change game room when guessed correctly" do
        create(:user1)
        post game_room_guesses_path(game_room1), params: {guess: attributes_for(:guess, text: word.name)}
        game_room1.reload
        expect(game_room1.status).to eq(1)
      end

      it "do nothing when invalid" do
        create(:user1)
        expect{post game_room_guesses_path(game_room1),
           params: {guess: attributes_for(:guess, text: '')}}.not_to change(Guess, :count)
      end

      it "do nothing when user is creator of game room" do
        expect{post game_room_guesses_path(game_room),
           params: {guess: attributes_for(:guess)}}.not_to change(Guess, :count)
      end

      it "do nothing when game is won" do
        expect{post game_room_guesses_path(won_game_room),
           params: {guess: attributes_for(:guess)}}.not_to change(Guess, :count)
      end
    end
  end

  describe 'not logged in' do
    before(:each) do
      word; user
    end

    describe 'POST' do
      describe 'create' do
        it "do not create anything" do
          create(:user1)
          expect{ post game_room_guesses_path(game_room1), params: {guess: attributes_for(:guess)}}.
          not_to change(Guess, :count)
        end
        it "redirect to login page" do
          create(:user1)
          post game_room_guesses_path(game_room1), params: {guess: attributes_for(:guess)}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
