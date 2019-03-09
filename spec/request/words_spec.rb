require 'rails_helper'

RSpec.describe 'Words', :type => :request do
  let(:word) {build(:word)}
  let(:saved_word) {create(:word)}
  let(:saved_word1) {create (:word1)}

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
