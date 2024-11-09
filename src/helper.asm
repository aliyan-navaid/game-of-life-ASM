INCLUDE irvine32.inc

.DATA
  newline EQU <0Dh, 0Ah>
  
  options_msg BYTE "1. Start", newline
          BYTE "2. Exit" , newline, 0

  prompt_msg BYTE "Choice: ", 0

  invalid_choice_msg BYTE "Invalid Choice...", newline, 0


.code

;---------------------------------------------------------------
; display_start_menu PROC
;
; Description:
; This procedure displays a 2 options to the user:
; Start Simulation, Exit.
;
; Receives:
; None
;
; Returns:
; None.
;
; Destroys:
; EDX - Used to store the address of the options message.
;
;---------------------------------------------------------------

display_start_menu PROC
  MOV edx, OFFSET options_msg
  CALL writestring
  CALL CRLF

  ret
display_start_menu ENDP

;---------------------------------------------------------------
; get_user_choice PROC
;
; Description:
; This procedure displays a prompt message to the user and
; reads an integer input from the user.
;
; Receives:
; None
;
; Returns:
; EAX - The integer input provided by the user.
;
; Destroys:
; EDX - Used to store the address of the prompt message.
;
;---------------------------------------------------------------

get_user_choice PROC
  MOV edx, OFFSET prompt_msg
  CALL writestring
  CALL readint

  ret
get_user_choice ENDP

invalid_choice PROC
  MOV edx, OFFSET invalid_choice_msg
  CALL writestring
  CALL CRLF  

  COMMENT &
      ; Delay loop (approximate, based on CPU clock speed)
      delay_ms:
        mov ecx, 4294967295     ; Set the number of iterations
      delay_loop:
        dec ecx                 ; Decrement counter
        jnz delay_loop          ; Jump if not zero (continue loop)
  & COMMENT

  MOV EAX, 1000
  CALL delay
  CALL clrscr

  ret
invalid_choice ENDP

END