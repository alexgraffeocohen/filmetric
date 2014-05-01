require 'spec_helper'

FactoryGirl.define do
  factory :director do
    name { Faker::Name.name }
  end
end