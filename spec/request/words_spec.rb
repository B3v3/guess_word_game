require 'rails_helper'

RSpec.describe 'Words', :type => :request do
  let(:word) {build(:word)}
  let(:saved_word) {create(:word)}
  let(:saved_word1) {create (:word1)}
  let(:user) {create(:user)}

  describe 'logged in' do
    before(:each) do
      sign_in(user)
    end

    describe "GET" do
      describe 'index' do
        it "should get all words" do
          saved_word; saved_word1
          get words_path
          expect(assigns(:words)).to include(saved_word, saved_word1)
        end
      end

      describe 'new' do
        it "should get a new word" do
          get new_word_path
          expect(assigns(:word)).to be_a_new(Word)
        end
      end
    end

    describe 'POST' do
      describe 'create' do
        it "creates a new word when params are valid" do
          expect{post words_path, params: {word: attributes_for(:word)}}.
          to change(Word, :count).by(1)
        end

        it "dont do nothing when params arent valid" do
          expect{post words_path, params: {word: attributes_for(:word, name: '')}}.
          not_to change(Word, :count)
        end
      end
    end

    describe 'DELETE' do
      describe 'destroy' do
        it "deletes word" do
          saved_word
          expect{delete word_path(saved_word)}.to change(Word, :count).by(-1)
        end

        it "deletes all rooms with that word" do
          saved_word; create(:game_room)
          expect{delete word_path(saved_word)}.to change(GameRoom, :count).by(-1)
        end
      end
    end
  end

  describe 'not logged in' do
    describe 'GET' do
      describe 'index' do
        it "redirects to login page" do
          get words_path
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe 'new' do
        it "redirects to login page" do
          get new_word_path
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe 'POST' do
      describe 'create' do
        it "dont create anything" do
          expect{post words_path, params: {word: attributes_for(:word)}}.
          not_to change(Word, :count)
        end

        it "redirects to login page" do
          post words_path, params: {word: attributes_for(:word)}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe 'DELETE' do
      describe 'destory' do
        it "dont delete anything" do
          saved_word
          expect{delete word_path(saved_word)}.not_to change(Word, :count)
        end

        it "redirects to login page" do
          delete word_path(saved_word)
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end
end
