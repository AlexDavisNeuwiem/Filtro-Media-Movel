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

	.align 2
	Entradas:	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
	
	.align 2
	Saidas:		.word
	
	.align 2
	ConvSaidas:	.space 500
	
	ArqvSaidas:   	.asciiz "media_movel_simples.txt"
	
.text
.globl Main

Main:
	li	$t0, 0
	li	$t1, 0
	li	$t2, 0
	li	$t3, 0
	li	$t4, 0
	
	jal	MediaMovel
	j	EscreveArquivo

# Cálculo da Média Móvel --------------------------------------------------------------#
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

#--------------------------------------------------------------------------------------#

# Escrevendo a saída em arquivo -------------------------------------------------------#
EscreveArquivo:
	li	$t0, 0
	li	$t1, 0
	li	$t2, 0
	li	$t3, 0
	li	$t4, 0
	li	$s0, 0
	li	$s1, 0
	
	la 	$s0, Saidas
	la 	$s1, ConvSaidas

	# Espaço em ascii
	li 	$s2, 32
	# Sinal de menos em ascii
	li 	$s3, 45
	
	# Abrindo um arquivo inexistente
  	li   	$v0, 13
  	# Nome do arquivo
  	la   	$a0, ArqvSaidas
  	# Escrevendo no arquivo
  	li   	$a1, 1
  	# Modo ignorado
  	li   	$a2, 0
  	syscall
  	# $s5 armazena o descritor do arquivo
  	move 	$s5, $v0
	
LoopArray:
	# $t0 armazena valor de Saidas
	lw 	$t0, 0($s0)
	# Função que converte para ascii
	jal 	Conversao
	# Próximo valor de Saidas
	addi 	$s0, $s0, 4
	# Adiciona um espaço em ConvSaidas
	sw 	$s2, 0($s1)
	# Próximo valor de ConvSaidas
	addi 	$s1, $s1, 4
	addi 	$t1, $t1, 1
	bne 	$t1, $s6, LoopArray
	
	# Abrindo o arquivo de Saidas
  	li   	$v0, 15
  	move 	$a0, $s5
  	la   	$a1, ConvSaidas
  	li   	$a2, 500
  	syscall
  	
  	# Fechando o arquivo de Saidas 
  	li   	$v0, 16
  	move 	$a0, $s5
  	syscall
  	
  	j 	Fim

Conversao:
	# Se for negativo, pula
	blt 	$t0, 0 ConversaoMenor
	# Salva o $ra
	move 	$s4, $ra
 	jal 	PercorreInt	
 	jr 	$s4
 	
ConversaoMenor:
	# Registra no ConvSaidas
 	sw 	$s3, 0($s1)
 	# Atualiza o ConvSaidas
 	addi 	$s1, $s1, 4
 	# Inverte o número para positivo
 	not 	$t0, $t0
 	addi 	$t0, $t0, 1
 	move 	$s4, $ra
 	jal 	PercorreInt
 	jr 	$s4

PercorreInt:
	# Divisão por 10
	div 	$t2, $t0, 10
	mflo 	$t0
	mfhi 	$t3
	# Registra na pilha
	sw 	$t3, 0($sp)
	# Atualiza a pilha
	addi 	$sp, $sp, -4
	# Registra o tamanho do inteiro
	addi 	$t5, $t5, 1
	bgt 	$t2, 0, PercorreInt
	
	# Volta 1 passo da pilha
	addi 	$sp, $sp, 4

ArmazenarInt:
	# Pega o inteiro
	lw 	$t2, 0($sp)
	addi 	$sp, $sp, 4
	addi 	$t2, $t2, 48
	# Armazena o inteiro em ConvSaidas
	sw 	$t2, 0($s1)
	addi 	$s1, $s1, 4
	# Armazena até atingir o tamanho do inteiro
	addi 	$t6, $t6, 1
	blt 	$t6, $t5, ArmazenarInt
	
	jr 	$ra

#--------------------------------------------------------------------------------------#	

Fim:
	# Fim do Programa
	li      $v0, 10
    	syscall
