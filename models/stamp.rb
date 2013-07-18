class Stamp
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  def working_time
    self.updated_at - self.created_at
  end
end
