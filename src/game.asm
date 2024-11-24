INCLUDE Irvine32.inc
.data
array2D BYTE 0,0,0,0,0,0,0 
        BYTE 0,0,0,0,0,0,0 
        BYTE 0,0,0,1,0,0,0
        BYTE 0,0,1,1,0,0,0
        BYTE 0,0,0,0,0,0,0
        BYTE 0,0,0,0,0,0,0
row_size byte 6   ;total rows
column_size byte 7   ;total columns
count byte 0
column_index_var byte ?   ;current column position
row_index_var byte ?      ;currect row position
.CODE

initialize_grid PROC
  ret
initialize_grid ENDP

display_grid PROC
  ret
display_grid ENDP

CountNeighbors PROC,column_index:byte,row_index:byte


 mov esi, OFFSET array2D        ; Load the base address of array2D into ESI
    movzx ebx, row_index         
    movzx eax, column_size          
    imul ebx, eax                  ; Multiply row index (EBX) by column size to get row offset
    movzx eax, column_index       
    add esi, ebx                   ; Add row offset to ESI
    add esi, eax                   ; Add column index to ESI to get the final address 



cmp byte ptr [esi-1],1   ;check left cell and update accordingly
je  update_count1
jmp skip_count1

update_count1:
inc count

skip_count1:

cmp byte ptr [esi+1],1    ;check right cell and update accordingly
je update_count2
jmp skip_count2

update_count2:
inc count

skip_count2:
push esi ;to be used for lower row
;now checking upper row
movzx eax, column_size        ; Load the value of columns into EAX
sub esi, eax            ; Subtract columns from ESI to get the top(north) cell


cmp byte ptr [esi],1    ;check top cell  
je update_count3
jmp skip_count3

update_count3:
inc count

skip_count3:

dec esi
cmp byte ptr [esi],1   ;check top left(north-west) cell
je update_count4
jmp skip_count4

update_count4:
inc count

skip_count4:
add esi,2
cmp byte ptr [esi],1   ;check top right (north-east)cell
je update_count5
jmp skip_count5

update_count5:
inc count

skip_count5:
pop esi ;getting original cell index
push esi    ;for update grids condition check of whether or not the current cell was alive
add esi,eax   ;mov to bottom row
cmp byte ptr [esi],1  ;check bottom(south) cell
je update_count6
jmp skip_count6

update_count6:
inc count

skip_count6:
dec esi
cmp byte ptr [esi],1  ;check bottom left(south-west) cell
je update_count7
jmp skip_count7

update_count7:
inc count

skip_count7:
add esi,2
cmp byte ptr [esi],1  ;check bottom right(south-east) cell
je update_count8
jmp skip_count8

update_count8:
inc count
skip_count8:
pop esi

ret  ;return control to after invoke function
CountNeighbors ENDP




update_grid PROC




;starting grid from 1st row and 1st column to pad 0th row and 0th column with 0's
mov row_index_var,1
mov column_index_var,1
movzx ecx,column_size
L1:
 invoke CountNeighbors,column_index_var,row_index_var
 
 ;check update conditions after returning from countNeighbors

 ;check if cell is currently alive or not
cmp byte ptr [esi],1
jl empty_cell  ;if its not check the one condtion for an empty cell

;if it is alive check the 3 conditions for an alive cell
 ;Each cell with one or no neighbors dies, as if by solitude.
cmp count,1
jle cell_death

;Each cell with four or more neighbors dies, as if by overpopulation.
cmp count,4
jae cell_death

;Each cell with two or three neighbors survives.
cmp count,3
je survive
cmp count,2
je survive

jmp survive ; this is an unlikely case since all possible conditions have been checked but if none of the conditions meet

cell_death:
mov byte ptr [esi],0
jmp survive

empty_cell:
;Each cell with three neighbors becomes populated.
cmp count,3
je populate_cell
jmp survive

populate_cell:
mov byte ptr [esi],1

survive:
;conditions check completed
mov count,0 ; update to 0 for next iterations of updation
 
 
  inc column_index_var       ; Move to the next column
    movzx ebx,column_size         ; Directly move column_size into EBX for comparison
    dec ebx                     ; Subtract 1 from EBX since the last column is padded
    movzx eax,column_index_var ; Move the current column index to EAX
    cmp ebx,eax                ; Compare the current column index with the last column
    je update_to_next_row      ; If we're at the last column, update to the next row
    jmp continue_loop          ; Otherwise, continue to the next cell in the same row

update_to_next_row:
    mov column_index_var,1     ; Reset column index to 1 (start from the first column)
    inc row_index_var          ; Move to the next row

continue_loop:
    loop L1                    ; Loop through the grid cells (continue until all rows are processed)

    ; End of grid update function
ret
update_grid endp


END
