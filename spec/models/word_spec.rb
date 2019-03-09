require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:word) {build(:word)}
  describe 'validations' do
    it "should accept valid model" do
      expect(word).to be_valid
    end
    describe 'name' do
      it "should be present" do
        word.name = ''
        expect(word).to be_invalid
      end
      it "should be longer than 4 characters" do
        word.name = "aaaa"
        expect(word).to be_invalid
      end
      it "should be shorther than 33 characters" do
        word.name = "a"*33
        expect(word).to be_invalid
      end
      it "should be unique" do
        create(:word)
        expect(word).to be_invalid
      end
    end
  end
end
