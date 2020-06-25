FactoryBot.define do

  factory :post do
    title { "Post about dogs" }
    body  { "Many info about dogs" }

    trait :about_dogs do
      title { "Post about dogs" }
      body  { "Many info about dogs" }
      association :topic, factory: [:topic, :dogs]
    end
    trait :about_cats do
      title { "Post about cats" }
      body  { "Many info about cats" }
      association :topic, factory: [:topic, :cats]
    end
    trait :about_hamsters do
      title { "Post about hamsters" }
      body  { "Many info about hamsters" }
      association :topic, factory: [:topic, :hamsters]
    end
    trait :about_parrots do
      title { "Post about parrots" }
      body  { "Many info about parrots" }
      association :topic, factory: [:topic, :parrots]
    end
    trait :about_minotaurs do
      title { "Post about minotaurs" }
      body  { "Many info about minotaurs" }
      association :topic, factory: [:topic, :minotaurs]
    end
  end

  factory :topic do
    trait :dogs do
      add_attribute(:alias) { "dogs" }
      title { "Dogs" }
    end
    trait :cats do
      add_attribute(:alias) { "cats" }
      title { "Cats" }
    end
    trait :hamsters do
      add_attribute(:alias) { "hamsters" }
      title { "Hamsters" }
    end
    trait :parrots do
      add_attribute(:alias) { "parrots" }
      title { "Parrots" }
    end
    trait :minotaurs do
      add_attribute(:alias) { "minotaurs" }
      title { "Minotaurs" }
    end
  end
end