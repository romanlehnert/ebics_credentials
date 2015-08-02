require 'spec_helper'


describe EbicsCredentials do
  let(:credential_hash) do
    {
      key: "key",
      passphrase: "passphrase",
      url: "url",
      host_id: "host_id",
      user_id: "user_id",
      partner_id: "partner_id"
    }
  end

  describe '.from_encoded_json' do
    context 'given valid credentials' do
      let(:encoded_json) { Base64.encode64(credential_hash.to_json) }

      it 'returns a EbicsCredentials instance' do
        expect(described_class.from_encoded_json(encoded_json)).to be_a(EbicsCredentials)
      end

      it 'initializes the EbicsCredentials with the credential hash' do
        expect(EbicsCredentials).to receive(:new).with(credential_hash)

        described_class.from_encoded_json(encoded_json)
      end
    end

    context 'given nil' do
      let(:encoded_json) { nil }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(EbicsCredentials::Errors::Empty)
      end
    end

    context 'given an empty string' do
      let(:encoded_json) { "" }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(EbicsCredentials::Errors::Empty)
      end
    end

    context 'given unparseable json' do
      let(:encoded_json) { "asd" }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(EbicsCredentials::Errors::Invalid)
      end
    end

    context 'given a hash' do
      let(:encoded_json) { {a: "asd"}  }

      it 'raises an error' do
        expect{described_class.from_encoded_json(encoded_json)}.
          to raise_error(EbicsCredentials::Errors::Invalid)
      end
    end
  end


  describe 'attribute readers' do
    subject { described_class.new(credential_hash) }

    it 'provides public access to the credentials' do
      expect(subject.key).to eql("key")
      expect(subject.passphrase).to eql("passphrase")
      expect(subject.host_id).to eql("host_id")
      expect(subject.user_id).to eql("user_id")
      expect(subject.partner_id).to eql("partner_id")
      expect(subject.url).to eql("url")
    end
  end

  describe '#valid?' do
    it 'returns false when one of the keys is missing' do
      [:key, :passphrase, :user_id, :host_id, :partner_id, :url].each do |key|
        expect(described_class.new(credential_hash.merge!({key => nil}))).to_not be_valid
      end
    end

    it 'returns true when none of the keys is missing' do
      expect(described_class.new(credential_hash)).to be_valid
    end
  end

  describe 'validate!' do
    it 'raises an error when one of the keys is missing' do
      [:key, :passphrase, :user_id, :host_id, :partner_id, :url].each do |key|
        subject = described_class.new(credential_hash.merge!({key => nil}), validate: false)
        expect{ subject.validate! }.to raise_error(EbicsCredentials::Errors::Invalid)
      end
    end
  end

  describe '#to_h' do
    it 'returns a credentials hash' do
      subject = described_class.new(credential_hash)
      expect(subject.to_h).to eql(credential_hash)
    end
  end

  describe '#to_json' do
    it 'returns a jsonified credentials hash' do
      subject = described_class.new(credential_hash)
      expect(subject.to_json).to eql(credential_hash.to_json)
    end
  end
end
