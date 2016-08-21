module Nearby
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_nearby(relation, lat, lng, limit, radius)
      pt = Geokit::LatLng.new(lat, lng)
      relation.map do |obj|
        obj_pt = Geokit::LatLng.new(obj.nearby_latitude, obj.nearby_longitude)
        dist = pt.distance_to(obj_pt)
        if dist < radius
          [dist, obj]
        else
          nil
        end
      end.compact.sort do |a, b|
        a[0] <=> b[0]
      end.map {|pair| pair[1]}[0..limit-1]
    end
  end
end