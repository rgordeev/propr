class Array
  def random(options = {}, m = Propr::Random)
    m.bind(m.rand(size)) do |index|
      m.unit(self[index])
    end
  end

  # @return [Array<Array>]
  def shrink
    return Array.new if empty?

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
  def random(options = {}, m = Propr::Random)
    min  = options[:min] || 0
    max  = options[:max] || 10
    item = yield

    m.bind(Integer.random(min: min, max: max, center: min)) do |size|
      m.sequence([item]*size)
    end
  end
end