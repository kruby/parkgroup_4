class Attachment < ActiveRecord::Base
  
	acts_as_list #SÅSNART EN ATTACHMENT BLIVER OPRETTET VED AT HÆFTE DEN PÅ ET INDLÆG, SÅ FÅR POSITION EN VÆRDI.
  belongs_to :attachable, :polymorphic => true
  
end
