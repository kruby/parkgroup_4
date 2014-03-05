class Menu < ActiveRecord::Base
    
	has_one :content, :as => :resource, :dependent => :destroy
  
	after_create :make_content
	after_update :update_content
  
	def make_content
		c = Content.new
		c.resource = self #fordi jeg bruger after_create kan jeg bruge self til at få id fra den aktuelle post
		c.active = self.active
		c.navlabel = self.name
		c.controller_name = self.name.downcase
		c.category = 'Admin'
		I18n.locale = 'da'
		c.navlabel = (I18n.t self.name.downcase).capitalize
		c.save
	end
  
	def update_content
		c = Content.find_by_resource_id_and_resource_type(self.id, 'Menu')
		c.navlabel = self.name
		c.active = self.active
		c.save
	end
  
end
