#! /use/bin/perl

package find_taxa;
require Exporter;
use strict;
use File::Basename;

#our @ISA = qw(Exporter);

my ($taxa_dir, $rela_href);

########################################################################################################
$taxa_dir="/mnt/bay3/sswang/NCBI_ftp_download/taxonomy/level_NCBI_taxonomy" if not $taxa_dir;

$rela_href = &extract_taxa_info();

sub get_taxa{
	my ($target_name, $level_name) = @_;
	return('no') if not exists $rela_href->{$level_name}{$target_name};
	return($rela_href->{$level_name}{$target_name});
}

#########################################################################
sub extract_taxa_info{
	my %rela;
	for my $file (glob ("$taxa_dir/*")){
		next if basename($file) !~ /^(Eukaryota|Archaea|Bacteria|Viruses|Viroids)$/;
		open (my $IN, '<', "$file");
		while(<$IN>){
			no strict;
			my @taxonomy;
			chomp;
			my @name = qw(kingdom sub_kingdom phylum class order family genus species);
			@taxonomy = split /\t/;
			my ($species, $kingdom, $sub_kingdom, $phylum, $class, $order, $family, $genus) = split /\t/;
			foreach (@taxonomy[1..$#taxonomy]){
				my $name;
				$name = shift @name;
				$rela{'species'}{$species}{$name} =	$_;
				$rela{'genus'}{$genus}{$name}     =	$_;
			}
			#print $rela{'species'}{$species}{kingdom}."\n";
		}
	}
	return (\%rela);
}



