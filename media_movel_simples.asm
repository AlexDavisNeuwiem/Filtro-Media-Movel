# Aluno: Alex Davis Neuwiem da Silva
# Matr�cula: 21202103

# $s0 = Ponteiro para Entrada
# $s1 = Ponteiro para Saida
# $s6 = Armazena M
# $s7 = Armazena N

# $t0 = Contador
# $t1 = Armazena temporariamente valores da Entrada
# $t2 = Somat�rio tempor�rio de valores
# $t3 = M�dia tempor�ria de valores
# $t4 = Ponteiro auxiliar

.data
	EntradaN:	.asciiz "Digite N: "
	EntradaM:	.asciiz "Digite M: "
	Espaco:		.asciiz " "

	.align 2
	Entradas:	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9

	.align 2
	Saidas:		.word
.text
Main:
	jal	MediaMovel
	j	Fim

MediaMovel:
	# Mostrando mensagem na tela
    	la      $a0, EntradaN
    	li      $v0, 4
    	syscall

	# 5 � para ler inteiro do teclado
	li 	$v0, 5
	syscall

	# $s7 armazena N
 	move 	$s7, $v0
 	
 	# Mostrando mensagem na tela
    	la      $a0, EntradaM
    	li      $v0, 4
    	syscall
 	
	# 5 � para ler inteiro do teclado
	li 	$v0, 5
	syscall

	# $s6 armazena M
 	move 	$s6, $v0

 	# $s0 � ponteiro para Entradas
 	la	$s0, Entradas

 	# $s1 � ponteiro para Saidas
 	la	$s1, Saidas

	# $t4 tamb�m � ponteiro para Entrada
	move	$t4, $s0

 	# Vari�veis s�o iniciadas com 0
 	li	$t0, 0
 	li	$t1, 0
 	li	$t2, 0
 	li	$t3, 0

 # M�dia para os primeiros valores da m�dia m�vel
 PrimeiraMedia:
 	# $t0 � contador para quando for uma m�dia de valores menores que N
 	addi	$t0, $t0, 1

 	# Carregando em $t1 o valor da Entrada
 	lw	$t1, 0($t4)

 	# $t2 armazena o somat�rio dos valores da Entrada
 	add	$t2, $t2, $t1

 	# $t3 � a m�dia, pois armazena a divis�o de $t2 por $t0
 	div	$t3, $t2, $t0

 	# $t3 � armazenado na sa�da
 	sw	$t3, 0($s1)

 	# Indo para o pr�ximo valor da Entrada
 	addi	$t4, $t4, 4

 	# Indo para o pr�ximo valor da sa�da
 	addi	$s1, $s1, 4

 	# Quando $t0 for igual a N, deve-se calcular a m�dia de N valores por N
 	bne	$t0, $s7, PrimeiraMedia
 	
 	# Resetando $t0 (contador)
 	li	$t0, 0
 	
 	# Como j� foram calculados N valores da m�dia, restam M - N
 	sub	$s6, $s6, $s7

 # M�dia que calcula os N valores por N em m�dia m�vel
 SegundaMedia:
 	# Incrementando o contador
 	addi	$t0, $t0, 1
 	
 	# $t1 armazena o valor da Entrada
 	lw	$t1, 0($s0)
 		
 	# Antes de $t1 receber o novo valor, ele deve ser subtra�do do somat�rio
 	sub	$t2, $t2, $t1

 	# $t1 armazena o valor da Entrada
 	lw	$t1, 0($t4)

 	# $t2 � o somat�rio dos valores da entrada
 	add	$t2, $t2, $t1

	# $t3 � a m�dia, pois armazena a divis�o de $t2 por $s7
 	div	$t3, $t2, $s7
 		
 	# $t3 � armazenado na sa�da
 	sw	$t3, 0($s1)

	# Indo para o pr�ximo valor da Entrada
 	addi	$t4, $t4, 4

 	# Indo para o pr�ximo valor da Entrada
 	addi	$s0, $s0, 4

 	# Indo para o pr�ximo valor da sa�da
	addi	$s1, $s1, 4

 	# Quando $t0 for igual a M, deve-se parar de calcular
 	bne	$t0, $s6, SegundaMedia
 	
 	# Fim do Procedimento
 	jr	$ra
 		
Fim:
	# Fim do Programa
	li      $v0, 10
    	syscall
