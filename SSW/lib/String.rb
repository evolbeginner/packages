class String
  def numeric?
    Float(self) != nil rescue false
  end
end


#########################################################
class String
  require 'iconv'
  def to_gb
    Iconv.conv("gb2312//IGNORE","UTF-8//IGNORE",self)
  end
  def utf8_to_gb
    Iconv.conv("gb2312//IGNORE","UTF-8//IGNORE",self)
  end
  def gb_to_utf8
    Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",self)
  end
  def to_utf8
    Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",self)
  end
end


class String
  def remove_non_ascii
    require 'iconv'
    Iconv.conv('ASCII//IGNORE', 'UTF8', self)
  end
end
