#!/bin/sh
# Snake_Tcl.tcl \
exec tclsh "$0" ${1+"$@"}

#
#snake tail , do not know how to make the tail longer 
#Main menu , atching to proc
#

## per setting and frame
package require Tk 

set width 500
set height 500

canvas .c -width $width -height $height -bg green3

	proc start_new {} {
		
		global width
		global height
		global player_x
		global player_y	
		global radics
		global tail_x
		global tail_y	
		global slide	

		set player_x [expr {$width/2}]
		set player_y [expr {$height/2}]
		set radics 15
		set counter 0
		set tail_x $player_x
		set tail_y [expr {$player_y -20}]
		
		
		.c create rect 0 0 510 40 -fill gray
		## scroes
		set N_Score 0
		set N_life 3
		set movep_xu 0
		set movep_xd 0
		set movep_yu 0
		set movep_yd 0
		set slide "up"
		set start_game "off"
		
		
		.c create text 20 20 -text " Score:" -fill blue
		.c create text 130 20 -text " Life:" -fill blue
		
		.c create text 160 20 -text $N_life  -fill blue
		.c create text 80 20 -text $N_Score -fill blue -tag score
		
		reset_food
		contrules	
		}

## player
	proc contrules {} {
		.c delete player tail
		.c delete playgame contune scorebourd creadits Mtext Mtitle Mframe

		global width
		global height
		global slide
		global N_Score
		global player_x
		global player_y
		global frame_x
		global frame_y
		global radics
		
		
		set leftx [expr {$::player_x + $::radics } ]
		
		set upy [expr {$::player_y + $::radics } ]
		set downy [expr {$::player_y - $::radics } ]
		
		tail_length

		bind . <Key-Up>    {set slide "up"   }
		bind . <Key-Down>  {set slide "down" }
		bind . <Key-Left>  {set slide "left" }
		bind . <Key-Right> {set slide "right"}
		bind . <p> {Start_menu}
		
		
		switch $slide {
			
			up    {incr player_y -20 }
			down  {incr player_y +20 }
			left  {incr player_x -20 }
			right {incr player_x +20 }
			}
		
		

		.c create oval [expr {$::player_x  +  $::radics}] [expr {$::player_y  +  $::radics} ] [expr {$::player_x  -  $::radics}] [expr {$::player_y  -  $::radics}]  -fill red -tag player
		#puts $::player_x
		#puts $::player_y
		
	## clution of the player and score
		if { [expr {$::player_x - $::radics } ] <= [expr {$::frame_x - 20 } ] && [expr {$::player_x + $::radics } ] >= $::frame_x && [expr {$::player_y + $::radics }] <= [expr { $::frame_y - 20 }]  && [expr {$::player_y - $::radics } ] >= $::frame_y  } {
			reset_s
			}

		if {$::player_x >= $::width || $::player_x <= 0} {
			Death
		}
		
		if {$::player_y >= $::height || $::player_y <= 0} {
			Death
		}
		
	after 200 contrules
	}

proc tail_length {} {
		
	global tail_x
	global tail_y
	
	if {$::player_x > $::tail_x} {incr tail_x +20} 
	if {$::player_x < $::tail_x} {incr tail_x -20}
	
	if {$::player_y > $::tail_y} {incr tail_y +20} 
	if {$::player_y < $::tail_y} {incr tail_y -20}
	
	.c create oval [expr {$::tail_x  +  $::radics}] [expr {$::tail_y  +  $::radics} ] [expr {$::tail_x  -  $::radics}] [expr {$::tail_y  -  $::radics}]  -fill red -tag tail
}


proc reset_food {} {

	.c delete b
	global width
	global height
	global frame_x
	global frame_y
	set frame_x [expr   {int (rand() * 461)}]
	set frame_y [expr {40 + round(rand() * $height - 40) }]
	##snake_tail

	.c create rect [expr {$frame_x}] [expr {$frame_y}] [expr {$frame_x - 20}] [expr {$frame_y - 20}] -fill brown -tag b 
}

proc Death {} {
	
	.c create rect 150 100 350 400 -fill grey -tag Dframe
	.c create text 250 120 -text "YOU LEFT ME!" -font {Times 25 bold } -tag Dframe
	.c create text 240 140 -text "because of that you lose!"
	.c create text 240 160 -text "Your score is $" -tag Dframe
	.c create text 240 180 -text "HIgh score is $" -tag Dframe
	GUI_button .c playgame Replay? 170 200	
}

proc Sorry {} {
	global width
	global height
 .c create text [expr {$width/3}] [expr {$height/3}] -text "I'm sorry it looks like someone was lazy and has yet to make this function avalabe, don't worry ill make sure it's up soon." -tag maint


}

proc Main_menu {} {

.c create text 250 50 -text "Snake!" -font {Times 40 bold } -tag Mtitle

.c create rect 150 100 350 400 -fill grey -tag Mframe
	
	GUI_button .c playgame Play\ New\ Game 170 120 
	GUI_button .c contune Contune  170 160
	GUI_button .c scorebourd Scorebourd  170 200 
	GUI_button .c creadits Creadits 170 240

.c create text 255 320 -text "Welcome this is a greate \n clasic game call, well \n you know snake! \n This game was coded by \n Darkninja only  using \n TCL and TK! hope you like it!" -tag Mtext 

}

proc Start_menu {} {

set slide "stop"
.c create rect 150 100 350 400 -fill grey
	
	GUI_button .c quit Quit\ Game  170 120
	GUI_button .c contstar Contune  210 120
	GUI_button .c backm Back\ To\ Menu  260 120 
	GUI_button .c save Save 300 120
}

proc GUI_button {path nameb message x y} {

	set x_leaght 160
	set y_leaght 20	
	set startt 2
	set depth 2
	set bdepth [expr {-1 * $depth}] 

 	$path create rect $x $y [expr {$x + $x_leaght}] [expr {$y + $y_leaght}] -tag $nameb -fill red
	$path create text [expr {$x + $x_leaght /$startt}] [expr {$y + $y_leaght /$startt}] -text $message -tag $nameb
	
	$path bind $nameb <1> [list $path move $nameb $depth $depth]
	$path bind $nameb <ButtonRelease-1> [list $path move $nameb $bdepth $bdepth]

}

Main_menu
.c bind playgame <ButtonRelease-1> start_new 
grid .c
