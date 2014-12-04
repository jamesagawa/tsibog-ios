class SuggestionView
  attr_accessor :view, :restaurant, :name, :address


  def initialize
    self.view = UIView.alloc.init
    self.view.userInteractionEnabled = true
    @name = showName
    @address = showAddress
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
      },
      completion:lambda{ |finished|
        @name.text = ''
        @address.text = ''
        @name.transform = CGAffineTransformMakeScale(0.1, 0.1)
      }
    )
  end

  def showName
    label = UILabel.alloc.initWithFrame([[10, 150], [screen_width - 20, 50]])
    label.backgroundColor = UIColor.clearColor
    label.text = ""
    label.font = UIFont.boldSystemFontOfSize(15)
    label.textColor = UIColor.redColor
    label.textAlignment = UITextAlignmentCenter

    view.addSubview label
    label
  end

  def showAddress
    label = UILabel.alloc.initWithFrame([[10, 210], [screen_width - 20, 50]])
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
