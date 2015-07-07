class Array
  def my_uniq
    uniq_array = []

    self.each do |el|
      uniq_array << el unless uniq_array.include?(el)
    end

    uniq_array
  end

  # Alternatively with inject:
  #
  # def my_uniq
  #   self.inject([]) do |uniq_array, el|
  #     uniq_array << el unless uniq_array.include?(el)
  #     uniq_array
  #   end
  # end

  def two_sum
    pairs = []

    self.count.times do |i1|
      (i1 + 1).upto(self.count - 1) do |i2|
        pairs << [i1, i2] if self[i1] + self[i2] == 0
      end
    end

    pairs
  end

  def my_transpose
    dimension = self.first.count
    cols = Array.new(dimension) { Array.new(dimension) }

    dimension.times do |i|
      dimension.times do |j|
        cols[j][i] = self[i][j]
      end
    end

    cols
  end

  def median
    return nil if empty?
    sorted = self.sort
    if length.odd?
      sorted[length / 2]
    else
      (sorted[length / 2] + sorted[length / 2 - 1]).fdiv(2)
    end
  end
end

class String
  def caesar(shift)
    # The computer represents letters as a sequence of ASCII code
    # numbers. ASCII letters are consecutive. So:
    #     "a" => 97, "b" => 98, "c" => 99, ..., "y" => 121, "z" => 122
    #
    # We can iterate through a string's ASCII codes letter by letter
    # using `each_byte`. We can also use `ord` to get a single letter's
    # code. `Fixnum#chr` does the opposite translation from ASCII code
    # to string letter.

    # only works on downcased words
    string = self.downcase

    encoded_string = ""
    string.each_byte do |ascii|
      # letter_pos is the position of the letter in the alphabet. "a" is
      # the zeroth letter.
      letter_pos = ascii - "a".ord

      # we use modulo to avoid overshifting; we need to wrap!
      shifted_letter_pos = (letter_pos + shift) % 26

      # convert back to string format
      encoded_string << ("a".ord + shifted_letter_pos).chr
    end

    encoded_string
  end
end

class Hash
  def difference(other_hash)
    difference_hash = {}

    self.keys.each do |key|
      difference_hash[key] = self[key] unless other_hash.key?(key)
    end

    other_hash.keys.each do |key|
      difference_hash[key] = other_hash[key] unless self.key?(key)
    end

    difference_hash
  end
end

class Fixnum
  def stringify(base)
    # handle the case where self == 0.
    return "0" if self == 0

    # first find the least-significant digit, the part that goes in the
    # "ones" column. The leftover amount is now a multiple of `base`. We
    # can recursively call our method to represent the high order bits.
    low_digit = self % base
    leftover = self - low_digit

    digits = [
      "0", "1", "2", "3", "4", "5", "6", "7",
      "8", "9", "a", "b", "c", "d", "e", "f"
    ]

    if leftover > 0
      (leftover / base).stringify(base) + digits[low_digit]
    else
      # nothing leftover, done.
      digits[low_digit]
    end

    # e.g.,
    # self_to_s(144, 10) => {:low_digit => 4, :leftover => 140}
    #   self_to_s(14, 10) => {:low_digit => 4, :leftover => 10}
    #     self_to_s(1, 10) => {:low_digit => 1, :leftover => 0}
  end
end
