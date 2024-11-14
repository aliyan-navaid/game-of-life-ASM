INCLUDE irvine32.inc
INCLUDE game.inc
INCLUDE helper.inc

.DATA
newline EQU <0Dh, 0Ah>
pause_iterations EQU 10
  
pause_options_msg BYTE "1. Resume", newline
          BYTE "2. Exit" , newline, 0

.CODE

main PROC
  start:
    ; Display the start menu and get user choice
    CALL display_start_menu
    CALL get_user_choice

    ; Choice: Start Simulation
    cmp eax, 1
	  MOV ECX, pause_iterations
    JE game_loop

    ; Choice: Exit
    cmp eax, 2
    JE terminate
        
    ; Invalid Choice
    CALL invalid_choice
    JMP start

  terminate:
    EXIT

  ; Game loop section
  game_loop:
    CALL clrscr
	  
    CALL dumpregs             ; Debugging purpose
    ; CALL initialize_grid
    ; CALL display_grid
    ; CALL update_grid

    MOV EAX, 500
	  CALL delay

	  CMP ECX, 0
	  JE pause_menu
	  DEC ECX
      JMP game_loop

	  pause_menu:
		  MOV EDX, OFFSET pause_options_msg
		  CALL writestring
		  CALL readint

		CMP EAX, 1
		JE resume
		
		EXIT

		resume:
			MOV ECX, pause_iterations
			JMP game_loop

  EXIT
main ENDP

END main
