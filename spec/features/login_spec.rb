require 'spec_helper'

RSpec.describe 'login', type: :feature do
  def login(e_mail, password)
    visit '/user/login'

    within 'form' do
      fill_in 'Email', with: e_mail
      fill_in 'Password', with: password
    end

    click_button 'Login'
  end

  context 'does not log in' do
    it 'with wrong e-mail' do
      create :student

      login('j.smith@gmail.com', '123456')

      expect(page.current_path).to eq '/user/login'
      expect(page).to have_content 'Invalid e-mail or password.'
    end

    it 'with wrong password' do
      student = create :student

      login(student.e_mail, '1234')

      expect(page.current_path).to eq '/user/login'
      expect(page).to have_content 'Invalid e-mail or password.'
    end
  end

  context 'does log in' do
    it 'with correct e-mail and password' do
      student = create :student

      login(student.e_mail, '123456')

      expect(page.current_path).to eq '/'
      expect(page).to have_content student.e_mail
    end
  end
end
