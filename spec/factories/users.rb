FactoryGirl.define do

  factory :user do
    name                       {Faker::Name.name}
    email                      {Faker::Internet.email}
    password                   "hogehoge"
    password_confirmation      "hogehoge"
  end

end