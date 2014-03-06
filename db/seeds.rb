# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(name: 'Thomas Schmidt', email: 'ts@kruby.dk', password: 'kf1737', password_confirmation: 'kf1737', category: 'Admin', blogname: 'TKS', active: true)
User.create(name: 'Claus Trampedach', email: 'ct@parkgroup.dk', password: 'huskdetnu', password_confirmation: 'huskdetnu', category: 'Admin', blogname: 'CT', active: true)

Menu.create(name: 'Pages', title: 'Pages', body: 'Link til Pages', active: true)
Menu.create(name: 'Contents', title: 'Contents', body: 'Link til Contents', active: true)
Menu.create(name: 'Menus', title: 'Menus', body: 'Link til Menus', active: true)
Menu.create(name: 'Posts', title: 'Posts', body: 'Link til posts', active: true)
Menu.create(name: 'Assets', title: 'Assets', body: 'Link til Assets', active: true)
Menu.create(name: 'Attachments', title: 'Attachments', body: 'Link til Attachments', active: true)
Menu.create(name: 'Users', title: 'Users', body: 'Link til Users', active: true)
Menu.create(name: 'Partners', title: 'Partners', body: 'Link til Partners', active: true)
Menu.create(name: 'Contacts', title: 'Contacts', body: 'Link til Contacts', active: true)
Menu.create(name: 'Preferences', title: 'Preferences', body: 'Link til Preferences', active: true)

Page.create(name: 'Forside', title: 'Velkommen til Park Group', headline: 'h1. Velkommen til Park Group', body: 'Park Group beskæftiger sig med...', active: true)
Page.create(name: 'Kontakt', title: 'Park Group kontakt informationer', headline: 'h1. Kontakt information', body: 'Park Group kan kontaktes på:', active: true)

c = Content.where(navlabel: 'Forside').first
c.controller_name = ''
c.save
c = Content.where(navlabel: 'Kontakt').first
c.controller_name = 'kontakt'
c.save