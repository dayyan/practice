# Given an array of floating point numbers A, calculate an array B such that 
# the sum of elements in B are equal to: the round of the sum of elements in A.
# And the sum of the absolute values of A[i] - B[i] is minimized.
#
# Example:
# input = [1.5, 1.3, 1.2], sum is 4.1, round of the sum is 4.
# output = [2, 1, 1], sum is 4, equals the round of the sum of input.

def minimal_rounded_sum(input)
  target = input.inject(:+).round
  rounded_input = input.map(&:round)
  remaining = target - rounded_input.inject(:+)

  return rounded_input if remaining.zero?

  # Get indices of remaining floats that we will ceil
  # by selecting maximum values.
  # [[value, index], [value, index]]
  floats_to_ceil = input.each_with_index.max(remaining)

  # Mimic ceil operation by adding 1.
  floats_to_ceil.each { |i| rounded_input[i[1]] += 1 }

  return rounded_input
end

def test_single_item
  puts minimal_rounded_sum([1.5]) == [2]
end

def test_rounded_is_minimal
  puts minimal_rounded_sum([1.1, 1.1, 1.1]) == [1, 1, 1]
end

def test_picks_a_max_to_ceil
  puts minimal_rounded_sum([1.1, 1.4, 1.1]) == [1, 2, 1]
end

def test_picks_more_than_one_max_to_ceil
  puts minimal_rounded_sum([1.4, 1.4, 1.4, 1.4]) == [1, 1, 2, 2]
end

test_single_item
test_rounded_is_minimal
test_picks_a_max_to_ceil
test_picks_more_than_one_max_to_ceil
