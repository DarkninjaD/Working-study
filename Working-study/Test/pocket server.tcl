#!/bin/sh
# test3.tcl \
exec tclsh "$0" ${1+"$@"}

proc webServer {chan addr port} {
    while {[gets $chan] ne ""} {}
    puts $chan "HTTP/1.1 200 OK\nConnection: close\nContent-Type:text/HTML; application/javascript \n"

   set html [open /Users/Hackalot/Documents/buttest.html]
   set data [read $html]

	puts  $chan $data
	
	close $chan

}

socket -server webServer 2063
vwait forever
