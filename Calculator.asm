section .data
    Msg1: db "Introduce primul numar: "
    Msg1Len: equ $-Msg1

    Msg2: db "Introduce al doilea numar: "
    Msg2Len: equ $-Msg2

    Msg3: db "Intrduce operatorul(1 pentru +, 2 pentru -, 3 pentru *, 4 pentru /): "
    Msg3Len: equ $-Msg3

    Msg4: db "Rezultatul este:"
    Msg4Len: equ $-Msg4

    Msg5: db ".", 0xA
    Msg5Len: equ $-Msg5

section .bss
    num1 rest 5
    num2 rest 5
    op rest 5
    num3 rest 5

section .text
    global _start
        _start:
            mov eax, 4
            mov ebx, 1
            mov ecx, Msg1
            mov edx, Msg1Len
            int 0x80

            mov eax, 3
            mov ebx, 2
            mov ecx, num1
            mov edx, 5
            int 0x80 

            mov eax, 4
            mov ebx, 1
            mov ecx, Msg2
            mov edx, Msg2Len
            int 0x80

            mov eax, 3
            mov ebx, 2
            mov ecx, num2
            mov edx, 5
            int 0x80

            mov eax, 4
            mov ebx, 1
            mov ecx, Msg3
            mov edx, Msg3Len
            int 0x80

            mov eax, 3
            mov ebx, 2
            mov ecx, op
            mov edx, 5
            int 0x80

            mov eax, [op]
            cmp eax, 1
            je .plus

            cmp eax, 2
            je .minus

            cmp eax, 3
            je .inmultit
            
            cmp eax, 4
            je .impartire

            .plus:
                movzx eax, byte [num1]  
                sub   eax, '0'         
                movzx ebx, byte [num2] 
                sub   ebx, '0'        
                add   eax, ebx        
                add   eax, '0'      
                mov   [num3], eax       

            .minus:
                movzx eax, byte [num1]
                sub   eax, '0'
                movzx ebx, byte [num2]
                sub   ebx, '0'
                sub   eax, ebx
                add   eax, '0'
                mov   [num3], eax


            .inmultit:
                movzx eax, byte [num1]
                sub eax, '0'
                movzx ebx, byte [num2]
                sub  ebx, '0'
                imul ebx
                add eax, '0'
                mov [num3], eax

            .impartire:
                movzx eax, byte [num1]
                sub eax, '0'
                movzx ebx, byte [num2]
                sub ebx, '0'
                div ebx 
                add eax, '0'
                mov [num3], eax

            .resultat:
                mov eax, 4
                mov ebx, 1
                mov ecx, Msg4
                mov edx, Msg4Len
                int 0x80

                mov eax, 4
                mov ebx, 1
                mov ecx, num3
                mov edx, 5
                int 0x80

	            mov eax, 4
		        mov ebx, 1
		        mov ecx, Msg5
		        mov edx, Msg5Len
	 	        int 0x80

                jmp exit
            

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80


