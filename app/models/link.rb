class Link < ActiveRecord::Base
	acts_as_votable
	belongs_to :user
	has_many :comments
	has_attached_file :image, styles: { medium: "300x300", thumb: "150x150#" },
	storage: :s3,
	:bucket => 'wyncode-techit',
	:s3_credentials => {
		:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    	:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']

	}
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def self.sort_by_upvotes(posts)
		posts = posts.sort{|a,b| b.get_upvotes.size <=> a.get_upvotes.size}
	end
end
