FastTime::App.controllers  do

  before { @now = Time.now }

  get :index do
    redirect "/list/#{@now.year}/#{@now.month}"
  end

  get :list, :with => [:year, :month] do
    logger.info "#{params[:year]}/#{params[:month]}"

    first_day = Time.new params[:year], params[:month], 1
    @stamps = Stamp.between(created_at: first_day..(first_day + 1.month))

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
