User.create!(
  name: 'tanaka',
  email: 'tanaka@sampl.com',
  password: 'tanaka',
  password_confirmation: 'tanaka',
  admin: false)

User.create!(
  name: 'baramy',
  email: 'baramy@sample.com',
  password: 'baramy',
  password_confirmation: "baramy",
  admin: true)

  10.times do |i|
    Label.create!( name: "sample#{i+1}")
  end

  