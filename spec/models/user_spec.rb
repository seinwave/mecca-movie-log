# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User model', type: :model do
  let(:user) { FactoryBot.build(:user) }
  describe 'validations' do
    context 'when a user is valid' do
      it 'should have first and last name' do
        expect(user).to be_valid
      end
    end
    context 'when a user is invalid' do
      it 'should have a first_name' do
        user.first_name = nil
        expect(user).to_not be_valid
      end
      it 'should have a last_name' do
        user.last_name = nil
        expect(user).to_not be_valid
      end
    end
  end
end
