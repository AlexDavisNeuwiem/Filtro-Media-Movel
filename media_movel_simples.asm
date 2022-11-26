# Aluno: Alex Davis Neuwiem da Silva
# Matricula: 21202103

# $s0 = Ponteiro para Entrada
# $s1 = Ponteiro para qualquer Saida
# $s2 = Armazena a quantidade de valores de Entradas
# $s3 = Armazena N
# $s4 = Ponteiro para Saida01
# $s5 = Ponteiro para Saida02

.data
	N:		.asciiz "Digite N: "
	
	Valor:		.asciiz "Digite um valor (0 para finalizar): "

	.align 2
	Entradas:	.float
	
	.align 2
	Saida01:	.float
	
	.align 2
	Saida02:	.float

.text
.globl Main

Main:
	# Procedimento para armazenar na memoria os valores digitados
	jal	Inicio
	
	# $s1 = ponteiro para Saidas01
	la	$s1, Saida01
	jal	MediaMovel
	
	# $s4 = ponteiro para Saidas01
	move	$s4, $s1
	
	# $s1 = ponteiro para Saidas02
	la	$s1, Saida02
	jal	MediaMovel
	
	# $s5 = ponteiro para Saidas02
	move	$s5, $s1
	
	# Procedimento pra comparar os valores das medias moveis
	jal	Compara
	
	# Encerra o programa
	j	Fim

# Procedimento para armazenar na memoria os valores digitados ----------------------#
Inicio:
	# Mostrando mensagem na tela
    	la      $a0, N
    	li      $v0, 4
    	syscall

	# 5 = comando para ler inteiro do teclado
	li 	$v0, 5
	syscall

	# $s3 armazena N
 	move 	$s3, $v0
 	
 	# $s0 = ponteiro para Entradas
 	la	$s0, Entradas
 	
 	# $t0 = ponteiro auxiliar para Entradas
	move	$t0, $s0
	
	# $s2 comeca com 0
 	li	$s2, 0
 	
 	# Armazena 0 em $f1
	mtc1	$zero, $f1
	
LoopEntrada:
	
	# Mostrando mensagem na tela
    	la      $a0, Valor
    	li      $v0, 4
    	syscall
 	
	# 6 = comando para ler float do teclado
	li 	$v0, 6
	syscall 
	
	# $f0 = $f1?
	c.eq.s	$f0, $f1
	
	# Se $f0 = $f1, entao vai para Continua
	bc1t  	Continua
	
	# Armazena a entrada digitada em Entradas
	s.s 	$f0, 0($t0)
 	
 	# $s2 armazena a quantidade de valores de Entradas
 	addi	$s2, $s2, 1
 	
 	# Indo para o proximo valor de Entradas
 	addi	$t0, $t0, 4
 	
 	j	LoopEntrada
 
 Continua:
 	# Resetando $t0
 	li	$t0, 0
 	
 	# Retornando para Main
 	jr	$ra

#-----------------------------------------------------------------------------------#

# Procedimento pra calcular a media movel simples ----------------------------------#
MediaMovel:
	# $t0 = ponteiro auxiliar para Entradas
	move	$t0, $s0
	
	# $t1 = ponteiro auxiliar para Saida
	move	$t1, $s1
	
	# $t2 = contador
	li	$t2, 0
	
	# $f2 e $f3 comecam com 0
	mtc1	$zero, $f2
	mtc1	$zero, $f3
	
	# $f4 comeca com o primeiro valor de Entradas
	l.s	$f4, 0($t0)
	
	# $f5 armazena N
	mtc1	$s3, $f5
	
CalculaMedia:
	# Incrementando o contador
 	addi	$t2, $t2, 1
 	
 	# $f6 armazena o somatorio dos valores de Entradas
 	add.s	$f6, $f2, $f3
 	add.s	$f6, $f6, $f4
 	
 	# $f7 armazena a media dos valores
 	div.s	$f7, $f6, $f5
 	
 	# Media armazenada na Saida
 	s.s	$f7, 0($t1)
 	
 	# Atualizando os valores
 	addi	$t0, $t0, 4
 	addi	$t1, $t1, 4
 	
	mov.s	$f2, $f3
	mov.s	$f3, $f4
	l.s	$f4, 0($t0)

	# Quando $t2 for igual a $s2, deve-se parar de calcular
	bne	$t2, $s2, CalculaMedia
	
	# Resetando todos os registradores utilizados no calculo
	li	$t0, 0
	li	$t1, 0
	li	$t2, 0
	
	mtc1	$zero, $f2
	mtc1	$zero, $f3
	mtc1	$zero, $f4
	mtc1	$zero, $f5
	mtc1	$zero, $f6
	mtc1	$zero, $f7
	
	# Retornando para Main
 	jr	$ra

#-----------------------------------------------------------------------------------#

# Procedimento pra comparar os valores das medias moveis ---------------------------#
Compara:
	

	# Retornando para Main
 	jr	$ra

#-----------------------------------------------------------------------------------#

# Fim do programa ------------------------------------------------------------------#
Fim:
	li      $v0, 10
    	syscall

#-----------------------------------------------------------------------------------#