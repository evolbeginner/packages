#! /usr/bin/perl

package read_gene_seq_from_paml;
use Bio::SeqIO;
require Exporter;
use strict;

#our @ISA = qw(Exporter);
#our @EXPORT = qw(read_gene_seq); 

sub read_paml{
    my ($input_seq, $input_seq_info_hashref) = @_;
    my %seq_info;
    my $catchseq_seqio_obj;
	
	%seq_info = %$input_seq_info_hashref if $input_seq_info_hashref;

	#print "Reading fasta format sequences\t...........................\n\n";
    open(my $IN, '<', $input_seq) || die "input $input_seq cannot be opened! Exiting ......";
    # obtain info from the 1st line
    my $first_line = <$IN>;
    my (undef, $num_of_seqs, $num_of_characters) = split (/\s+/, $first_line);
    my $counter = 1;
    my $seq_title;
    while(my $line = <$IN>){
        chomp($line);
        if ($counter == 1 ){
            $seq_title = $line;
            $seq_info{$seq_title}{'seq'} = "";
            $counter += 1;
        }
        else{
            if ($num_of_characters - 60*($counter-1) > 0  ){
                $counter += 1;
                $seq_info{$seq_title}{'seq'} .= $line;
            }
            else{
                $seq_info{$seq_title}{'seq'} .= $line;
                $counter =  1 ;
            }
        }
    }
    close ($IN);
    return(\%seq_info);
}


1;
__END__

