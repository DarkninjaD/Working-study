##!/bin/sh
# Space_edit#!/bin/sh
# Space_edit.tcl exec \
tclsh "$0" ${1+"$@"}

# this programe will take all the space and tabs in any give text
# so they are alined.
#this is also a homework! 

set text "	  onec upon a	time
		  There was a frog
		        on a log
			in the rain
                        he was a mad frog"

proc Space_killer {string} {	
#first each line of text is tread in a list	
	set line_list [split $string \n]
	set character_list {}
	puts -nonewline "there is "
	puts -nonewline [llength $line_list]
	puts " lines, in this text"
		
	for {set i 0 } {$i < [llength $line_list]} {incr i} {
	
		lappend character_list [split [lindex $line_list $i] {}]	
		}
#second each line coverst tabs to space and sets the number of bigging white space 

	set n 0
	set whitesize {}
	set nl1 {}

	for {set x 0} {$x < [llength $character_list]} {incr x} {
		set WS_line$x 0
		}

	#foreach l1 $character_list {

		#foreach l2 $l1 {

		#	#if {$l2 == {	} || $l2 == { } } {
		#		#if {$l2 == {	} } {incr WS_line$n
		#					set idx [lsearch -exact $l1 {	}]
		#					#puts $idx
		#					#puts [set $nl1 [lreplace $l1 $idx $idx { }]]}
				#if {$l2 == { } } {incr WS_line$n}
		#	} else {break}
		#	}
		#puts $nl1
		#incr n}
	#foreach print2 $character_list {  
	#puts $print2
}
	#set bang [lindex $character_list 1]
	#puts $bang

	foreach line $character_list {  

		foreach ding $line {
			if {$ding == {	} || $ding == { } } {
					} else {set stopd [lsearch $line $ding] }

		set nline [lsearch $character_list $line]
		for {set thing 0} {$thing < [llength $line]} {incr thing} {
			set id [lsearch $line {	}]
			if {$id == -1 || $id == $stopd} {
				set character_list [lreplace $character_list $nline $nline $line]
				break}
		set line [lreplace $line $id $id { }]
			}	
		}
}
	foreach print $character_list {
	puts $print
}

	set WS_list {}
	

	for {set s 0 } {$s < [expr {[llength $character_list]}] } {incr s} {

	lappend WS_list [set WS_line$s]
}

	
	#set tmp_list [lindex $character_list 1]
	#set id [lsearch -exact  $tmp_list {	}]
	#set tmp_list [lreplace $tmp_list $id $id { }]
	#puts $tmp_list 
#threed comper each number that has been set find the smalles one then delete that amount to all lines



#fourth spit out the text and hope it worked


Space_killer $text
