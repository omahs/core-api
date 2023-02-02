module Validators
    class WalletAddress
        def self.valid?(address)
            address =~ /\A0x[a-fA-F0-9]{40}\z/
        end
    end
end