FastTime::App.controllers  do

  post :time do
    now = Time.now
    today = now.to_date
    tomorrow = today + 1.day

    stamp = Stamp.between(created_at: today..tomorrow).first 
    stamp ||= Stamp.create
    stamp.update_attribute(:updated_at, now)

    200
  end

end
