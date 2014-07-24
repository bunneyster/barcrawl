require 'openssl'
require 'base64'

module Obfuscate
  extend ActiveSupport::Concern
  
  def self.included(base)
    base.extend self
  end
  
  def cipher
    OpenSSL::Cipher::AES.new(256, :CBC)
  end
  
  def cipher_key
    'hellomynameis...'
  end
  
  def decrypt(value)
    c = cipher.decrypt
    c.key = Digest::SHA256.digest(cipher_key)
    c.update(Base64.urlsafe_decode64(value.to_s)) + c.final
  end
  
  def encrypt(value)
    c = cipher.encrypt
    c.key = Digest::SHA256.digest(cipher_key)
    Base64.urlsafe_encode64(c.update(value.to_s) + c.final)
  end
end