class MapAnnotation

  def initialize(latitude, longitude, title)
    @name = title
    @title = title
    @coordinate = CLLocationCoordinate2D.new(latitude, longitude)
  end

 def coordinate; @coordinate; end

end
