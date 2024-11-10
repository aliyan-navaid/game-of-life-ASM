INCLUDE irvine32.inc
INCLUDE game.inc
INCLUDE helper.inc

.CODE

main PROC
  start:
    ; Display the start menu and get user choice
    CALL display_start_menu
    CALL get_user_choice

    ; Choice: Start Simulation
    cmp eax, 1
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
    CALL dumpregs             ; Debugging purpose
    ; CALL initialize_grid
    ; CALL display_grid
    ; CALL update_grid
    ; JMP game_loop

  EXIT
main ENDP

END main
