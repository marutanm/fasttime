class User
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :github_id,   type: String
  field :name,        type: String
  field :gravatar_id, type: String

  embeds_many :stamps
end
