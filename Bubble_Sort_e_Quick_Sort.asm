TITLE Projeto2

.MODEL SMALL
.STACK 100H

.DATA

TamVet DW ?
Valor DW 0
Valor2 DW 0
cont dw 0
cont1 dw 0
Vet DW 30000 DUP (0)
X DW 0
Y DW 0
AUX DW 0
OPCAO DW ?
S0 DW 800
contBubble dw 0
contBubble2 dw -1
contBubble3 dw 0
i dw 0
esq dw 0
dir dw 0
pivo dw 0
pos dw 0
num1 dw 0
posicao dw 0
menuzi dw 0
menuzi2 dw 0
comp2 dw 0
posicao2 dw 0
overflow1 dw 0
trocas dw 0
j dw 0
contarw dw 0
adrress dw 0
teste dw 0
numcomparacao dw 0
n dw 0
retornados dw 0
cont2 dw 0
quickC dw 0
dir2 dw 0
esq2 dw 0


MESSAGE1 DB "Digite a quantidade de dados (tamanho do vetor) e o (ENTER): $"

MESSAGE2 DB "Digite o valor desejado para a posicao do vetor e o (ENTER): $"

MESSAGE3 db"1 - Vetor incialmente ordenado!"                                ,0dh,0ah
 db"2 - Vetor inversamente ordenado!"                               ,0dh, 0ah
 db"3 - Vetor composto por valores (pseudo) aleatorios!"            ,0dh,0ah
 db"4 - Usuario preenche posicao por posicao do vetor desejado!"    ,0dh,0ah
 db"                                                           "    ,0dh, 0ah
 db "Escolha uma das opcoes de (1 a 4) acima e o (enter): $"        ,0dh,0ah
 
 MESSAGE4 DB "Erro!!! Digite um valor entre (1 e 4) referente a opcao desejada: $"
 
 MESSAGE5 DB "Erro!!! Digite um numero entre 0 e 30000: $"
 
 MESSAGE6 DB "Antes da Ordenacao: $"

 MESSAGE7 DB "Apos a Ordenacao: $"
 
 MEssage8 DB "valor foi Encontrado na posicao:$"
 
 Message9 DB "valor nao foi encontrado nesta sequencia.$"
 
 Message10 DB "o numero de comparacoes foi de:$"
 
 Message11 DB "Digite o numero para busca (sinal de - p/ sair):$"
 
 Message12 DB "Escolha uma das opcoes entre (1-2) e pressione (enter):",  0dh,0ah
 DB"1- Bubble Sort",0dh,0ah
 DB"2- Quick Sort",0dh,0ah
 db "$"
 
 Message13 db "Escolha uma das opcoes entre (1-2) e pressione (enter):",  0dh,0ah
  db "1- Busca sequencial",0dh,0ah
 db "2- Busca binaria",0dh,0ah
 db "$"
 
 Message20 db "vetor ja estava ordenado$"
 
 Message21 db "overflow detectado$"
 
 Message22 db "o numero de trocas foi de:$"
 
.CODE
.STARTUP 

MOV AX, @DATA
MOV DS, AX

MOV SI, offset Vet

CALL PULA_LINHA

CALL ENTRADA

MOV AX, OPCAO
cmp ax,1
je cres
cmp ax,2
je desc
CMP AX, 3
JE LOOP9
CMP AX, 4
JE LOOP101
JMP FIM

;**********************************************************************************

LOOP9:
XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX

MOV AX, 425
MOV BX, S0
MUL BX
ADD AX, 1040

DIVISAO:
XOR BX, BX
XOR DX, DX
MOV BX, 30000
DIV BX
XOR BX, BX
ADD BX, cont1
MOV [SI+BX], DX 
MOV S0, DX
MOV AX, cont1
ADD AX, 2
MOV cont1, AX
CMP AX, TamVet
JE SAIR4
JMP LOOP9

SAIR4:
CALL PULA_LINHA
CALL PULA_LINHA
CALL IMPRIME_VET
JMP menu

loop101:
jmp loop10

cres:
mov bx,0
mov cx,0
cres2:
mov [si+bx],cx
add bx,2
inc cx
cmp bx,TamVet
je menu
jmp cres2


desc:
mov ax,TamVet
mov dx,0
mov bx,2
div bx
mov cx,ax
mov bx,0
desc2:
mov [si+bx],cx
add bx,2
dec cx
cmp bx,TamVet
je menu
jmp desc2

print:
call IMPRIME_VET
jmp busca

menu:
call limpar_tela
mov ah,9
mov dx,offset Message12
int 21h
mov ah,0
mov ah,1
int 21h
mov ah,0
sub ax,48
cmp ax,2
jg menu
cmp ax,1
jl menu
mov menuzi,ax
cmp ax,1
je inicio2
cmp ax,2
je quicks12

foie:
mov ah,9
mov dx,offset message21
int 21h
jmp menu3
menu2:
call pula_linha
cmp overflow1,1
je foie
menu3:
call pula_linha
mov ah,9
mov dx,offset message13
int 21h
mov ah,1
int 21h
mov ah,0
sub ax,48
;call p1
cmp ax,2
jg menu2
cmp ax,1
jl menu2
cmp ax,2
je busca11
cmp ax,1
je buscaS1

inicio2:
call pula_linha
mov ah,9
mov dx,offset message6
int 21h
mov cx,0
mov cont,0
call imprime_vet
jmp inicio1

quicks12:
jmp quicksl

;**********************************************************************************
LOOP10: 
MOV cont, 0
MOV CX, 0
CALL PULA_LINHA
CALL LEITURA_VET
MOV cont, 0
CALL PULA_LINHA
MOV AH, 09H
MOV DX, offset MESSAGE6
INT 21H
CALL PULA_LINHA
;CALL IMPRIME_VET
CALL PULA_LINHA
JMP menu
;********************************************************************************


;**************************************Bubblesort***************************************
busca11:
jmp busca10

buscaS1:
jmp buscaS

quicksl:
jmp quick

inicio1:
mov contBubble3,0
XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX

MOV AX, TamVet
MOV BX, TamVet
SUB BX, 4

inicio:
MOV DX, [SI+BX]
inc contBubble2
jo overflow
ew:
inc contBubble3
inc contBubble3
CMP DX, [SI+BX+2]
JG troca
JMP interM

inicio21:
jmp inicio1

 overflow:
 mov overflow1,1
jmp ew

troca:
inc trocas
mov contBubble3,0
MOV DX, [SI+BX+2]
MOV CX, [SI+BX]
MOV [SI+BX+2], CX
MOV [SI+BX], DX

InterM:
mov dx,TamVet
sub dx,2
cmp contBubble3,dx
je jordenado
SUB BX, 2
CMP BX, contBubble
JL InterI
JMP inicio

jordenado:
call pula_linha
mov ah,9
mov dx,offset message20
int 21h
Call pula_linha
mov ah,9
mov dx,offset message10
int 21h
inc contBubble2
mov ax,contBubble2
call p2
call pula_linha
mov ax,0
mov ah,9
mov dx,0
mov dx,offset message22
int 21h
mov ax,0
mov ax,trocas
call p2
jmp menu2

InterI:
ADD contBubble,2
CMP contBubble, AX
Jl inicio21
jmp printar

printar:
CALL PULA_LINHA
XOR AX, AX
MOV cont, 0
XOR CX, CX
MOV AH, 09H
MOV DX, offset MESSAGE7
INT 21H
CALL IMPRIME_VET
mov cx,0
mov cont,0


Call pula_linha
mov ah,9
mov dx,offset message10
int 21h
mov ax,contBubble2
call p2

call pula_linha
mov ax,0
mov ah,9
mov dx,0
mov dx,offset message22
int 21h
mov ax,0
mov ax,trocas
call p2

jmp menu2








JMP menu2
;**************************************************

busca10:
jmp busca

BuscaS:
mov valor,0
mov posicao2,0
mov comp2,0
call pula_linha
mov bx,0
mov ah,9
mov dx, offset message11
int 21h
mov ax,0
call p1
mov ax,valor
cmp ax,-3
je fim10

repeter3:
inc comp2
cmp [si+bx],ax
je econtro
add bx,2
cmp bx,TamVet
jl repeter3
jmp naoenconter

econtro:
mov ax,0
mov ax,bx
mov bx,0
mov bx,2
mov dx,0
div bx
mov posicao2,ax
mov ah,9
mov dx,offset message8
int 21h
mov ax,0
mov ax,posicao2
call p2
call pula_linha
mov ah,9
mov dx,offset message10
int 21h
mov ax,0
mov ax,comp2
call p2
jmp buscaS

naoenconter:
call pula_linha
mov ah,9
mov dx, offset message9
int 21h
call pula_linha
mov ah,9
mov dx,offset message10
int 21h
mov ax,0
mov ax,comp2
call p2
jmp buscaS


fim10:
jmp fim4


busca:
mov pos,0
mov pivo,0
mov esq,0
mov dir,0
mov posicao,0
mov ax,0
mov ax,TamVet
sub ax,2
mov dir,ax
mov esq,0
call pula_linha
mov ah,9
mov dx,offset message11
int 21h
mov ax,0
call p1
mov ax,valor
cmp ax,-3
je fim4
mov cx,valor



repetir:
mov ax,0
add ax,esq
add ax,dir
mov bx,4
mov dx,0
div bx
mov bx,2
mul bx
mov bx,0
mov pivo,ax
mov bx,pivo
inc posicao
cmp [si+bx],cx
je encontro
cmp [si+bx],cx
jl menor
cmp [si+bx],cx
jg maior

fim4:
jmp fim

repetir2:
mov ax,0
mov ax,esq
cmp ax,dir
jle repetir
jmp ruim

encontro:
mov pos,bx
mov ax,pos
mov cont, 0
mov cx, 0
mov pos,ax
mov dx,offset message8
mov ah,9
int 21h
mov ax,0
mov ax,pos
mov bx,2
mov dx,0
div bx
;add ax,1
call p2
call pula_linha
mov dx,offset message10
mov ah,9
int 21h
mov ax,posicao
mov cont,0
mov cx,0
call p2
jmp busca

menor:
mov ax,0
mov ax,pivo
add ax,2
mov esq,ax
jmp repetir2

maior:
mov ax,0
mov ax,pivo
sub ax,2
mov dir,ax
jmp repetir2

ruim:
mov ah,9
mov dx,offset message9
int 21h

call pula_linha
mov dx,offset message10
mov ah,9
int 21h
mov ax,posicao
mov cont,0
mov cx,0
call p2


jmp busca

quick:
call pula_linha
mov ah,9
mov dx,offset message6
int 21h
mov cx,0
mov cont,0
call imprime_vet



CALL ZERA_X

MOV AX, TamVet
SUB AX, 2


MOV dir, AX
MOV dir2, AX
MOV n, AX

MOV AX, 0
MOV esq, AX
MOV esq2, AX

mov ax, 0
MOV cont1, AX

LOOP7:          ; Início da função
CALL ZERA_X     ; zero os registradores
mov ax, 0
mov i, ax        ; zero a variavel i
mov j, ax        ; zero a variavel j

CALL ZERA_X

mov ax, dir
mov dir, ax
MOV AX, esq     ; movo esquerda para ax
ADD AX, dir      ; adiciono ax com bx e salvo em bx

;mov dx, ax
;add dx, 48
;mov ah, 2
;int 21h

XOR DX, DX      ; zero o dx
xor bx, bx
MOV BX, 4       ; movo 4 para o bx
DIV BX          ; divido o ax por 4

XOR DX, DX     ; limpo o dx novamente
xor bx, bx
MOV BX, 2      ; movo 2 para o bx
MUL BX         ; mutiplico por 2 o resultado da divisao 
XOR BX, BX
XOR DX, DX

MOV BX, AX
MOV DX, [SI+BX]

MOV pivo, DX   ; movo o resultado da operação para o pivo
;add dx, 48
;mov ah, 2
;int 21h
  
XOR DX, DX

MOV DX, esq    ; movo esquerda para o ax
MOV i, DX      ; movo o ax que é esquerda para a variavel i

XOR DX, DX

MOV DX, dir    ; movo direita para o ax
MOV j, DX      ; movo o ax para a variavel j



LOOP8:         ; inicio do meu "DO"

LOOP11:
CALL ZERA_X    ; zera os registradores

MOV BX, i        ; movo a variavel i para o meu bx
MOV DX, [SI+BX]  ; movo a posicao do vetor para o registrador ax

CMP DX, pivo     ; comparo o vetor na posicao i com o pivo
JL incrementa    ; se caso o vetor for menor vou para o loop incrementa

JMP LOOP12

incrementa:
inc QuickC      ; incrementa
CALL ZERA_X      ; zero os registradores
MOV AX, i        ; movo i para o ax
ADD AX, 2        ; add 2 no ax
MOV i, AX        ; movo ax para a posicao i
JMP LOOP11       ; vou para o loop11



LOOP12:          ;loop12
CALL ZERA_X      ; zero os registradores

MOV BX, j        ; movo o j para o bx
MOV DX, [SI+BX]  ; movo a posicao do vetor para o registrador ax

CMP DX, pivo     ; comparo a posicao do vetor com o pivo
JG descrementa   ; se caso for maoir vai para o loop descrementa

JMP LOOP13

descrementa:
inc QuickC    ; descrementa:
CALL ZERA_X     ; zero os registradores
MOV AX, j       ; movo o j para o registrador ax
SUB AX, 2       ; subtraio 2 de ax
MOV j, AX       ; movo ax para a variavel j
JMP LOOP12      ; vou para o loop12


LOOP811:
JMP LOOP8
 
LOOP13:        ; loop13:
CALL ZERA_X    ; zero os registradores 

mov DX, i      ; movo i para o registrador ax

cmp DX, j      ; comparo o i com o j
JG loop19      ; se caso for maior vai para o loop19

CALL ZERA_X    ; zero os registradores 

MOV BX, i      ; movo o i para o bx
MOV DX, [SI+BX] ; movo o vetor na posicao i para o dx

MOV AUX, DX     ; movo o registrador dx para a variavel aux

CALL ZERA_X    ; zero os registradores 

MOV BX, j       ; movo o j para o bx
MOV DX, [SI+BX] ; movo o vetor na posicao j para o dx 

XOR BX, BX      ; zero o bx

MOV BX, i       ; movo i para o bx 
MOV [SI+BX], DX ; movo o conteudo do vetor na posicao j para o vetor na posicao i

CALL ZERA_X     ; zero os registradores

MOV DX, AUX     ; movo aux para o dx
MOV BX, j       ; movo o j para o bx
MOV [SI+BX], DX ; movo o dx que é o aux para o vetor na posicao j

XOR AX, AX

MOV AX, i       ; movo i para o ax
ADD AX, 2       ; adiciono o ax com 2
MOV i, AX       ; movo o ax para o i

XOR AX, AX

MOV AX, j       ; movo o j para o ax
SUB AX, 2       ; subtraio o ax com 2
MOV j, AX       ; movo o ax para o j


loop19:          ;loop19:

CALL ZERA_X     ; zero os registradores

MOV DX, i       ; movo o i para o ax

CMP DX, j       ; comparo o i com o je
JL LOOP811      ; se caso for menor volta no meu "DO"

CALL ZERA_X     ; zero os registradores


MOV DX, esq     ; movo o valor de esquerda para o ax
CMP DX, j       ; comparo esquerda com o j
JL LOOP14       ; se caso for menor vou para o loop14
jmp loop15

loop14:         ; LOOP14
CALL ZERA_X     ; zero os registradores

MOV DX, cont1   ; movo ocont1 paro o ax
cmp DX, 0      ; comparo o ax com o 0
je loop17       ; se for igual vai para o loop17
jmp loop20      ; senão vai para o loop20

loop17:
CALL ZERA_X     ; zero os registradores
MOV AX, cont1   ; movo o cont1 para o ax
ADD AX, 25      ; adiciono 25 no ax
ADD cont1, AX   ; movo o ax para o cont1
 
CALL ZERA_X     ; zero os registradores
 
MOV DX, i       ; movo o i para o ax
PUSH DX         ; dou um push com ax que é o i

XOR DX, DX

MOV DX, dir     ; movo o dir para o ax
PUSH DX         ; dou um push coo ax que é o dir

XOR DX, DX

MOV DX, j       ; movo o j para o ax
MOV dir, DX

XOR DX, DX
JMP LOOP7


loop20:
CALL ZERA_X     ; zero os registradores

MOV DX, j       ; movo o j para o ax
mov dir, DX
xor dx, dx
JMP LOOP7



loop15:
CALL ZERA_X     ; zero os registradores
mov dx, cont2
cmp dx, 0
je loop30


CALL ZERA_X

MOV DX, i

cmp DX, dir
JL loop16

JMP quick2





loop30:
xor ax, ax
mov ax, cont2
mov ax, 356
mov cont2, ax

POP DX
MOV dir, DX

XOR DX, DX

POP DX
MOV i, DX

CALL ZERA_X

MOV DX, i

cmp DX, dir
JL loop16

JMP quick2

loop16:
CALL ZERA_X     ; zero os registradores

MOV DX, i
mov esq, DX


XOR DX, DX
JMP LOOP7


quick2:


call pula_linha
mov ah,9
mov dx,offset message6
int 21h
mov cx,0
mov cont,0
call imprime_vet
call pula_linha
mov ah,9
mov dx,offset message10
int 21h
mov ax,0
mov ax,quickC
call p2
jmp menu2











FIM:
CALL PULA_LINHA
MOV AH, 4CH
INT 21H


















;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; FUNÇÕES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
P1 PROC  ;pegar um valor e dar enter

XOR AX, AX
XOR BX, BX
XOR DX, DX

MOV AH, 1
INT 21H

MOV DL, AL
SUB DX, 48
MOV Valor, DX

;;;;;;;;;;;;;;;;;;;;;;;;;;;

LOOP1:
XOR AX, AX
XOR BX, BX
XOR DX, DX

MOV AH, 1
INT 21H

MOV DL, AL

cmp DX, 13
JE LOOP2

SUB DX, 48
MOV Valor2, DX
MOV AX, Valor
MOV BX, 10
MUL BX 
ADD AX, Valor2
MOV Valor, AX 
jmp LOOP1

LOOP2:
RET
P1 ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;************************************************************************
P2 PROC ;imprime qualquer numero

IMPRIME:
XOR BX, BX
XOR DX, DX
ADD BX, 10
DIV BX
PUSH DX

ADD CX, 1
cmp AX, 0 
JE IMPRIME2
JMP IMPRIME

IMPRIME2:
POP DX
ADD DX, 48
SUB CX, 1
MOV AH, 2
INT 21H
cmp CX, 0
je encerar
jmp IMPRIME2

encerar:
RET
P2 ENDP
;***********************************************************


;*******************************************************************
IMPRIME_VET PROC

LOOP5:
XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX

ADD BX, cont

MOV DX, 124
MOV AH, 2
INT 21H

MOV AX, [SI+BX]
CALL P2
MOV AX, cont
ADD AX, 2
MOV cont, AX
CMP AX, TamVet
JE SAIR2
JMP LOOP5

SAIR2:
MOV DX, 124
MOV AH, 2
INT 21H
RET 
IMPRIME_VET ENDP
;*****************************************************************************************



;*******************************************************************************************
lEITURA_VET PROC
LOOP3:
XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX

MOV AH, 09H
MOV DX, offset message2
INT 21H

XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX

XOR AX, AX
XOR DX, DX

CALL P1

XOR BX, BX
ADD BX, cont
MOV DX, Valor
MOV [SI+BX], DX

MOV AX, cont
ADD AX, 2
MOV cont, AX
CMP AX, TamVet
JE SAIR

JMP LOOP3

SAIR:
RET
LEITURA_VET ENDP
;****************************************************************************************************



;*****************************************************************************************************
;Função para pular linha
PULA_LINHA PROC
MOV DL, 10
MOV AH, 02H
INT 21H

MOV DL, 13
MOV AH, 02H
INT 21H
RET
PULA_LINHA ENDP
;******************************************************************************************************



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ENTRADA PROC
MOV AH, 09H
MOV DX, offset MESSAGE1
INT 21H
JMP L1

LOOP6:
MOV AH, 09H
MOV DX, offset MESSAGE5
INT 21H
L1:
CALL P1

MOV AX, Valor
ADD AX, 35535
JC LOOP6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SUB AX, 35535
MOV TamVet, AX
ADD AX, TamVet
MOV TamVet, AX
CALL PULA_LINHA

;***************************************************************************************************
MOV AH, 09H
MOV DX, offset MESSAGE3
INT 21H

LOOP4:
CALL P1

MOV AX, Valor
MOV OPCAO, AX

CMP AX, 1
JE SAIR3
CMP AX, 2
JE SAIR3
CMP AX, 3
JE SAIR3
CMP AX, 4
JE SAIR3

MOV AH, 09H
MOV DX, offset MESSAGE4
INT 21H
JMP LOOP4

SAIR3:
RET 
ENTRADA ENDP
;******************************************************************************************************


;**************************************BUBBLE SORT*****************************************************

;******************************************************************************************************




;******************************************************************************************************
;Função para limpar a tela
LIMPAR_TELA PROC
MOV AX, 03H
INT 10H
RET
LIMPAR_TELA ENDP
;********************************************************************************************************
ZERA_X PROC
XOR AX, AX
XOR BX, BX
XOR CX, CX
XOR DX, DX
RET
ZERA_X ENDP



end

;*********************************************************************************************************