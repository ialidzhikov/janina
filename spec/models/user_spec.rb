require 'spec_helper'

RSpec.describe User do
  describe '#first_name' do
    it 'gets first name' do
      user = create :student

      expect(user.first_name).to eq 'Ashley'
    end
  end

  describe '#points' do
    it 'returns 0 for admins' do
      user = create :admin

      expect(user.points).to eq(0)
    end

    it 'sums solution points for students' do
      user = create :student_with_solutions

      expect(user.points).to eq(3)
    end
  end
end
