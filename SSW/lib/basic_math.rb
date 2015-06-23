# something about basic math

module LotMath
  extend self
  def F(n)
    return 1 if n == 0
    (1..n).inject(:*)
  end
  def P(n, k)
    F(n) / F(n - k)
  end  
  def C(n, k)
    P(n, k) / F(k)
  end
end


####################################################
class Integer
  def fact
    (1..self).reduce(:*) || 1
  end
end


class Array
  def sum
    inject(0.0) { |result, ele| result + ele }
  end
  def mean 
    sum / size
  end
  
  def median
    sorted = self.sort
    mid = (sorted.length - 1) / 2.0
    (sorted[mid.floor] + sorted[mid.ceil]) / 2.0
  end

  def sigma
    return(Math.sqrt(self.variance))
  end

  def variance
    m = mean
    sum = 0.0
    self.each {|v| sum += (v-m)**2 }
    return(sum/self.size)
  end
end


####################################################
def gaussian(mean, stddev)
  theta = 2 * Math::PI * rand
  rho = Math.sqrt(-2 * Math.log(1 - rand))
  scale = stddev * rho
  x = mean + scale * Math.cos(theta)
  y = mean + scale * Math.sin(theta)
  return x, y
end


def pearson_correlate(x,y)
  require 'basic_math'
  sum = 0.0
  x.each_index do |i|
    sum += x[i]*y[i]
  end
  xymean = sum/x.size.to_f
  xmean = x.mean
  ymean = y.mean
  sx = x.sigma
  sy = y.sigma
  (xymean-(xmean*ymean))/(sx*sy)
end

