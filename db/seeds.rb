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

  10.times do |i|
    Task.create!( title: "sample_title#{i+1}", detail: "sample_content#{i+1}",    deadline_at: "2022-11-11",    status: "waiting",    priority: "高",    user_id: 3)
  end