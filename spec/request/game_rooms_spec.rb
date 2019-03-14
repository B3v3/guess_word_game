require 'rails_helper'

RSpec.describe 'Game Rooms', :type => :request do
  let(:game_room) {create(:game_room)}
  let(:game_room1) {create(:game_room1)}
  let(:unsaved_game_room) {build(:game_room)}
  let(:word) {create(:word)}
  let(:user) {create(:user)}

  before(:each) do
    word; user
  end

  describe 'not logged in' do
    describe 'GET' do
      describe 'index' do
        it "should get all game rooms" do
          game_room; game_room1
          get game_rooms_path
          expect(assigns(:game_rooms)).to eq([game_room, game_room1])
        end
      end

      describe 'show' do
        it "should get specific game room" do
          get game_room_path(game_room)
          expect(assigns(:game_room)).to eq(game_room)
        end
      end

      describe 'new' do
        it "should redirect to login page" do
          get new_game_room_path
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe 'POST' do
      describe 'create' do
        it "should not create anything" do
          expect{post game_rooms_path,
            params: {game_room: attributes_for(:game_room)}}.
          not_to change(GameRoom, :count)
        end

        it "should redirect to login page" do
          post game_rooms_path, params: {game_room: attributes_for(:game_room)}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe 'DELETE' do
      describe 'destroy' do
        it "should not delete game room" do
          game_room
          expect{ delete game_room_path(game_room) }.
          not_to change(GameRoom, :count)
        end

        it "should redirect to login page" do
          delete game_room_path(game_room)
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  describe 'logged in' do
    before(:each) do
      sign_in(user)
    end

    describe 'GET' do
      describe 'new' do
        it "should get new game room" do
          get new_game_room_path
          expect(assigns(:game_room)).to be_a_new(GameRoom)
        end
      end
    end

    describe 'POST' do
      describe 'create' do
        it "should create a new game room when valid" do
          expect{post game_rooms_path, params: {game_room: attributes_for(:game_room)}}.
          to change(GameRoom, :count).by(1)
        end

        it "should not create anything when invalid" do
          expect{post game_rooms_path,
            params: {game_room: attributes_for(:game_room, name: " ")}}.
          not_to change(GameRoom, :count)
        end
      end
    end

    describe 'DELETE' do
      describe 'destroy' do
        it "should delete game room" do
          game_room
          expect{ delete game_room_path(game_room) }.
          to change(GameRoom, :count).by(-1)
        end
      end
    end
  end
end
