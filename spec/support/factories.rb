require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

FactoryGirl.define do
  factory :student, class: User do
    full_name 'Ashley Cole'
    faculty_number 20722
    e_mail 'a.cole@gmail.com'
    password '123456'
  end

  factory :admin, class: User do
    full_name 'Adam Smith'
    faculty_number 99999
    e_mail 'a.smith@gmail.com'
    password '123456'
    admin true
  end
end
