require 'json'

User.create(email: 'user@example.com', password: 'secret', password_confirmation: 'secret')

verticals_file = File.read('./json/verticals.json')
categories_file = File.read('./json/categories.json')
courses_file = File.read('./json/courses.json')

verticals_data = JSON.parse(verticals_file)
categories_data = JSON.parse(categories_file)
courses_data = JSON.parse(courses_file)

# seed vertical data
verticals_data.each do |vertical_data|
  vertical = Vertical.find_or_initialize_by(id: vertical_data['Id'])
  vertical.name = vertical_data['Name']
  p vertical if vertical.save!
end

# seed category data
categories_data.each do |category_data|
  category = Category.find_or_initialize_by(id: category_data['Id'])
  category.name = category_data['Name']
  category.state = category_data['State']
  category.vertical_id = category_data['Verticals']
  p category if category.save!
end

# seed course data
courses_data.each do |course_data|
  course = Course.find_or_initialize_by(id: course_data['Id'])
  course.name = course_data['Name']
  course.author = course_data['Author']
  course.state = course_data['State']
  course.category_id = course_data['Categories']
  p course if course.save!
end

# resetting primary key sequence
ActiveRecord::Base.connection.reset_pk_sequence!('verticals')
ActiveRecord::Base.connection.reset_pk_sequence!('categories')
ActiveRecord::Base.connection.reset_pk_sequence!('courses')
