# SSW bio

def read_seq_file(seq_file)
  require 'bio'
  seq_objs = Hash.new
  Bio::FlatFile.open(seq_file).each_entry do |f|
    seq_objs[f.definition] = f
  end
  return seq_objs
end

