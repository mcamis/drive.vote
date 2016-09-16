module RideZoneParams
  extend ActiveSupport::Concern

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ride_zone(param = :id)
    @ride_zone = RideZone.find_by_id(params[param]) || RideZone.find_by_slug(params[param])
  end

  # Only allow a trusted parameter "white list" through.
  def ride_zone_params
    params.require(:ride_zone).permit(:name, :description, :phone_number, :short_code, :city, :county,
                                      :state, :zip, :country, :latitude, :longitude, :slug, :bot_disabled,
                                      :admin_name, :admin_email, :admin_phone_number, :admin_password)
  end

end
