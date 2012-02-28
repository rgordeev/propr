class Array
  def random
    if empty?
      raise "no elements"
    else
      self[Integer.random(min: 0, max: size - 1)]
    end
  end

  def shrink
    if empty?
      return []
    end

    combination(size - 1).to_a.tap do |shrunken|
      shrunken << []
      size.times do |n|
        head = self[0, n]
        tail = self[n+1..-1]
        item = self[n]
        shrunken.concat(item.shrink.map{|m| head + [m] + tail })
      end
    end
  end
end

class << Array
  def random(options = {}, m = Propr::Random, &block)
    min  = options[:min] || 0
    max  = options[:max] || 10

    # @todo: Don't scale size around midpoint
    m.bind(Integer.random(min: min, max: max)) do |size|
      m.sequence(size.times.map { block.call })
    end
  end
end
