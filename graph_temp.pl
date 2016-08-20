#!/usr/bin/perl

use RRDs;
use Time::Piece;
my $datetime = localtime->strftime('%Y-%m-%d %H%M%S');



my $cur_time = time();
my $start_time = $cur_time - 86400;     # set end time to 24 hours ago 


                
RRDs::graph "/var/www/html/graph_temp.png",   
			"--start= $start_time",
			"--end= $cur_time",
			"--title= Temp ute",
			"--height= 300",
			"--width= 500",
			"--vertical-label= °C",
	      "DEF:OutsideTemp=/home/pi/rrddata/outside_temp.rrd:outsidetemp:AVERAGE",                          
			"COMMENT:\t\t\t\tNu     Medel    Max    Min            $datetime\\n",
			"HRULE:0#0000FF",         
	      "LINE2:OutsideTemp#0000FF:Ute\t\t\t",    
			"GPRINT:OutsideTemp:LAST:%6.1lf",
			"GPRINT:OutsideTemp:AVERAGE:%6.1lf",
			"GPRINT:OutsideTemp:MAX:%6.1lf",
			"GPRINT:OutsideTemp:MIN:%6.1lf\\n";

my $err=RRDs::error;
if ($err) {print "problem generating the graph: $err\n";}

print "Done!\n"
