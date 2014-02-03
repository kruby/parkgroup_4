# Denne rake task flytter alle de gamle data fra en gammel database til en ny database for et nyt projekt.
# Har bl.a. brugt den i forbindelse med overførsel af data da kruby.dk blev opdateret fra at være et rails 3 og ruby 1.8.7 site til at blive et rails 4 og ruby 2.1 site.
# Skal placeres i dit rails projekt under stien lib/tasks
# Kan manuelt startes med kommandoen $ rake migrate_old_data direkte i terminal programmet

task :migrate_old_data => [ :delete_all_in_new, :old_pages, :old_menus, :old_content, :old_posts, :old_assets, :old_attachments, :old_hours, :old_relations, :old_users, :old_vouchers ]

# Alle data i den nye database bliver slettet her
task :delete_all_in_new => :environment do
	ActiveRecord::Base.establish_connection :development
	del = Page.all.count
	Page.destroy_all
	puts "Ialt slettet #{del}"
	del = Menu.all.count
	Menu.destroy_all
	puts "Ialt slettet #{del}"
	del = Content.all.count
	Content.destroy_all
	puts "Ialt slettet #{del}"
	del = Post.all.count
	Post.destroy_all
	puts "Ialt slettet #{del}"
	del = Asset.all.count
	Asset.destroy_all
	puts "Ialt slettet #{del}"
	del = Attachment.all.count
	Attachment.destroy_all
	puts "Ialt slettet #{del}"
	del = Hour.all.count
	Hour.destroy_all
	puts "Ialt slettet #{del}"
	del = Relation.all.count
	Relation.destroy_all
	puts "Ialt slettet #{del}"
	del = User.all.count
	User.destroy_all
	puts "Ialt slettet #{del}"
	del = Voucher.all.count
	Voucher.destroy_all
	puts "Ialt slettet #{del}"
end

task :old_menus => :environment do
	desc "Overfører de gamle poster fra menus til den ny database"
	Menu.establish_connection :old_development
	@old_menus = Menu.all
	@old_menus.each do |menu|
		puts "Navnet på 'menu' er: #{menu.name}"
	end
	puts "----------------------------------"
	new_menus(@old_menus)
end

def new_menus(old_menus)
	Menu.establish_connection :development
	old_menus.each do |menu_old|
		menu_new = Menu.new
		menu_new.attributes = {
			:name => menu_old.name,
			:title => menu_old.title,
			:body => menu_old.body,
			:active => menu_old.active
		}
		menu_new.id = menu_old.id
		menu_new.save!
	end
end

task :old_pages => :environment do
	desc "Overfører de gamle poster fra pages til den ny database"
	Page.establish_connection :old_development
	@old_pages = Page.all
	@old_pages.each do |page|
		puts "Navnet på 'page' er: #{page.name}"
	end
	puts "----------------------------------"
	new_pages(@old_pages)
end

def new_pages(old_pages)
	Page.establish_connection :development
	old_pages.each do |page_old|
		page_new = Page.new
		page_new.attributes = {
			:name => page_old.name,
			:title => page_old.title,
			:body => page_old.body,
			:headline => page_old.headline,
			:active => page_old.active
		}
		page_new.id = page_old.id
		page_new.save!
	end
end

task :old_content => :environment do
	desc "Overfører de gamle poster fra content til den ny database"
	Content.establish_connection :old_development
	@old_content = Content.all
	@old_content.each do |content|
		puts "Navnet på 'content' er: #{content.navlabel}"
	end
	puts "----------------------------------"
	new_content(@old_content)
end

def new_content(old_content)
	Content.establish_connection :development
	Content.destroy_all
	old_content.each do |content_old|
		content_new = Content.new
		content_new.attributes = {
			:resource_id => content_old.resource_id,
			:resource_type => content_old.resource_type,
			:parent_id => content_old.parent_id,
			:navlabel => content_old.navlabel,
			:active => content_old.active,
			#:admin => content_old.admin,
			:redirect => content_old.redirect,
			:position => content_old.position,
			:controller_name => content_old.controller_name,
			:category => content_old.category,
			:controller_redirect => content_old.controller_redirect,
			:action_redirect => content_old.action_redirect
		}
		content_new.id = content_old.id
		content_new.save!
	end
end

task :old_posts => :environment do
	desc "Overfører de gamle poster fra post til den ny database"
	Post.establish_connection :old_development
	@old_posts = Post.all
	@old_posts.each do |post|
		puts "Navnet på 'post' er: #{post.title}"
	end
	puts "----------------------------------"
	new_post(@old_posts)
end

def new_post(old_posts)
	Post.establish_connection :development
	Post.destroy_all
	old_posts.each do |post_old|
		post_new = Post.new
		post_new.attributes = {
			:title => post_old.title,
			:body => post_old.body,
			:author => post_old.author,
			:priority => post_old.priority,
			:parent_id => post_old.parent_id,
			:user_id => post_old.user_id,
			:active => post_old.active
		}
		post_new.id = post_old.id
		post_new.save!
	end
end

task :old_assets => :environment do
	desc "Overfører de gamle poster fra asset til den ny database"
	Asset.establish_connection :old_development
	@old_assets = Asset.all
	@old_assets.each do |asset|
		puts "Navnet på 'asset' er: #{asset.description}"
	end
	puts "----------------------------------"
	new_asset(@old_assets)
end

def new_asset(old_assets)
	Asset.establish_connection :development
	Asset.destroy_all
	old_assets.each do |asset_old|
		asset_new = Asset.new
		asset_new.attributes = {
			:description => asset_old.description,
			:user_id => asset_old.user_id,
			:photo_file_name => asset_old.photo_file_name,
			:photo_file_size => asset_old.photo_file_size,
			:photo_updated_at => asset_old.photo_updated_at
		}
		asset_new.id = asset_old.id
		asset_new.save!
	end
end

task :old_attachments => :environment do
	desc "Overfører de gamle poster fra attachment til den ny database"
	Attachment.establish_connection :old_development
	@old_attachments = Attachment.all
	@old_attachments.each do |attachment|
		puts "Navnet på 'attachment' er: #{attachment.description}"
	end
	puts "----------------------------------"
	new_attachment(@old_attachments)
end

def new_attachment(old_attachments)
	Attachment.establish_connection :development
	Attachment.destroy_all
	old_attachments.each do |attachment_old|
		attachment_new = Attachment.new
		attachment_new.attributes = {
			:attachable_type => attachment_old.attachable_type,
			:attachable_id => attachment_old.attachable_id,
			:description => attachment_old.description,
			:image_size => attachment_old.image_size,
			:priority => attachment_old.priority,
			:asset_id => attachment_old.asset_id
		}
		attachment_new.id = attachment_old.id
		attachment_new.save!
	end
end


task :old_hours => :environment do
	desc "Overfører de gamle poster fra hour til den ny database"
	Hour.establish_connection :old_development
	@old_hours = Hour.all
	@old_hours.each do |hour|
		puts "Navnet på 'hour' er: #{hour.description}"
	end
	puts "----------------------------------"
	new_hour(@old_hours)
end

def new_hour(old_hours)
	Hour.establish_connection :development
	Hour.destroy_all
	old_hours.each do |hour_old|
		hour_new = Hour.new
		hour_new.attributes = {
			:description => hour_old.description,
			:number => hour_old.number,
			:date => hour_old.date,
			:user_id => hour_old.user_id,
			:relation_id => hour_old.relation_id
		}
		hour_new.id = hour_old.id
		hour_new.save!
	end
end

task :old_relations => :environment do
	desc "Overfører de gamle poster fra relation til den ny database"
	Relation.establish_connection :old_development
	@old_relations = Relation.all
	@old_relations.each do |relation|
		puts "Navnet på 'relation' er: #{relation.company}"
	end
	puts "----------------------------------"
	new_relation(@old_relations)
end

def new_relation(old_relations)
	Relation.establish_connection :development
	Relation.destroy_all
	old_relations.each do |relation_old|
		relation_new = Relation.new
		relation_new.attributes = {
			:company => relation_old.company,
			:address => relation_old.address,
			:postno => relation_old.postno,
			:city => relation_old.city,
			:log => relation_old.log,
			:category => relation_old.category,
			:responsible => relation_old.responsible,
			:phone => relation_old.phone,
			:next_action => relation_old.next_action,
			:lock_version => relation_old.lock_version,
			:user_id => relation_old.user_id,
			:type => relation_old.type,
			:search_lock => relation_old.search_lock,
			:homepage => relation_old.homepage,
			:email => relation_old.email
		}
		relation_new.id = relation_old.id
		relation_new.save!
	end
end

task :old_users => :environment do
	desc "Overfører de gamle poster fra user til den ny database"
	User.establish_connection :old_development
	@old_users = User.all
	@old_users.each do |user|
		puts "Navnet på 'user' er: #{user.name}"
	end
	puts "----------------------------------"
	new_user(@old_users)
end

def new_user(old_users)
	User.establish_connection :development
	User.destroy_all
	old_users.each do |user_old|
		user_new = User.new
		user_new.attributes = {
			:name => user_old.name,
			:email => user_old.email,
			:remember_token => user_old.remember_token,
			:remember_token_expires_at => user_old.remember_token_expires_at,
			:active => user_old.active,
			:blogname => user_old.blogname
			# :password_hash => user_old.password_hash,
			# :password_salt => user_old.password_salt
		}
		user_new.id = user_old.id
		user_new.password_hash = user_old.password_hash
		user_new.password_salt = user_old.password_salt
		user_new.save!
	end
end

task :old_vouchers => :environment do
	desc "Overfører de gamle poster fra voucher til den ny database"
	Voucher.establish_connection :old_development
	@old_vouchers = Voucher.all
	@old_vouchers.each do |voucher|
		puts "Navnet på 'voucher' er: #{voucher.description}"
	end
	puts "----------------------------------"
	new_voucher(@old_vouchers)
end

def new_voucher(old_vouchers)
	Voucher.establish_connection :development
	Voucher.destroy_all
	old_vouchers.each do |voucher_old|
		voucher_new = Voucher.new
		voucher_new.attributes = {
			:description => voucher_old.description,
			:number => voucher_old.number,
			:relation_id => voucher_old.relation_id,
			:date => voucher_old.date,
			:user_id => voucher_old.user_id,
			:hourly_rate => voucher_old.hourly_rate
		}
		voucher_new.id = voucher_old.id
		voucher_new.save!
	end
end

