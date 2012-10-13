# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Platform.create! name: 'edx', url: 'http://edx.org', logo_url: 'https://www.edx.org/static/images/header-logo.png'
Platform.create! name: 'coursera', url: 'https://www.coursera.org/', logo_url: 'https://dt5zaw6a98blc.cloudfront.net/site-static/pages/home/template/coursera_logo_150x22.png'
