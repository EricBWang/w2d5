class MaxIntSet
  attr_reader :store
  def initialize(max) #
    @max = max
    @store = Array.new(@max, false) # []

  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    return @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if !(0..@max).include?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % @store.length] << num
  end

  def remove(num)
    @store[num % @store.length].delete(num)
  end

  def include?(num)
    return !@store[num % @store.length].index(num).nil?
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

require "byebug"
class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num) && @store[num % num_buckets].is_a?(Array)
      @store[num % num_buckets] = num
      @count += 1 
      if @count == num_buckets
        resize!
      end
    else
      @store[num % num_buckets] = num
    end
  end

  def remove(num)
    if include?(num)
      @count -= 1
      @store[num % num_buckets] = []
    end
  end

  def include?(num)
    return true if @store[num % num_buckets] == num
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = ResizingIntSet.new(num_buckets * 2)
    @store.each do |el|
      temp.insert(el)
    end
    @store = temp.store
  
  end
end
