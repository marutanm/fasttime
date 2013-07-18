FastTime::App.controllers  do

  before { @now = Time.now }
  layout :default

  get :index do
    redirect "/list/#{@now.year}/#{@now.month}"
  end

  get :list, :with => [:year, :month] do

    @first_day = Date.new params[:year].to_i, params[:month].to_i, 1
    @last_day = Date.new params[:year].to_i, params[:month].to_i, -1
    stamps = Stamp.between(created_at: @first_day..@last_day)

    @stamps = stamps.inject({}){|h, s| h[s.created_at.day] = s; h}
    @total_time = stamps.inject(0){|total, s| total + s.working_time }

    render :list
  end

  post :time do
    today = @now.to_date
    tomorrow = today + 1.day

    stamp = Stamp.between(created_at: today..tomorrow).first
    stamp ||= Stamp.create
    stamp.update_attribute(:updated_at, @now)

    200
  end

end
