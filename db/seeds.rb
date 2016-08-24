# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
User.create(email: 'lee@naver.com', encrypted_password: '976485')
User.create(email: 'jong@naver.com', encrypted_password: '976485')
User.create(email: 'hoon@naver.com', encrypted_password: '976485')
