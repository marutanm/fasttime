class Stamp
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  embedded_in :user

  field :start_time, type: Time
  field :end_time,   type: Time

  def working_time
    self.end_time - self.start_time - 1.hour
  end

  def start_time
    return super if super
    self.created_at
  end

  def end_time
    return super if super
    self.updated_at
  end
end
