class Tape
  PROPERTIES = [:url, :speaker, :city, :venue, :date, :downloads]
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
    from_city = " from #{city}" if city && !city.empty?
    "#{speaker}#{from_city}"
  end

   def initWithCoder(decoder)
    self.init
    PROPERTIES.each { |prop|
      value = decoder.decodeObjectForKey(prop.to_s)
      self.send((prop.to_s + "=").to_s, value) if value
    }
    self
  end

    # called when saving an object to NSUserDefaults
  def encodeWithCoder(encoder)
    PROPERTIES.each { |prop|
      encoder.encodeObject(self.send(prop), forKey: prop.to_s)
    }
  end

end
