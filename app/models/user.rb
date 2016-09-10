class User < ApplicationRecord

  has_many :leave_years

  validates :uid, :provider, :name, presence: true

  def self.from_omniauth(auth)
    if auth.provider == 'google_oauth2'
      return unless valid_domain_for?(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.update(user_hash_from(auth))
        user.save!
      end
    end
  end

  def self.valid_domain_for?(auth)
    auth.extra[:id_info][:hd] == ENV['GOOGLE_DOMAIN']
  end

  def self.user_hash_from(auth)
    {
      provider: auth.provider,
      uid: auth.uid,
      name: auth.info.name,
      oauth_token: auth.credentials.token,
      oauth_expires_at: Time.zone.at(auth.credentials.expires_at)
    }
  end
end
