FactoryGirl.define do

  factory :message do
    message         "test"
    image        ""
    user    #users.rbの中身を継承
    group   #groups/rbの中身を継承
  end

end
