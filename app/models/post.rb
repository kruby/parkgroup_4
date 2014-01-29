class Post < ActiveRecord::Base
  has_many :attachments, :as => :attachable
  has_many :subpages, :class_name => 'Post', :foreign_key => 'parent_id', :dependent => :destroy
  
  acts_as_tree :order => 'created_at DESC'
  
  #scope :forside_blogs_active, :conditions => ["active", true], :order => 'created_at DESC'
  scope :forside_blogs_active, -> {where(active: true)}
  
  scope :active, -> {where(active: true).order(:position)}
  scope :no_parent, -> {where(parent_id: nil)}

  #scope :admin_pages, :conditions => ["parent_id IS NULL and active", true], :order => 'position'  
  scope :admin_pages, self.active.no_parent
  
  def self.search(search, page)
    paginate  :per_page => 10, :page => page,
              :conditions => ['parent_id is NULL'],
              #:conditions => "active = 1 and name like '%#{search}%'", #De 2 nedenfor sammenskrevet til 1 linie og med AND
              #:conditions => ['active = ?', 1],
              #:conditions => ['name like ?', "%#{search}%"],
              :order => 'created_at DESC'
  end
  
  
end
