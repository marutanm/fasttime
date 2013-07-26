Fabricator(:user) do
  github_id   { 'fake_id' }
  name        { Faker::Name.name }
  gravatar_id { '205e460b479e2e5b48aec07710c08d50' }
end

