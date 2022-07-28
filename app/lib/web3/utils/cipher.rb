module Web3
  module Utils
    class Cipher
      SECRET_KEY = RibonCoreApi.config[:openssl][:ribon_secret_openssl_key]

      def self.encrypt(plain_text)
        cipher     = cypher_instance.encrypt
        iv         = cipher.random_iv
        cipher.key = sha256_key

        OpenStruct.new({
                         cypher_text: cipher.update(plain_text) + cipher.final,
                         iv:
                       })
      end

      def self.decrypt(cypher_text, cypher_iv)
        decipher     = cypher_instance.decrypt
        decipher.iv  = cypher_iv
        decipher.key = sha256_key

        OpenStruct.new({
                         plain_text: decipher.update(cypher_text) + decipher.final
                       })
      end

      def self.cypher_instance
        OpenSSL::Cipher.new('aes-256-cbc')
      end

      def self.sha256_key
        ::Digest::SHA256.digest SECRET_KEY
      end
    end
  end
end
