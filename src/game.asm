INCLUDE Irvine32.inc

.CODE

Initialize_Grid PROC
    mov ecx, 18               ; Row loop, start from row 1 to 18 (skipping the first and last rows)
    lea esi, array + 4 * 50   ; Move ESI to the second row (skip the first row)

FillRows:
    push ecx                   ; Save the row counter
    mov edx, 48                ; Column loop, fill columns 1 to 48 (skip columns 0 and 49)
    lea ebx, [esi + 4]         ; Start from column 1 (skip column 0)

FillColumns:
    cmp edx, 1                 ; Check if we're in the last column (column 48)
    jle DoneColumn             ; If we've processed all columns, finish this row

    call Random32             ; Generate a random 32-bit value
    and eax, 1                ; Mask the value to get 0 or 1
    mov [ebx], eax            ; Store the random value in the array
    add ebx, 4                ; Move to the next column
    dec edx                   ; Decrement column counter
    jmp FillColumns           ; Continue filling columns

DoneColumn:
    pop ecx                    ; Restore the row counter
    add esi, 4 * 50            ; Move to the next row (skip the first and last rows)
    loop FillRows              ; Repeat for all rows

    ret
Initialize_Grid ENDP

Display_Grid PROC
    mov ecx, rows             ; Outer loop for rows
    lea esi, array            ; Load address of the array into ESI
    mov edx, cols             ; Number of columns per row
    
L1: 
    push ecx                  ; Save the row counter
    mov ecx, edx              ; Inner loop for columns

L2: 
    mov eax, [esi]            ; Load the current element from the array
    add esi, 4                ; Move to the next element
    call WriteDec  
    ; Print the value
    mov al," "
    call WriteChar            ; Print a space for readability
    loop L2                   ; Repeat for all columns

    call Crlf                 ; Move to a new line after each row
    pop ecx                   ; Restore the row counter
    loop L1                   ; Repeat for all rows

    ret
Display_Grid ENDP


update_grid PROC
  ret
update_grid ENDP

END
