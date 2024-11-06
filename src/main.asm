INCLUDE irvine32.inc
INCLUDE game.inc

.DATA
  ; Define data variables

.CODE

main PROC
  MOV EAX, 0        
  CALL sample@0

  EXIT
main ENDP

END MAIN
