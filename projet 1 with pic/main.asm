    LIST	p = 18F45K22, r = dec	;  D�finition du �C utilis�
    #include    <p18f45k22.inc>		;  D�finition des registres SFR et leurs bits
    #include    <config.inc>		;  Configuration des registres hardwares
    #include	<Temporisation.inc>	;  Contient les 3 sous programmes de temporisations suivantes: 
					;	TempoNx1ms   = Nx1ms	(La variable Nx est d�j� d�clar�e)
					; 	TempoNx10ms  = Nx10ms	(La variable Nx est d�j� d�clar�e)
					; 	TempoNx100ms = Nx100ms	(La variable Nx est d�j� d�clar�e)

;*******************************************************************************
;*			D�finition des Symboles avec EQU
;*******************************************************************************
					

;*******************************************************************************
;*			R�servation des variables avec res
;*******************************************************************************
uDataAccess udata_acs	0x00	; Adresse de uDataAccess = 0x00 (access page)

 
uDataPage   udata	0x100	; Adresse de uDataPage = 0x100 (no access page)

;*******************************************************************************
;*			VECTEURS D'INTERRUPTIONS:
;*******************************************************************************					
	    ORG	    0x0000	    ; Adresse de d�part apr�s le RESET
	    GOTO    main
;*******************************************************************************
;*			PROGRAMME PRINCIPAL:
;*******************************************************************************
	    ORG	    0x0100	    ; Adresse programme principale
main:	
	    CALL    Init_Ports
Eteindre: 
	    BCF	    LATB, RB0	    ; Eteindre la LED
TestAppuis:
	    BTFSS   PORTB, RB1	    ; On saute l'instruction suivante si RB1 = 1
	    GOTO    TestAppuis
Allume:
	    BSF	    LATB, RB0	    ; Allume la LED pendant 1 sec
	    MOVLW   10
	    MOVWF   Nx
	    CALL    TempoNx100ms    ; Tempo = Nx100ms = 10 x 100 ms = 1000 ms = 1 sec
	    GOTO    Eteindre

;*******************************************************************************
;*			SOUS PROGRAMMES:
;*******************************************************************************
Init_Ports:			    ; Sous programme d�initialisation des ports
	    MOVLB   15		    ; BSR = 15 = 0Fh (BSR pointe la page 15)
	    CLRF    ANSELB,1	    ; Port B configur� en E/S num�rique						
	    CLRF    LATB		
	    CLRF    PORTB						
	    MOVLW   b'00000010'	    ; RB7:RB2 et RB0 en sortie, RB1 en entr�e						
	    MOVWF   TRISB												
	    RETURN

	    END
