.data
  str: .space 1000
  chDelim: .asciz " "
  formatScanf: .asciz "%[^\n]s" 
  formatPrintf: .asciz "%d "
  formatPrintfn: .asciz "\n"
  v: .space 1000
  fv: .space 1000
  rez: .space 4
  m: .space 4
  n: .space 4
  trein: .space 4
  trei: .long 3
  n_bkt: .space 4
  m_bkt: .space 4
  pozitie: .space 4
  nr_element: .space 4
  stanga: .space 4
  dreapta: .space 4
  variabila: .space 4
  metallica: .space 4
  contor: .space 4
.text
.global main
verificare:
       pushl %ebp
       movl %esp, %ebp
       pushl %edi
       pushl %ecx
 
       movl 8(%ebp), %ecx
       movl 12(%ebp), %edi
       movl 16(%ebp), %ebx
       movl %ebx, nr_element
       movl %ecx, variabila
       
       xorl %ecx, %ecx
       xorl %eax, %eax
       movl $0, contor
       
for1_verificare:
        cmp trein, %ecx
        je exit_for1verificare      
        movl (%edi, %ecx, 4), %ebx

        cmp %ebx, variabila
        jne contfor1_verificare            #nu fac compararea cu 3#
        incl contor
contfor1_verificare:
        incl %ecx
        jmp for1_verificare   
exit_for1verificare:
        cmp $3, contor
        jl exit_for1verificare1
        incl %eax
exit_for1verificare1:
        movl nr_element, %ebx
        subl m, %ebx
        movl %ebx, stanga        #de facut cu nrelement si de luat cazu ala egal cu el
        movl nr_element, %ebx
        addl m, %ebx
        movl %ebx, dreapta
        movl stanga, %ecx
for2_verificare:
        cmp %ecx, nr_element
        je contfor2_verificare
        cmp %ecx, dreapta
        jl exit_for2verificare
        movl (%edi, %ecx, 4), %ebx

        cmp %ebx, variabila
        jne contfor2_verificare
        incl %eax
contfor2_verificare:
        incl %ecx
        jmp for2_verificare
exit_for2verificare:
        

                          #stanga=variabila-m
                          #dreapta=variabila+m 


       popl %ecx
       popl %edi
       popl %ebp
       ret


bkt:
       pushl %ebp
       movl %esp, %ebp
       pushl %esi
       pushl %edi
       pushl %ecx
       pushl %ebx
       movl 8(%ebp), %esi
       movl 12(%ebp), %edi
       movl 16(%ebp), %ecx
       incl %ecx
       movl %ecx, metallica
       movl (%edi, %ecx, 4), %ebx
       movl %ebx, pozitie
       
       
      
       
       
       

for_bkt:
       cmp trein, %ecx              #i-ul meu este %ecx si v[i] este practic pozitie
       je exit_bkt
       cmp  $0, pozitie
       jne exit1_bkt                    #####pana aici functioneaza programul####
       movl %ecx, nr_element             ######aici am ramas####### 
       
       movl $1, %ecx
for2_bkt:   
       movl n, %ebx                
       cmp %ebx, %ecx
       jg  contfor2_bkt_esec      
       pushl nr_element
       pushl %edi
       pushl %ecx
       call verificare
       popl %ecx
       popl %edi
       popl nr_element
       cmp $0, %eax               #verificarea este buna, doar sa si restaurez cu 0 elementul lucrat
       je contfor2_bkt_succes
       

      incl %ecx
      jmp for2_bkt
contfor2_bkt_esec:        
                                                                      #foarte posibil sa trebuiasca doar inca un for si aia e
                                                                       #practic trebuie sa ma intorc cu verificare(k-1) pana gasesc ceva valid
                                                                       # mut valoarea lui v[i-1] si o iau ca si element de inceput, de unde mai apoi ma duc pana pot genera alta varianta
       movl metallica, %ecx
       subl $1, %ecx
for_contfor2_bkt_esec:
       cmp $-1, %ecx              
       jne iron_maiden
       movl %ecx, %eax
       jmp exit_bkt
                                                           ###aici am inceput incercarea de -1####
iron_maiden:
       movl (%esi, %ecx, 4), %ebx
       cmp $0, %ebx
       je motorhead
       subl $1, %ecx
       jmp for_contfor2_bkt_esec
motorhead:



                                              #in loc sa pun 0, trebuie sa il duc in alta eticheta unde sa se intoarca pana poate gasii una buna
       
       movl %ecx, nr_element
       movl  metallica, %ecx    
       movl $0, (%edi, %ecx, 4)
       movl nr_element, %ecx
       movl %ecx, metallica
       movl (%edi, %ecx,4), %ebx                                       ######de rezolvat bugul in care sare peste valorile fixe#####
       movl %ebx, %ecx                                                 #####fac un vector de frecventa si un for de la valoarea actuala pana la urmatoarea valoare care nu e fixa#####
       incl %ecx
       jmp for2_bkt

contfor2_bkt_succes:
      movl %ecx, %ebx
      movl metallica, %ecx
      movl %ebx, (%edi,%ecx,4)
      
exit1_bkt:
       movl metallica, %ecx
       
       pushl %ecx
       pushl %edi
       pushl %esi
       call bkt
       popl %esi
       popl %edi
       popl %ecx
       
  


exit_bkt:

       popl %ebx
       popl %ecx
       popl %edi
       popl %esi
       popl %ebp
       ret
       
main:
        movl $v, %edi
        movl $fv, %esi
        pushl $str
        pushl $formatScanf
        call scanf
        popl %ebx
        popl %ebx
etick:

        pushl $chDelim
	pushl $str
	call strtok 
	popl %ebx
	popl %ebx

       movl %eax, rez
       pushl rez
       call atoi
       popl %ebx

       movl %eax, n

       pushl $chDelim
	pushl $0
	call strtok 
	popl %ebx
	popl %ebx

       movl %eax, rez
       pushl rez
       call atoi
       popl %ebx

       movl %eax, m
        movl n, %eax
        xorl %ecx, %ecx
        xorl %edx, %edx
        movl n, %eax
        mull trei
        movl %eax, trein
for_citire:
        
        pushl %ecx
        pushl $chDelim
	pushl $0
	call strtok 
	popl %ebx
	popl %ebx
        popl %ecx

       movl %eax, rez
       pushl %ecx
       pushl rez
       call atoi
       popl %ebx
       popl %ecx
power:

       movl %eax, (%edi,%ecx,4)
       cmp $0, %eax
       je cont_power_0
       movl $1, (%esi, %ecx, 4)
       jmp cont_power
cont_power_0:
       movl $0, (%esi, %ecx, 4)
cont_power:

       incl %ecx
       cmp %ecx, trein
       jg for_citire      #pana aici se face citirea, practic
exodus:       
       pushl $-1
       pushl %edi
       pushl %esi
       call bkt
       popl %ebx
       popl %ebx
       popl %ebx
       cmp $-1, %eax
       jne for1_afisare
       pushl $-1
       pushl $formatPrintf
       call printf
       popl %ebx
       popl %ebx
       jmp et_exit


       
for1_afisare:
       xorl %ecx, %ecx
for_afisare:
       movl (%edi,%ecx,4), %eax
       pushl %ecx
       pushl %eax
       pushl $formatPrintf
       call printf
       popl %ebx
       popl %ebx
       popl %ecx
       addl $1, %ecx
       cmp trein, %ecx
       jne for_afisare
               
       
et_exit:
        
pushl $0
 call fflush
 popl %ebx

 pushl $formatPrintfn
 call printf
 popl %ebx
        
        
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
