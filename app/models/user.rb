class User < ApplicationRecord

  devise :registerable, :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
end
