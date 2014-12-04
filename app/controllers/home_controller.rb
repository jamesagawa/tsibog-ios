class HomeViewController < UIViewController

  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor
    view.userInteractionEnabled = true
    @button = showSearchButton
    @suggestion = add_suggestion_area
  end

  def searchStore
    @suggestion.animateHideAnswer
    BubbleWrap::HTTP.get("http://localhost:3000/companies.json") do |response|
      result_data = BubbleWrap::JSON.parse(response.body.to_str)
      update_suggestion_area( Restaurant.new(result_data) )
    end
  end

  def add_suggestion_area
    suggestion = SuggestionView.new
    view.addSubview suggestion.view
    suggestion
  end

  def update_suggestion_area(restaurant)
    @suggestion.updateRestaurant(restaurant)
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

  def screen_width
    view.frame.size.width
  end

end

