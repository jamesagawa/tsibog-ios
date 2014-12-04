class HomeViewController < UIViewController

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor
    view.userInteractionEnabled = true
    @button = showSearchButton
    @label = showResultLabel
  end

  def searchStore
    BubbleWrap::HTTP.get("http://localhost:3000/companies.json") do |response|
      result_data = BubbleWrap::JSON.parse(response.body.to_str)
      animateShowAnswer result_data
    end
  end

  def animateShowAnswer(answer_data)
    UIView.animateWithDuration(1.0,
      animations:lambda {
        @label.alpha = 0
        @label.transform = CGAffineTransformMakeScale(0.1, 0.1)
      },
      completion:lambda { |finished|
        @label.text = answer_data["name"]
        UIView.animateWithDuration(1.0,
          animations:lambda {
            @label.alpha = 1
            @label.transform = CGAffineTransformIdentity
          }
        )
      }
    )
  end

  def showSearchButton
    button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    button.center = CGPointZero
    button.setTitle("Saan Tayo Kakain?", forState: UIControlStateNormal)
    button.backgroundColor = UIColor.redColor
    button.setTitleColor(UIColor.whiteColor, forState: UIControlStateNormal)
    button.frame = [
      [10, 75],
      [screen_width - 20, 50]
    ]
    button.addTarget(self,
                 action: 'searchStore',
                 forControlEvents: UIControlEventTouchUpInside)
    view.addSubview button
    button
  end

  def showResultLabel
    label = UILabel.alloc.initWithFrame([[10, 150], [screen_width - 20, 50]])
    label.backgroundColor = UIColor.clearColor
    label.text = ""
    label.font = UIFont.boldSystemFontOfSize(15)
    label.textColor = UIColor.redColor
    label.textAlignment = UITextAlignmentCenter

    view.addSubview label
    label
  end

  def screen_width
    view.frame.size.width
  end

end

