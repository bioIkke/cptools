#!/usr/bin/env perl


use strict;
use warnings;

open my $fh,shift() ||  die "No such file:$!";
my %hash;
while(<$fh>){
	next if(/^Seq/);
	my ($seq,$kaks) = (split /\s+/)[0,4];#ka_ks value col5
	my ($seq1,$seq2) = split /&/,$seq;
	$hash{$seq1}{$seq2} = $kaks;
}

my @flow = sort keys %hash;
print "\t",join("\t",@flow),"\n";
close $fh;

foreach my $key1(@flow){

	print $key1;
	foreach my $key2(@flow){
		print("\t",0) and next() if $key1 eq $key2;
		print "\t",$hash{$key1}{$key2};
	}
	print "\n";
}
