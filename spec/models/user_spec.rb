require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)       { build(:user)  }
  let(:saved_user) { create(:user) }
  let(:admin)      { create(:admin)}

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

  describe 'is_admin?' do
    it "returns true when user is a admin" do
      saved_user; admin
      expect(saved_user.is_admin?).to be_truthy
    end

    it "returns false when user is not a admin" do
      expect(saved_user.is_admin?).to be_falsey
    end
  end

  describe 'set_as_admin' do
    it "creates new admin" do
      expect{ saved_user.set_as_admin }.to change(Admin, :count).by(1)
    end

    it "set user as admin" do
      saved_user.set_as_admin
      saved_user.reload
      expect(saved_user.is_admin?).to be_truthy
    end

    it "do nothing when user is admin" do
      saved_user.set_as_admin
      expect{ saved_user.set_as_admin }.not_to change(Admin, :count)
    end
  end
end
