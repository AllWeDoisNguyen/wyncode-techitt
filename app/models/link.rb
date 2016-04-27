class Link < ActiveRecord::Base
	acts_as_votable
	belongs_to :user
	has_many :comments
	has_attached_file :image, :url => ":s3_domain_url", styles: { medium: "300x300", thumb: "150x150#" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def self.sort_by_upvotes(posts)
		posts = posts.sort{|a,b| b.get_upvotes.size <=> a.get_upvotes.size}
	end
end
