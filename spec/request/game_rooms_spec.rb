require 'rails_helper'

RSpec.describe 'Game Rooms', :type => :request do
  let(:game_room) {create(:game_room)}
  let(:game_room1) {create(:game_room1)}
  let(:unsaved_game_room) {build(:game_room)}

  describe 'GET' do
    describe 'index' do
      it "should get all game rooms" do
        game_room; game_room1
        get '/'
        expect(assigns(:game_rooms)).to eq([game_room, game_room1])
      end
    end

    describe 'show' do
      it "should get specific game room" do
        game_room
        get "/game_rooms/#{game_room.slug}"
        expect(assigns(:game_room)).to eq(game_room)
      end
    end

    describe 'new' do
      it "should get new game room" do
        get "/game_rooms/new"
        expect(assigns(:game_room)).to be_a_new(GameRoom)
      end
    end
  end

  describe 'POST' do
    describe 'create' do
      it "should create a new game room when valid" do
      expect{post '/game_rooms', params: {game_room: attributes_for(:game_room)}}.
      to change(GameRoom, :count).by(1)
      end

      it "should not create anything when invalid" do
        expect{post '/game_rooms',
          params: {game_room: attributes_for(:game_room, name: " ")}}.
        not_to change(GameRoom, :count)
      end
    end
  end

  describe 'PUT' do
    describe 'update' do
      pending "STATUS CHANGES"
    end
  end

  describe 'DELETE' do
    describe 'destroy' do
      it "should delete game room" do
        game_room
        expect{ delete "/game_rooms/#{game_room.slug}" }.
          to change(GameRoom, :count).by(-1)
      end
    end
  end
end
