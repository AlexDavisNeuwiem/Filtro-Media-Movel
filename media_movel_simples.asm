# Aluno: Alex Davis Neuwiem da Silva
# Matrícula: 21202103

# $s0 = Ponteiro para Entrada
# $s1 = Ponteiro para Saida
# $s6 = Armazena M
# $s7 = Armazena N

# $t0 = Contador
# $t1 = Armazena temporariamente valores da Entrada
# $t2 = Somatório temporário de valores
# $t3 = Média temporária de valores
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

	# 5 é para ler inteiro do teclado
	li 	$v0, 5
	syscall

	# $s7 armazena N
 	move 	$s7, $v0
 	
 	# Mostrando mensagem na tela
    	la      $a0, EntradaM
    	li      $v0, 4
    	syscall
 	
	# 5 é para ler inteiro do teclado
	li 	$v0, 5
	syscall

	# $s6 armazena M
 	move 	$s6, $v0

 	# $s0 é ponteiro para Entradas
 	la	$s0, Entradas

 	# $s1 é ponteiro para Saidas
 	la	$s1, Saidas

	# $t4 também é ponteiro para Entrada
	move	$t4, $s0

 	# Variáveis são iniciadas com 0
 	li	$t0, 0
 	li	$t1, 0
 	li	$t2, 0
 	li	$t3, 0

 # Média para os primeiros valores da média móvel
 PrimeiraMedia:
 	# $t0 é contador para quando for uma média de valores menores que N
 	addi	$t0, $t0, 1

 	# Carregando em $t1 o valor da Entrada
 	lw	$t1, 0($t4)

 	# $t2 armazena o somatório dos valores da Entrada
 	add	$t2, $t2, $t1

 	# $t3 é a média, pois armazena a divisão de $t2 por $t0
 	div	$t3, $t2, $t0

 	# $t3 é armazenado na saída
 	sw	$t3, 0($s1)

 	# Indo para o próximo valor da Entrada
 	addi	$t4, $t4, 4

 	# Indo para o próximo valor da saída
 	addi	$s1, $s1, 4

 	# Quando $t0 for igual a N, deve-se calcular a média de N valores por N
 	bne	$t0, $s7, PrimeiraMedia
 	
 	# Resetando $t0 (contador)
 	li	$t0, 0
 	
 	# Como já foram calculados N valores da média, restam M - N
 	sub	$s6, $s6, $s7

 # Média que calcula os N valores por N em média móvel
 SegundaMedia:
 	# Incrementando o contador
 	addi	$t0, $t0, 1
 	
 	# $t1 armazena o valor da Entrada
 	lw	$t1, 0($s0)
 		
 	# Antes de $t1 receber o novo valor, ele deve ser subtraído do somatório
 	sub	$t2, $t2, $t1

 	# $t1 armazena o valor da Entrada
 	lw	$t1, 0($t4)

 	# $t2 é o somatório dos valores da entrada
 	add	$t2, $t2, $t1

	# $t3 é a média, pois armazena a divisão de $t2 por $s7
 	div	$t3, $t2, $s7
 		
 	# $t3 é armazenado na saída
 	sw	$t3, 0($s1)

	# Indo para o próximo valor da Entrada
 	addi	$t4, $t4, 4

 	# Indo para o próximo valor da Entrada
 	addi	$s0, $s0, 4

 	# Indo para o próximo valor da saída
	addi	$s1, $s1, 4

 	# Quando $t0 for igual a M, deve-se parar de calcular
 	bne	$t0, $s6, SegundaMedia
 	
 	# Fim do Procedimento
 	jr	$ra
 		
Fim:
	# Fim do Programa
	li      $v0, 10
    	syscall
