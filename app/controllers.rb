FastTime::App.controllers  do

  layout :default
  before do
    @now = Time.now
    if env['warden'].authenticated?
      @current_user = User.find_by(github_id: env['warden'].user.id)
    end
  end

  get :index do
    redirect "/list/#{@now.year}/#{@now.month}" if env['warden'].authenticated?

    render :index, layout: false
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
