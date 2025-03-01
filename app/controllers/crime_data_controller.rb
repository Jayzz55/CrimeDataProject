class CrimeDataController < ApplicationController

  def index
    cookies[:path] = {
      :value => params[:selection],
      :expires => 1.year.from_now
    }
    now = DateTime.now.utc
    time = now.in_time_zone('Brisbane')
    hour = time.hour
    month = time.month

    # lga = PostcodeLgaLookup.where(postcode: cookies[:postcode]).first["lga"]
    risk = CrimeDatum.where(category: cookies[:path], local_authority: cookies[:location], season: season_helper(month), time: time_helper(hour)).first

    case risk.light
    when "Red"
      @colour = "danger"
    when "Amber"
      @colour = "warning"
    when "Green"
      @colour = "success"
    end

  end

  def show

  end

  def data

  end

  private
  def time_helper(time)
    return "Morning" if time < 12
    return "Afternoon" if time < 17
    return "Evening" if time < 21
    "Night"
  end

  def season_helper(month)
    return "Autumn" if month < 6 && month > 2
    return "Winter" if month < 9
    return "Spring" if month < 12
    "Summer"
  end
end
