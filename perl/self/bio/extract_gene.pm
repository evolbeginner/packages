#! /usr/bin/perl

package extract_gene;
use Bio::SeqIO;
require Exporter;
use strict;

#our @ISA = qw(Exporter);
#our @EXPORT = qw(read_gene_seq); 

sub read_gene_seq{
    my ($input_seq, $input_seq_info_hashref, $format, $type) = @_;
    my %seq_info;
    my $catchseq_seqio_obj;
	
	$format = &check_format($format);
	%seq_info = %$input_seq_info_hashref if $input_seq_info_hashref;

	#print "Reading fasta format sequences\t...........................\n\n";
    $catchseq_seqio_obj = Bio::SeqIO->new(-file=>$input_seq, -format=>$format);
    while(my $seq_obj=$catchseq_seqio_obj->next_seq()){
            my ($full_name);
            $full_name = $seq_obj->display_name;
            $seq_info{$full_name}{seq} = $seq_obj->seq;
            $seq_info{$full_name}{'length'} = $seq_obj->length;
            $seq_info{$full_name}{'gc_content'} = &gc( $seq_info{$full_name}{seq} ) if ($type eq 'DNA');
    }
    return(\%seq_info);
}


sub gc{
	my ($seq) = @_;
	my ($gc_count, $effective_base_count, $gc_content);
	$gc_count = $seq =~ tr/GCgc/GCgc/;
	$effective_base_count = $seq =~ tr/ATGCUatgcu/ATGCUatgcu/;
	$gc_content = eval $gc_count/$effective_base_count;
	return ($gc_content) if $effective_base_count != 0;
	return 0 if $effective_base_count == 0;
}


sub check_format{
	my ($format) = @_;
	$format = lc($format);
	return ('fasta') if $format !~ /^\s*(fasta|genbank)\s*$/;
	return ($format);
}


1;
__END__

