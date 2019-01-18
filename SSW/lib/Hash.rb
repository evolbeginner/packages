def multi_D_Hash(num_of_dimensions)
  if num_of_dimensions > 1 then
    hash=Hash.new{|h,k| h[k]=multi_D_Hash(num_of_dimensions-1)}
    #multi_D_Hash(num_of_dimensions-1)
  elsif num_of_dimensions == 1 then
    Hash.new
  else
    raise "num_of_dimensions error!"
  end
end


def getCounts(arr)
  counter = Hash.new(0)
  arr.each do |i|
    counter[i] += 1
  end
  return(counter)
end


