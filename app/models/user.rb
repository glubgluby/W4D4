class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true

    attr_reader :password

    after_initialize :ensure_session_token
    #PREFIG
    def password=(passkey)
        @password = passkey
        self.password_digest = BCrypt::Password.create(passkey) 
    end
   

    def self.find_by_credentials(email, password)
        u = User.find_by(email: email)
        return nil if u.nil?
        u.is_password?(password) ? u : nil
    end

    def reset_session_token!
        self.generate_session_token
        self.save!
        self.session_token
    end

    

    def generate_session_token
        self.session_token = SecureRandom.urlsafe_base64(16)
    end

    def is_password?(passkey)
        BCrypt::Password.new(self.password_digest).is_password?(passkey)
    end

    private


    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64(16)
    end
end