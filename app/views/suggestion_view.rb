class SuggestionView
  attr_accessor :view, :restaurant, :name, :address, :map


  def initialize
    self.view = UIView.alloc.init
    self.view.userInteractionEnabled = true
    @name = showName
    @address = showAddress

    @map = showMap
  end

  def showMap
    map = MKMapView.alloc.init
    map.frame = [
      [10, 270],
      [300, 250]
    ]
    map.alpha = 0
    map.mapType = ::MKMapTypeStandard
    view.addSubview map
    map
  end

  def updateMap
    @map.annotations.each do |a|
      @map.removeAnnotation(a)
    end

    coordinates = CLLocationCoordinate2DMake(self.restaurant.coordinates[0], self.restaurant.coordinates[1])
    region      = MKCoordinateRegionMake(coordinates, MKCoordinateSpanMake(0.01, 0.01))
    @map.setRegion region
    @annotation = MapAnnotation.new(self.restaurant.coordinates[0], self.restaurant.coordinates[1], 'In here')
    @map.addAnnotation(@annotation)
    @map.alpha = 1
  end


  def updateRestaurant(restaurant)
    self.restaurant = restaurant
    animateShowAnswer
  end

  def animateShowAnswer
    UIView.animateWithDuration(0.5,
      animations:lambda {
        @name.alpha = 0
        @name.text = restaurant.name
        UIView.animateWithDuration(1.0,
          animations:lambda {
            @name.alpha = 1
            @name.transform = CGAffineTransformIdentity
            @address.text = restaurant.address
            @address.alpha = 1
          },
          completion:lambda{ |finished|
            updateMap
          }
        )
      }
    )
  end

  def animateHideAnswer
    UIView.animateWithDuration(1.0,
      animations:lambda{
        @name.alpha = 0
        @address.alpha = 0
        @map.alpha = 0
      },
      completion:lambda{ |finished|
        @name.text = ''
        @address.text = ''
        @name.transform = CGAffineTransformMakeScale(0.1, 0.1)
      }
    )
  end

  def showName
    label = UILabel.alloc.initWithFrame([[10, 150], [screen_width - 20, 40]])
    label.backgroundColor = UIColor.clearColor
    label.text = ""
    label.font = UIFont.boldSystemFontOfSize(15)
    label.textColor = UIColor.redColor
    label.textAlignment = UITextAlignmentCenter

    view.addSubview label
    label
  end

  def showAddress
    label = UILabel.alloc.initWithFrame([[10, 190], [screen_width - 20, 50]])
    label.backgroundColor = UIColor.clearColor
    label.text = ""
    label.font = UIFont.boldSystemFontOfSize(11)
    label.textColor = UIColor.grayColor
    label.textAlignment = UITextAlignmentCenter

    view.addSubview label
    label
  end


  def screen_width
    320
  end

end
