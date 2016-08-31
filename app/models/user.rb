class User < ApplicationRecord

  validates :uid, :provider, :name, presence: true

  def self.from_omniauth(auth)
    if valid_domain_for?(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
  end

  private

  def self.valid_domain_for?(auth)
    auth.extra[:id_info][:hd] == ENV['GOOGLE_DOMAIN']
  end
end
