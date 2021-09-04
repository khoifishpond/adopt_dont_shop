FactoryBot.define do
  factory :application, class: Application do
    name {Faker::Movies::StarWars.character}
    street {Faker::Address.unique.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zipcode {Faker::Address.zip_code}
    description {Faker::Movies::StarWars.quote}
    status {"In Progress"}
  end
end