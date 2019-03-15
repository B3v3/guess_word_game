require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { build(:admin)}
  let(:user)  { create(:user)}

  before(:each) do
    user
  end

  describe 'validations' do
    it "should accept a valid admin" do
      expect(admin).to be_valid
    end
    describe 'user_id' do
      it "should be present" do
        admin.user_id = ''
        expect(admin).to be_invalid
      end

      it "should be unique" do
        create(:admin)
        expect(admin).to be_invalid
      end
    end
  end
end
