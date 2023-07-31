require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#clear_phone_number_mark' do
    it 'should clear - in user instance' do
      user = User.new
      user.phone_number = '0912-123-1234'
      user.clear_phone_number_mark
      expect(user.phone_number).to eq '09121231234'
    end
  end

  describe '#over_18_year_old?' do
    it 'should return false when user below 18' do
      user = User.new
      user.age = 17
      expect(user.over_18_year_old?).to eq false
    end
    it 'should return true when user over 18' do
      user = User.new
      user.age = 19
      expect(user.over_18_year_old?).to eq true
    end
    it 'should return true when user eq 18' do
      user = User.new
      user.age = 18
      expect(user.over_18_year_old?).to eq true
    end
  end
end
