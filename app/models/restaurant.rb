class Restaurant
  PROPERTIES = [:name, :categories, :address, :coordinates]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end


  def initialize(properties = {})
    properties.each do |key, value|
      if PROPERTIES.member? key.to_sym
        self.send("#{key}=", value)
      end
    end

    symbolize_categories
  end

  def symbolize_categories
    @categories = @categories.map do |cat|
      hash = {}
      cat.each do |key, value|
        hash[key.to_sym] = value
      end
      hash
    end
  end

end
