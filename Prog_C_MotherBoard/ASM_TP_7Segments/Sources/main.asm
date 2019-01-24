;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            XREF MCU_init

; export symbols
            XDEF _Startup, main
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on
            
            
            
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack


; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition
								; $60,$61 : adresse 16 bits du maintient de l'affichage
								; $62 : adresse 8 bits de compteur du premier afficheur
								; $63 : adresse 8 bits de compteur du deuxième afficheur
; code section
MyCode:     SECTION
main:
_Startup:
            LDHX   #__SEG_END_SSTACK ; initialize the stack pointer
            TXS
			; Call generated device initialization function
			JSR    MCU_init

mainLoop:
            MOV		#$FF,PTCDD
            MOV		#$FF,PTBDD
Restart     CLR		$62
            CLR		$63
            CLR		$64
            CLRH
Retour      MOV		#$29,$60
maintient   LDX     $62
			LDA		$F000,X
			STA		PTBD
			JSR		TR1
FinTR1		LDX		$63
			LDA		$F000,X
			STA		PTBD
			JSR		TR2
FinTR2		CMP		#$00
			LDA		$60
			DECA	
			STA		$60
			LDA		$64
			BEQ		START
			MOV		#$01,$60
START		LDA		$60
			BNE		maintient
			LDA		$64
			LDA		$62            
            INCA
            STA		$62
            CMP		#$0A
            BNE		Retour
            CLR 	$62
            LDA		$63
            INCA
            STA		$63
            CMP		#$0A
            BNE		Retour
            BRA     Restart      
            
TR1:  		MOV		#$02,PTCD
			JSR		Delai
			RTS

TR2:        MOV		#$10,PTCD
            JSR		Delai
			RTS

Delai:      LDHX	#$1869
R1			AIX		#-1
			CPHX	#$0000
			BNE		R1
			ADC		$60
			RTS

			ORG		$F000
			FCB		$C0,$F9,$A4,$B0,$99,$92,$82,$F8,$80,$90 ; Code héxa des chiffre 0 à 9.	
