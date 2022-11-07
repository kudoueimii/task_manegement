User.create!(
  name: 'tanaka',
  email: 'tanaka@sampl.com',
  password: 'tanaka',
  password_confirmation: 'tanaka',
  admin: false)

User.create!(
  name: 'baramy1',
  email: 'baramy1@sample.com',
  password: 'baramy1',
  password_confirmation: "baramy1",
  admin: true)