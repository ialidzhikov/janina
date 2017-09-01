require 'spec_helper'
require_relative '../support/user_support'

RSpec.configure do |config|
  config.include UserSupport
end

RSpec.describe 'register', type: :feature do
  context 'does not register' do
    it 'with empty full name' do
      register('', 20700, 'a.cole@gmail.com', '123456', '123456')

      expect(User.count).to eq(0)
      expect(page.current_path).to eq '/user/register'
      expect(page).to have_content 'Full name cannot be empty.'
    end

    it 'with not matching passwords' do
      register('Ashley Cole', 20700, 'a.cole@gmail.com', '123456', '1234')

      expect(User.count).to eq(0)
      expect(page.current_path).to eq '/user/register'
      expect(page).to have_content 'Passwords do not match.'
    end
  end

  context 'registers' do
    it 'with correct params' do
      register('Ashley Cole', 20700, 'a.cole@gmail.com', '123456', '123456')

      expect(User.count).to eq(1)
      expect(page.current_path).to eq '/'
      expect(page).to have_content 'a.cole@gmail.com'
    end
  end
end
