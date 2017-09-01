module UserSupport
  def login(e_mail, password)
    visit '/user/login'

    within 'form' do
      fill_in 'Email', with: e_mail
      fill_in 'Password', with: password
    end

    click_button 'Login'
  end

  def register(full_name, faculty_number, e_mail, password, confirm_password)
    visit '/user/register'

    within 'form' do
      fill_in 'Full Name', with: full_name
      fill_in 'Faculty Number', with: faculty_number
      fill_in 'Email', with: e_mail
      fill_in 'Password', with: password
      fill_in 'Confirm Password', with: confirm_password
    end

    click_button 'Register'
  end
end
