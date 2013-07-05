##!/bin/sh
# Space_edit#!/bin/sh
# Space_edit.tcl exec \
tclsh "$0" ${1+"$@"}

# this programe will take all the space and tabs in any give text
# so they are alined.
#this is also a homework! 



proc Space_killer {string} {	
	#first each line of text is tread in a list	
	set line_list [split $string \n]
	#puts "there are [llength $line_list] lines, in this text"
	foreach line $line_list {
		lappend character_list [split $line {}]	
	}
	#set slc {}
	#set tlc {}
	#second each line coverst tabs to space and sets the number of bigging white space 
		puts "unedited text"
	foreach test $character_list {
		puts $test

	}
	foreach line $character_list { 

	
		foreach ding $line {
		
			  if {$ding == "\t" ||  $ding == { }} {
				} else {
			 	set stopd [lsearch $line $ding]
				break
 
			}
		}

	set space [lsearch -all $line { }]
	set tab [lsearch -all $line "\t"]
	set whiteline [llength [concat $tab $space]]
	set linelength [llength $line]

		if {$line == {} || $linelength == $whiteline} {
			} else {
			lappend slc [llength [lsearch -all [lrange $line 0 $stopd] { }]]
			lappend tlc [llength [lsearch -all [lrange $line 0 $stopd] {	}]]}
	}
	set cws [lrange [lsort -increasing $slc] 0 0]
	set cwt [lrange [lsort -increasing $tlc] 0 0]

	foreach line2 $character_list {
		set liner $line2
		set cline [lsearch $character_list $line2]
		for {set incs 0 } {$incs < $cws} {incr incs} {
			set ids [lsearch $liner { }]
			set liner [lreplace $liner $ids $ids ]
		}
	
		for {set inct 0 } {$inct < $cwt} {incr inct} {
			set idt [lsearch $liner {	}]
			set liner [lreplace $liner $idt $idt ]
		}
		set character_list [lreplace $character_list $cline $cline $liner]	
	}

	puts "edited text"
	foreach test $character_list {
		puts $test
	
	}
	foreach line3 $character_list {
		set jline [lsearch $character_list $line3]
		set joined [join $line3 ""]
		set character_list [lreplace $character_list $jline $jline $joined] 
	}
	set character_list [join $character_list "\n"]	
	puts $character_list
}

set text [read [open text]]
#set text "
#	onec upon a	time
#	  There was a frog
#	        on a log
#		in the rain
#
#           	        he was a mad frog
#					
#					"

Space_killer $text
