require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)       { build(:user) }
  let(:saved_user) { create(:user) }

  describe 'validations' do
    it "should accept a valid user" do
      expect(user).to be_valid
    end

    describe 'name' do
      it 'should be present' do
        user.name = ''
        expect(user).to be_invalid
      end

      it "must be longer than 3 characters" do
        user.name = 'aaa'
        expect(user).to be_invalid
      end

      it "must be shorter than 25 characters" do
        user.name = 'a' * 25
        expect(user).to be_invalid
      end
      it "should be unique" do
        saved_user
        expect(user).to be_invalid
      end
    end
  end

  describe '.reward' do
    it 'increase user score by 10' do
      expect{ saved_user.reward }.to change(saved_user, :score).by(10)
    end
  end
end
