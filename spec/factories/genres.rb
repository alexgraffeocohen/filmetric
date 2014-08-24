require 'faker'

FactoryGirl.define do
  factory :genre do
    name "Action"
    filmetric { -5 }
  end
end
