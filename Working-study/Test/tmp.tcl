##!/bin/sh
#tmp.tcl exec \ tclsh "$0" ${1+"$@"}
set test  "

	 Tab Space
 	Space Tab
	 	Tab Space Tab
		 Tab Tab Space
 		Space Tab Tab
	  Tab Space Space
 	 Space Tab Space
  	Space Space Tab"
set list {s t s t t t }
lappend search t
lappend search s
puts [lsearch -all -inline  $list $search]
