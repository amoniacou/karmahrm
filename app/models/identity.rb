# == Schema Information
#
# Table name: identities
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Identity < ActiveRecord::Base
   belongs_to :user
   validates :uid, :provider, presence: true
   validates :uid, uniqueness: { scope: :provider }

   def self.find_for_oauth(auth)
      find_or_create_by(uid: auth.uid, provider: auth.provider)
   end
end
