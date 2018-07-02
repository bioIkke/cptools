#!/usr/bin/env perl
use warnings;
use strict;
use File::Slurp;
use Data::Dumper;





my @fas   =  read_file(+shift);
@fas      =  map {s/\r?\n//r} @fas;

foreach my $fas(@fas){
        my $fasta = fasta_parser($fas);
        foreach my $gene (keys %$fasta){
                my @underlines = $fasta->{$gene} =~ m/-+/g;
                my @counts = map { length($_) } @underlines;
                # print Dumper \@counts;
                foreach my $count(@counts){
                        if($count % 3 != 0){
                                print $fas,"\t";
                                print $gene,"\n";
                                last;
                        }
                }
        }
}



sub fasta_parser{
        my %fasta;
        my $name;
        my $fl = shift;
        open my $fh,"<","$fl" or die "can't open:$!";
        while(<$fh>){
                s/\r?\n//;
                if(/^>(\S+)/){
                        $name = $1;
                }elsif($name){
                        $fasta{$name} .= $_;
                }
        }
	close $fh;
        return \%fasta;
}