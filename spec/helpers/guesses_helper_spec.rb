require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the GuessesHelper. For example:
#
# describe GuessesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe GuessesHelper, type: :helper do
  let(:game_room)     { create(:game_room)}
  let(:won_game_room) { create(:game_room, status: 1)}
  let(:user1)         { create(:user1)}
  let(:user)          { create(:user)}
  let(:word)          { create(:word)}

  before(:each) do
    word; user
  end
  describe "valid_for_guessing?" do
    it 'returns true when valid' do
      sign_in(user1)
      expect(helper.valid_for_guessing?(game_room)).to be_truthy
    end

    it "returns false when user is game master" do
      sign_in(user)
      expect(helper.valid_for_guessing?(game_room)).to be_falsey
    end

    it "returns false when game is won" do
      sign_in(user1)
      expect(helper.valid_for_guessing?(won_game_room)).to be_falsey
    end

    it "returns false when user is not logged in" do
      expect(helper.valid_for_guessing?(game_room)).to be_falsey
    end
  end
end
