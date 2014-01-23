task :migrate_old_data => [ :delete_all_in_new, :old_menus, :old_pages, :old_content, :old_posts]

task :delete_all_in_new => :environment do
  ActiveRecord::Base.establish_connection :development
  del = Menu.all.count
  Menu.destroy_all
  puts "Ialt slettet #{del}"
  del = Page.all.count
  Page.destroy_all
  puts "Ialt slettet #{del}"
  del = Content.all.count
  Content.destroy_all
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
  old_menus.each do |m_old|
    menu_new = Menu.new
    menu_new.attributes = {
      :name => m_old.name,
      :title => m_old.title,
      :body => m_old.body,
      :active => m_old.active
    }
    menu_new.id = m_old.id
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
  old_pages.each do |p_old|
    page_new = Page.new
    page_new.attributes = {
      :name => p_old.name,
      :title => p_old.title,
      :body => p_old.body,
      :headline => p_old.headline,
      :active => p_old.active
    }
    page_new.id = p_old.id
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
  old_content.each do |c_old|
    content_new = Content.new
    content_new.attributes = {
      :resource_id => c_old.resource_id,
      :resource_type => c_old.resource_type,
      :parent_id => c_old.parent_id,
      :navlabel => c_old.navlabel,
      :active => c_old.active,
      #:admin => c_old.admin,
      :redirect => c_old.redirect,
      :position => c_old.position,
      :controller_name => c_old.controller_name,
      :category => c_old.category,
      :controller_redirect => c_old.controller_redirect,
      :action_redirect => c_old.action_redirect
    }
    content_new.id = c_old.id
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
  old_posts.each do |c_old|
    post_new = Post.new
    post_new.attributes = {
      :title => c_old.title,
      :body => c_old.body,
      :author => c_old.author,
      :priority => c_old.priority,
      :parent_id => c_old.parent_id,
      :user_id => c_old.user_id,
      :active => c_old.active
    }
    post_new.id = c_old.id
    post_new.save!
  end
end