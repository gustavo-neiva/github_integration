FactoryBot.define do
  factory :user, class: User do
    email { "woompa@loompa.com" }
    username{ "woompa" }
    password {'123456'}
    name {"Woompa Loompa"}
    password_digest { BCrypt::Password.create(password) }
  end
end
