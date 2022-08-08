FactoryBot.define do
  factory :integration_wallet do
    public_key { '0xdbce37c4431e394d7892a053cbc39a411bbf25d2' }
    # rubocop:disable Layout/LineLength
    encrypted_private_key { Base64.strict_encode64("\x84\xA9\xC3\x8F\xC9+\xA6\xDBQ\xB0\xC7=\x82\xD2\xA9-%\xAC\xF9\x95xr\x92+\x99w\x0F\x1C\x18\xF0\xBC\x1D\xF1\xC6bD\x17y\xFDr\xFF1\xF7\xBD\xBF\x16;\";t.Z$ \x7F\xAACR\x1A\x981\x1E&\td\xC4_\xC6\xD9\xBB)\xFBW\xB8\x06\xA6{\xC0#\xE4") }
    # rubocop:enable Layout/LineLength
    private_key_iv { Base64.strict_encode64(")B\x82\x06\x89\xEB\x87`+;\xCD\xCD\xF5]J\xBF") }
  end
end
