InicializaJogador:			# InicializaJogador - Início
        addiu   $sp,$sp,-8		
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        sw      $5,12($fp)
        move    $2,$6
        sb      $2,16($fp)		
        lw      $2,8($fp)
        lw      $3,12($fp)
        nop
        sw      $3,0($2)
        lw      $2,8($fp)
        li      $3,24               	# 0x18
        sw      $3,4($2)
        lw      $2,8($fp)
        li      $3,20                 	# 0x14
        sw      $3,8($2)
        lw      $2,8($fp)
        lbu     $3,16($fp)
        nop
        sb      $3,12($2)
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31			
        nop				# InicializaJogador - Fim

PosicionaJogador:
        addiu   $sp,$sp,-24		# PosicionaJogador - Início
        sw      $fp,20($sp)
        move    $fp,$sp
        sw      $4,24($fp)
        sw      $5,28($fp)
        sw      $6,32($fp)
        sw      $7,36($fp)
        lw      $2,28($fp)
        nop
        sw      $2,8($fp)
        b       $L3		
        nop

$L4:
        lw      $2,24($fp)
        lb      $3,36($fp)
        lui     $4,%hi(Pong)
        lw      $5,8($fp)
        nop
        sll     $5,$5,6
        addiu   $4,$4,%lo(Pong)
        addu    $4,$5,$4
        addu    $2,$4,$2
        sb      $3,0($2)
        lw      $2,8($fp)
        nop
        addiu   $2,$2,1
        sw      $2,8($fp)
$L3:
        lw      $2,28($fp)
        nop
        addiu   $3,$2,10
        lw      $2,8($fp)
        nop
        slt     $2,$3,$2
        beq     $2,$0,$L4
        nop

        lw      $2,28($fp)
        nop
        sw      $2,8($fp)
        b       $L5
        nop

$L6:
        lw      $2,24($fp)
        lb      $3,36($fp)
        lui     $4,%hi(Pong)
        lw      $5,8($fp)
        nop
        sll     $5,$5,6
        addiu   $4,$4,%lo(Pong)
        addu    $4,$5,$4
        addu    $2,$4,$2
        sb      $3,0($2)
        lw      $2,8($fp)
        nop
        addiu   $2,$2,-1
        sw      $2,8($fp)
$L5:
        lw      $2,28($fp)
        nop
        addiu   $3,$2,-10
        lw      $2,8($fp)
        nop
        slt     $2,$2,$3
        beq     $2,$0,$L6
        nop

        nop
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        j       $31		
        nop				# PosicionaJogador - Fim

EscolheMovimentoJogador:		# EscolheMovimentoJogador - Início
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        sw      $5,12($fp)
        sw      $6,16($fp)
        sw      $7,20($fp)
        lw      $3,12($fp)
        lw      $2,16($fp)
        nop
        srl     $4,$2,31
        addu    $2,$4,$2
        sra     $2,$2,1
        subu    $2,$3,$2
        addiu   $2,$2,1
        slt     $2,$2,3
        beq     $2,$0,$L8
        nop

        lw      $2,24($fp)
        nop
        sw      $0,0($2)
$L8:
        lw      $3,12($fp)
        lw      $2,16($fp)
        nop
        srl     $4,$2,31
        addu    $2,$4,$2
        sra     $2,$2,1
        addu    $2,$3,$2
        addiu   $2,$2,-1
        slt     $2,$2,45
        bne     $2,$0,$L9
        nop

        lw      $2,24($fp)
        li      $3,1             	# 0x1
        sw      $3,0($2)
$L9:
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31				
        nop				# EscolheMovimentoJogador - Fim

MovimentaJogador:			# MovimentaJogador - Início
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        sw      $5,12($fp)
        lw      $3,12($fp)
        li      $2,1            	# 0x1
        bne     $3,$2,$L11
        nop

        lw      $2,8($fp)
        nop
        lw      $2,4($2)
        nop
        addiu   $3,$2,-1
        lw      $2,8($fp)
        nop
        sw      $3,4($2)
        b       $L13
        nop				

$L11:
        lw      $2,8($fp)
        nop
        lw      $2,4($2)
        nop
        addiu   $3,$2,1
        lw      $2,8($fp)
        nop
        sw      $3,4($2)
$L13:
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop				# MovimentaJogador - Fim

RandomizaInicioBola:			# RandomizaInicioBola - Início
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        sw      $16,28($sp)
        move    $fp,$sp
        sw      $4,40($fp)
        move    $4,$0
        jal     time
        nop

        move    $4,$2
        jal     srand
        nop

        jal     rand
        nop

        move    $3,$2
        li      $2,20                 	# 0x14
        bne     $2,$0,1f
        div     $0,$3,$2
        break   7
1:
        mfhi    $2
        move    $16,$2
        jal     rand
        nop

        move    $3,$2
        li      $2,-2147483648 		# 0xffffffff80000000
        ori     $2,$2,0x1
        and     $2,$3,$2
        bgez    $2,$L15
        nop

        addiu   $2,$2,-1
        li      $3,-2               	# 0xfffffffffffffffe
        or      $2,$2,$3
        addiu   $2,$2,1
$L15:
        mult    $16,$2
        li      $2,24                 	# 0x18
        mflo    $3
        subu    $3,$2,$3
        lw      $2,40($fp)
        nop
        sw      $3,4($2)
        nop
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        lw      $16,28($sp)
        addiu   $sp,$sp,40
        j       $31
        nop				# RandomizaInicioBola - Fim

InicializaBola:				# InicializaBola - Início
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)
        move    $2,$6
        sb      $2,40($fp)
        lw      $2,32($fp)
        lw      $3,36($fp)
        nop
        sw      $3,0($2)
        lw      $4,32($fp)
        jal     RandomizaInicioBola
        nop

        lw      $2,32($fp)
        li      $3,1                	# 0x1
        sw      $3,8($2)
        lw      $2,32($fp)
        lbu     $3,40($fp)
        nop
        sb      $3,12($2)
        nop
        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        j       $31
        nop				# InicializaBola - Fim

PosicionaBola:				# PosicionaBola - Início
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        lw      $2,8($fp)
        nop
        lw      $5,4($2)
        lw      $2,8($fp)
        nop
        lw      $2,0($2)
        lw      $3,8($fp)
        nop
        lb      $3,12($3)
        lui     $4,%hi(Pong)
        sll     $5,$5,6
        addiu   $4,$4,%lo(Pong)
        addu    $4,$5,$4
        addu    $2,$4,$2
        sb      $3,0($2)
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop				# PosicionaBola - Fim

MovimentaBola:				# MovimentaBola - Início
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        sw      $5,12($fp)
        sw      $6,16($fp)
        lw      $2,8($fp)
        nop
        lw      $2,4($2)
        nop
        slt     $2,$2,2
        beq     $2,$0,$L19
        nop

        lw      $2,16($fp)
        nop
        lw      $2,0($2)
        nop
        subu    $3,$0,$2
        lw      $2,16($fp)
        nop
        sw      $3,0($2)
$L19:
        lw      $2,8($fp)
        nop
        lw      $2,4($2)
        nop
        slt     $2,$2,46
        bne     $2,$0,$L20
        nop

        lw      $2,16($fp)
        nop
        lw      $2,0($2)
        nop
        subu    $3,$0,$2
        lw      $2,16($fp)
        nop
        sw      $3,0($2)
$L20:
        lw      $2,8($fp)
        nop
        lw      $3,0($2)
        lw      $2,12($fp)
        nop
        lw      $2,0($2)
        nop
        addu    $3,$3,$2
        lw      $2,8($fp)
        nop
        sw      $3,0($2)
        lw      $2,8($fp)
        nop
        lw      $3,4($2)
        lw      $2,16($fp)
        nop
        lw      $2,0($2)
        nop
        addu    $3,$3,$2
        lw      $2,8($fp)
        nop
        sw      $3,4($2)
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop				# MovimentaBola - Fim

Rebate:					# Rebate - Início
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        sw      $5,12($fp)
        sw      $6,16($fp)
        lw      $2,12($fp)
        nop
        lw      $2,0($2)
        nop
        addiu   $3,$2,-1
        lw      $2,8($fp)
        nop
        lw      $2,0($2)
        nop
        bne     $3,$2,$L22
        nop

        lw      $2,12($fp)
        nop
        lw      $3,4($2)
        lw      $2,8($fp)
        nop
        lw      $4,4($2)
        lw      $2,8($fp)
        nop
        lw      $2,8($2)
        nop
        srl     $5,$2,31
        addu    $2,$5,$2
        sra     $2,$2,1
        addu    $2,$4,$2
        slt     $2,$2,$3
        bne     $2,$0,$L22
        nop

        lw      $2,12($fp)
        nop
        lw      $3,4($2)
        lw      $2,8($fp)
        nop
        lw      $4,4($2)
        lw      $2,8($fp)
        nop
        lw      $2,8($2)
        nop
        srl     $5,$2,31
        addu    $2,$5,$2
        sra     $2,$2,1
        subu    $2,$4,$2
        slt     $2,$3,$2
        bne     $2,$0,$L22
        nop

        lw      $2,16($fp)
        nop
        lw      $2,0($2)
        nop
        subu    $3,$0,$2
        lw      $2,16($fp)
        nop
        sw      $3,0($2)
$L22:
        lw      $2,12($fp)
        nop
        lw      $2,0($2)
        nop
        addiu   $3,$2,1
        lw      $2,8($fp)
        nop
        lw      $2,0($2)
        nop
        bne     $3,$2,$L24
        nop

        lw      $2,12($fp)
        nop
        lw      $3,4($2)
        lw      $2,8($fp)
        nop
        lw      $4,4($2)
        lw      $2,8($fp)
        nop
        lw      $2,8($2)
        nop
        srl     $5,$2,31
        addu    $2,$5,$2
        sra     $2,$2,1
        addu    $2,$4,$2
        slt     $2,$2,$3
        bne     $2,$0,$L24
        nop

        lw      $2,12($fp)
        nop
        lw      $3,4($2)
        lw      $2,8($fp)
        nop
        lw      $4,4($2)
        lw      $2,8($fp)
        nop
        lw      $2,8($2)
        nop
        srl     $5,$2,31
        addu    $2,$5,$2
        sra     $2,$2,1
        subu    $2,$4,$2
        slt     $2,$3,$2
        bne     $2,$0,$L24
        nop

        lw      $2,16($fp)
        nop
        lw      $2,0($2)
        nop
        subu    $3,$0,$2
        lw      $2,16($fp)
        nop
        sw      $3,0($2)
$L24:
        nop
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop				# Rebate - Fim

VerificaPontuacao:			# VerificaPontuacao - Início
        addiu   $sp,$sp,-8
        sw      $fp,4($sp)
        move    $fp,$sp
        sw      $4,8($fp)
        sw      $5,12($fp)
        sw      $6,16($fp)
        sw      $7,20($fp)
        lw      $2,8($fp)
        nop
        slt     $2,$2,63
        bne     $2,$0,$L26
        nop

        lw      $2,24($fp)
        nop
        lw      $2,0($2)
        nop
        addiu   $3,$2,1
        lw      $2,24($fp)
        nop
        sw      $3,0($2)
        li      $2,1       		# 0x1
        b       $L27
        nop

$L26:
        lw      $2,8($fp)
        nop
        bgtz    $2,$L28
        nop

        lw      $2,28($fp)
        nop
        lw      $2,0($2)
        nop
        addiu   $3,$2,1
        lw      $2,28($fp)
        nop
        sw      $3,0($2)
        li      $2,1     		# 0x1
        b       $L27
        nop

$L28:
        move    $2,$0
$L27:
        move    $sp,$fp
        lw      $fp,4($sp)
        addiu   $sp,$sp,8
        j       $31
        nop				# VerificaPontuacao - Início

$LC0:
        .ascii  "   JOGADOR 1: %.2d\011\011x\011\011JOGADOR 2: %.2d\012\000"
ImprimePontuacao:			# ImprimePontuacao - Início
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)
        lw      $6,36($fp)
        lw      $5,32($fp)
        lui     $2,%hi($LC0)
        addiu   $4,$2,%lo($LC0)
        jal     printf
        nop

        nop
        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        j       $31
        nop				# ImprimePontuacao - Fim

InicializaPong:				# InicializaPong - Início
        addiu   $sp,$sp,-24
        sw      $fp,20($sp)
        move    $fp,$sp
        sw      $0,8($fp)
        b       $L31
        nop

$L32:
        lui     $2,%hi(Pong)
        lw      $3,8($fp)
        nop
        sll     $3,$3,6
        addiu   $2,$2,%lo(Pong)
        addu    $2,$3,$2
        li      $3,124                  # 0x7c
        sb      $3,0($2)
        lui     $2,%hi(Pong)
        lw      $3,8($fp)
        nop
        sll     $3,$3,6
        addiu   $2,$2,%lo(Pong)
        addu    $2,$3,$2
        li      $3,124                  # 0x7c
        sb      $3,63($2)
        lw      $2,8($fp)
        nop
        addiu   $2,$2,1
        sw      $2,8($fp)
$L31:
        lw      $2,8($fp)
        nop
        slt     $2,$2,48
        bne     $2,$0,$L32
        nop

        sw      $0,8($fp)
        b       $L33
        nop

$L34:
        lui     $2,%hi(Pong)
        addiu   $3,$2,%lo(Pong)
        lw      $2,8($fp)
        nop
        addu    $2,$3,$2
        li      $3,61        		# 0x3d
        sb      $3,0($2)
        lui     $2,%hi(Pong)
        lw      $3,8($fp)
        addiu   $2,$2,%lo(Pong)
        addu    $2,$3,$2
        li      $3,61        		# 0x3d
        sb      $3,3008($2)
        lw      $2,8($fp)
        nop
        addiu   $2,$2,1
        sw      $2,8($fp)
$L33:
        lw      $2,8($fp)
        nop
        slt     $2,$2,64
        bne     $2,$0,$L34
        nop

        li      $2,1    		# 0x1
        sw      $2,8($fp)
        b       $L35
        nop

$L38:
        li      $2,1       		# 0x1
        sw      $2,12($fp)
        b       $L36
        nop

$L37:
        lui     $2,%hi(Pong)
        lw      $3,8($fp)
        nop
        sll     $3,$3,6
        addiu   $2,$2,%lo(Pong)
        addu    $3,$3,$2
        lw      $2,12($fp)
        nop
        addu    $2,$3,$2
        li      $3,32                 	# 0x20
        sb      $3,0($2)
        lw      $2,12($fp)
        nop
        addiu   $2,$2,1
        sw      $2,12($fp)
$L36:
        lw      $2,12($fp)
        nop
        slt     $2,$2,63
        bne     $2,$0,$L37
        nop

        lw      $2,8($fp)
        nop
        addiu   $2,$2,1
        sw      $2,8($fp)
$L35:
        lw      $2,8($fp)
        nop
        slt     $2,$2,47
        bne     $2,$0,$L38
        nop

        nop
        move    $sp,$fp
        lw      $fp,20($sp)
        addiu   $sp,$sp,24
        j       $31
        nop				# InicializaPong - Fim

AtualizaPong:				# AtualizaPong - Início
        addiu   $sp,$sp,-32
        sw      $31,28($sp)
        sw      $fp,24($sp)
        move    $fp,$sp
        sw      $4,32($fp)
        sw      $5,36($fp)
        sw      $6,40($fp)
        sw      $7,44($fp)
        jal     InicializaPong
        nop

        lw      $4,32($fp)
        lw      $5,36($fp)
        lw      $6,40($fp)
        lw      $7,44($fp)
        jal     PosicionaJogador
        nop

        lw      $4,48($fp)
        lw      $5,52($fp)
        lw      $6,56($fp)
        lw      $7,60($fp)
        jal     PosicionaJogador
        nop

        addiu   $2,$fp,64
        move    $4,$2
        jal     PosicionaBola
        nop

        nop
        move    $sp,$fp
        lw      $31,28($sp)
        lw      $fp,24($sp)
        addiu   $sp,$sp,32
        j       $31
        nop				# AtualizaPong - Fim

ImprimePong:				# ImprimePong - Início
        addiu   $sp,$sp,-40
        sw      $31,36($sp)
        sw      $fp,32($sp)
        move    $fp,$sp
        sw      $0,24($fp)
        b       $L41
        nop

$L44:
        sw      $0,28($fp)
        b       $L42
        nop

$L43:
        lui     $2,%hi(Pong)
        lw      $3,24($fp)
        nop
        sll     $3,$3,6
        addiu   $2,$2,%lo(Pong)
        addu    $3,$3,$2
        lw      $2,28($fp)
        nop
        addu    $2,$3,$2
        lb      $2,0($2)
        nop
        move    $4,$2
        jal     putchar
        nop

        lw      $2,28($fp)
        nop
        addiu   $2,$2,1
        sw      $2,28($fp)
$L42:
        lw      $2,28($fp)
        nop
        slt     $2,$2,64
        bne     $2,$0,$L43
        nop

        li      $4,10       		# 0xa
        jal     putchar
        nop

        lw      $2,24($fp)
        nop
        addiu   $2,$2,1
        sw      $2,24($fp)
$L41:
        lw      $2,24($fp)
        nop
        slt     $2,$2,48
        bne     $2,$0,$L44
        nop

        nop
        move    $sp,$fp
        lw      $31,36($sp)
        lw      $fp,32($sp)
        addiu   $sp,$sp,40
        j       $31
        nop				# ImprimePong - Fim

$LC1:
        .ascii  "\011\011\011PONG NO TERMINAL\000"
$LC2:
        .ascii  "\033c\000"
main:					# main - Início
        addiu   $sp,$sp,-136
        sw      $31,132($sp)
        sw      $fp,128($sp)
        move    $fp,$sp
        sw      $0,108($fp)
        sw      $0,116($fp)
        li      $2,1             	# 0x1
        sw      $2,120($fp)
        li      $2,1             	# 0x1
        sw      $2,124($fp)
        li      $6,93           	# 0x5d
        li      $5,1            	# 0x1
        addiu   $2,$fp,56
        move    $4,$2
        jal     InicializaJogador
        nop

        addiu   $2,$fp,72
        li      $6,91                 	# 0x5b
        li      $5,62                 	# 0x3e
        move    $4,$2
        jal     InicializaJogador
        nop

        addiu   $2,$fp,88
        li      $6,79                 	# 0x4f
        li      $5,32                 	# 0x20
        move    $4,$2
        jal     InicializaBola
        nop

        move    $4,$0
        jal     time
        nop

        move    $4,$2
        jal     srand
        nop

        jal     rand
        nop

        move    $3,$2
        li      $2,-2147483648		# 0xffffffff80000000
        ori     $2,$2,0x1
        and     $2,$3,$2
        bgez    $2,$L46
        nop

        addiu   $2,$2,-1
        li      $3,-2     		# 0xfffffffffffffffe
        or      $2,$2,$3
        addiu   $2,$2,1
$L46:
        sw      $2,104($fp)
        lw      $3,104($fp)
        li      $2,1       		# 0x1
        bne     $3,$2,$L47
        nop

        sw      $0,112($fp)
        b       $L48
        nop

$L47:
        li      $2,1         		# 0x1
        sw      $2,112($fp)
$L48:
        lui     $2,%hi($LC1)
        addiu   $4,$2,%lo($LC1)
        jal     puts
        nop

        lw      $5,88($fp)
        lw      $4,92($fp)
        lw      $3,96($fp)
        lw      $2,100($fp)
        sw      $5,32($sp)
        sw      $4,36($sp)
        sw      $3,40($sp)
        sw      $2,44($sp)
        lw      $5,72($fp)
        lw      $4,76($fp)
        lw      $3,80($fp)
        lw      $2,84($fp)
        sw      $5,16($sp)
        sw      $4,20($sp)
        sw      $3,24($sp)
        sw      $2,28($sp)
        lw      $4,56($fp)
        lw      $5,60($fp)
        lw      $6,64($fp)
        lw      $7,68($fp)
        jal     AtualizaPong		# Chamada da função AtualizaPong
        nop

        jal     ImprimePong		# Chamada da função ImprimePong
        nop

        lw      $2,108($fp)
        lw      $3,116($fp)
        nop
        move    $5,$3
        move    $4,$2
        jal     ImprimePontuacao	# Chamada da função ImprimePong
        nop

        addiu   $2,$fp,104
        sw      $2,16($sp)
        lw      $4,56($fp)
        lw      $5,60($fp)
        lw      $6,64($fp)
        lw      $7,68($fp)
        jal     EscolheMovimentoJogador	# Chamada da função EscolheMovimentoJogador
        nop

        addiu   $2,$fp,112
        sw      $2,16($sp)
        lw      $4,72($fp)
        lw      $5,76($fp)
        lw      $6,80($fp)
        lw      $7,84($fp)
        jal     EscolheMovimentoJogador 	# Chamada da função EscolheMovimentoJogador
        nop

        lw      $2,104($fp)
        nop
        move    $5,$2
        addiu   $2,$fp,56
        move    $4,$2
        jal     MovimentaJogador		# Chamada da função MovimentaJogador
        nop

        lw      $3,112($fp)
        addiu   $2,$fp,72
        move    $5,$3
        move    $4,$2
        jal     MovimentaJogador		# Chamada da função MovimentaJogador
        nop

        addiu   $4,$fp,124
        addiu   $3,$fp,120
        addiu   $2,$fp,88
        move    $6,$4
        move    $5,$3
        move    $4,$2
        jal     MovimentaBola		# Chamada da função MovimentaBola 		
        nop

        addiu   $2,$fp,116
        sw      $2,20($sp)
        addiu   $2,$fp,108
        sw      $2,16($sp)
        lw      $4,88($fp)
        lw      $5,92($fp)
        lw      $6,96($fp)
        lw      $7,100($fp)
        jal     VerificaPontuacao	# Chamada da função  VerificaPontuacao
        nop

        beq     $2,$0,$L49
        nop

        addiu   $2,$fp,88
        li      $6,79                 	# 0x4f
        li      $5,32                 	# 0x20
        move    $4,$2
        jal     InicializaBola		# Chamada da função InicializaBola
        nop

        lw      $2,120($fp)
        nop
        subu    $2,$0,$2
        sw      $2,120($fp)
$L49:
        addiu   $3,$fp,120
        addiu   $2,$fp,88
        move    $6,$3
        move    $5,$2
        addiu   $2,$fp,56
        move    $4,$2
        jal     Rebate			# Chamada da função Rebate
        nop

        addiu   $4,$fp,120
        addiu   $3,$fp,88
        addiu   $2,$fp,72
        move    $6,$4
        move    $5,$3
        move    $4,$2
        jal     Rebate			# Chamada da função Rebate
        nop

        li      $4,65000             	# 0xfde8
        jal     usleep
        nop

        lui     $2,%hi($LC2)
        addiu   $4,$2,%lo($LC2)
        jal     printf
        nop

        b       $L48
        nop				# main - Fim