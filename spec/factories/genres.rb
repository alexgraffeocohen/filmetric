require 'spec_helper'

FactoryGirl.define do
  factory :genre do
    name { Faker::Name.name }
  end
end