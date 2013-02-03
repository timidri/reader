class Tape
  PROPERTIES = [:name, :url, :speaker, :city, :venue, :date, :downloads]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(properties = {})
    properties.each do |key, value|
      if PROPERTIES.member? key.to_sym
        self.send("#{key}=", value)
      end
    end
  end

  def name
    speaker + ( city == nil || city.empty? ? "" : " from #{city}" )
  end
end
