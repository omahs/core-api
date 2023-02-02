module Validators
    class Email
        def self.valid?(email)
            email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
        end
    end
end
