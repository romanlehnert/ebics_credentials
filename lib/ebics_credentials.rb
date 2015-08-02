require 'base64'
require 'json'

class EbicsCredentials

  module Errors
    class Base < StandardError; end
    class Empty < Base
      def to_s
        "empty ebics credentials"
      end
    end
    class Invalid < Base
      def to_s
        "invalid ebics credentials"
      end
    end
  end

  extend Forwardable

  attr_reader :credentials

  def_delegators :@credentials, :key, :key=
  def_delegators :@credentials, :passphrase, :passphrase=
  def_delegators :@credentials, :url, :url=
  def_delegators :@credentials, :host_id, :host_id=
  def_delegators :@credentials, :partner_id, :partner_id=
  def_delegators :@credentials, :user_id, :user_id=

  def self.from_encoded_json(encoded_json)
    raise Errors::Empty if encoded_json.nil? || encoded_json.empty? 
    raise Errors::Invalid if !encoded_json.is_a?(String)

    begin
      credential_hash = JSON.parse(Base64.decode64(encoded_json), symbolize_names: true)
    rescue => error
      if error.is_a?(JSON::ParserError) 
        raise Errors::Invalid
      else
        raise error
      end
    end

    self.new(credential_hash)
  end

  def initialize(credential_hash, options = {})
    @credentials = OpenStruct.new(credential_hash)
    validate! unless !options[:validate]
  end

  def to_h
    @credentials.to_h
  end

  def to_json
    to_h.to_json
  end

  def keys
    [:key, :passphrase, :user_id, :host_id, :partner_id, :url]
  end

  def valid?
    keys.each do |key|
      return false if @credentials[key].nil? || @credentials[key].empty?
    end
  end

  def validate!
    raise Errors::Invalid unless valid?
  end
end
