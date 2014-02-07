class Post < ActiveRecord::Base
	
  default_scope { order('created_at DESC') }        
	
  validates_presence_of :title
	
	has_many :attachments, :as => :attachable
	has_many :subpages, :class_name => 'Post', :foreign_key => 'parent_id', :dependent => :destroy
  
	acts_as_tree :order => 'created_at DESC'
  
	#scope :forside_blogs_active, :conditions => ["active", true], :order => 'created_at DESC'
	scope :forside_blogs_active, -> {where(active: true)}
  
	scope :activated, -> {where(active: true)}
	scope :no_parent, -> {where(parent_id: nil)}

	#scope :admin_pages, :conditions => ["parent_id IS NULL and active", true], :order => 'position'  
	#scope :admin_pages, -> {where(self.activated.no_parent)}
  
	def self.latest
		order('created_at desc')
	end
	
	def self.by_priority
		order('priority asc')
	end
	
	def self.search(search, page)
		paginate  :per_page => 10, :page => page,
		:conditions => ['parent_id is NULL'],
		#:conditions => "active = 1 and name like '%#{search}%'", #De 2 nedenfor sammenskrevet til 1 linie og med AND
		#:conditions => ['active = ?', 1],
		#:conditions => ['name like ?', "%#{search}%"],
		:order => 'created_at DESC'
	end
  
  
end
