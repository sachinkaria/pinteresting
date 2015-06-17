class Pin < ActiveRecord::Base
     belongs_to :user
     belongs_to :category
     has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
     validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
     acts_as_taggable
     validates :date, presence: true
     validates :title, presence: true
     validates :description, presence: true
     validates :image, presence: true
end