require 'rails_helper'

RSpec.describe 'Profiles', :type => :request do
  let(:user) {create(:user)}
  let(:better_user) {create(:user1, score: 100)}

  describe 'GET' do
    describe 'index' do
      it "redirects to login page when not logged in" do
        get profiles_path
      end

      it "assigns users sorted by their score" do
        sign_in(user)
        better_user
        get profiles_path
        expect(assigns(:users)).to eq([better_user, user])
      end
    end

    describe 'show' do
      it "redirects to login page when not logged in" do
        get profile_path(user)
      end

      it "assings user informations" do
        sign_in(user)
        get profile_path(user)
        expect(assigns(:user)).to eq(user)
        expect(assigns(:game_rooms_created)).to eq(user.game_rooms)
        expect(assigns(:won_games)).to eq(user.won_games)

      end
    end
  end
end
