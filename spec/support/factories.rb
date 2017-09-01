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
end
