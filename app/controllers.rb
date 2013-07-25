FastTime::App.controllers  do

  layout :default
  before do
    @now = Time.now
    if env['warden'].authenticated?
      @current_user = User.find_by(github_id: env['warden'].user.id)
    end
  end

  get :login do
    env['warden'].authenticate!

    user = env['warden'].user
    @current_user = User.find_or_create_by(github_id: user.id) do |u|
      u.name = user.login
      u.gravatar_id = user.gravatar_id
    end

    redirect '/'
  end

  get :logout do
    env['warden'].logout

    redirect '/'
  end

  get :index do
    redirect "/#{@now.year}/#{@now.month}" if env['warden'].authenticated?

    render :index
  end

  get :index, :with => [:year, :month] do
    redirect url(:index) unless env['warden'].authenticated?

    @first_day = Date.new params[:year].to_i, params[:month].to_i, 1
    @last_day = Date.new params[:year].to_i, params[:month].to_i, -1
    stamps = @current_user.stamps.between(created_at: @first_day..@last_day)

    @stamps = stamps.inject({}){|h, s| h[s.created_at.day] = s; h}
    @total_time = stamps.inject(0){|total, s| total + s.working_time }

    render :list
  end

  post :time do
    today = @now.to_date
    tomorrow = today + 1.day

    stamp = @current_user.stamps.between(created_at: today..tomorrow).first
    stamp ||= @current_user.stamps.create
    stamp.update_attribute(:updated_at, @now)

    working_time = '-'
    if stamp.working_time > 0
      hour, mod = stamp.working_time.divmod 1.hour
      min, sec = mod.divmod 1.minute
      working_time = format("%02d:%02d", hour, min)
    end
    { start_time:   stamp.created_at.strftime('%H:%M'),
      end_time:     stamp.updated_at.strftime('%H:%M'),
      working_time: working_time }.to_json
  end

end
