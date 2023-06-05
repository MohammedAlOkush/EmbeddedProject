
_Move_Delay:

;FINaL.c,85 :: 		void Move_Delay() {                  // Function used for text moving
;FINaL.c,86 :: 		Delay_ms(500);                     // You can change the moving speed here
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_Move_Delay0:
	DECFSZ     R13+0, 1
	GOTO       L_Move_Delay0
	DECFSZ     R12+0, 1
	GOTO       L_Move_Delay0
	DECFSZ     R11+0, 1
	GOTO       L_Move_Delay0
	NOP
	NOP
;FINaL.c,87 :: 		}
L_end_Move_Delay:
	RETURN
; end of _Move_Delay

_main:

;FINaL.c,89 :: 		void main(){
;FINaL.c,90 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;FINaL.c,92 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,93 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,94 :: 		pwm_init();
	CALL       _pwm_init+0
;FINaL.c,95 :: 		TRISC=0x81; //rc7 & rc0 input rest out
	MOVLW      129
	MOVWF      TRISC+0
;FINaL.c,96 :: 		PORTC=0x00;
	CLRF       PORTC+0
;FINaL.c,97 :: 		TRISB = 0x0F;//keypad
	MOVLW      15
	MOVWF      TRISB+0
;FINaL.c,98 :: 		option_reg = option_reg&0x7F;//keypad   weak pullup
	MOVLW      127
	ANDWF      OPTION_REG+0, 1
;FINaL.c,99 :: 		set_servo_position(0);
	CLRF       FARG_set_servo_position_degrees+0
	CLRF       FARG_set_servo_position_degrees+1
	CALL       _set_servo_position+0
;FINaL.c,115 :: 		while(1) {
L_main1:
;FINaL.c,119 :: 		temp= (PORTC & 0x01);
	MOVLW      1
	ANDWF      PORTC+0, 0
	MOVWF      _temp+0
	CLRF       _temp+1
	MOVLW      0
	ANDWF      _temp+1, 1
	MOVLW      0
	MOVWF      _temp+1
;FINaL.c,122 :: 		while(!temp){ //if sensor on
L_main3:
	MOVF       _temp+0, 0
	IORWF      _temp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;FINaL.c,123 :: 		Lcd_Out(1,1,txt1);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,124 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;FINaL.c,125 :: 		Lcd_Out(1,1,txt2);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,126 :: 		while(!UART1_Data_Ready()); //Read from Bluetooth
L_main6:
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main7
	GOTO       L_main6
L_main7:
;FINaL.c,127 :: 		if (UART1_Data_Ready()){
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main8
;FINaL.c,128 :: 		IncData = UART1_Read();           //Store the received data in IncData
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _IncData+0
;FINaL.c,130 :: 		if ( IncData == '1') {            //If it received 1, check password
	MOVF       R0+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L_main9
;FINaL.c,131 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,132 :: 		Lcd_Out(1,1,txt3);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt3+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,133 :: 		Delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main10:
	DECFSZ     R13+0, 1
	GOTO       L_main10
	DECFSZ     R12+0, 1
	GOTO       L_main10
	DECFSZ     R11+0, 1
	GOTO       L_main10
	NOP
	NOP
;FINaL.c,134 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,135 :: 		Lcd_Out(1,1,txt4);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,136 :: 		for(i=0;i<5;i++)
	CLRF       _i+0
	CLRF       _i+1
L_main11:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main109
	MOVLW      5
	SUBWF      _i+0, 0
L__main109:
	BTFSC      STATUS+0, 0
	GOTO       L_main12
;FINaL.c,138 :: 		kp=key();
	CALL       _key+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;FINaL.c,139 :: 		pass[i]=kp;
	MOVF       _i+0, 0
	ADDLW      _pass+0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;FINaL.c,140 :: 		Lcd_Out(1,i,txt5);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,136 :: 		for(i=0;i<5;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;FINaL.c,141 :: 		}
	GOTO       L_main11
L_main12:
;FINaL.c,143 :: 		while(pass[1]!='1' || pass[2]!='2' && pass[3] != '3' && pass[4] !='4'){
L_main14:
	MOVF       _pass+1, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L__main94
	MOVF       _pass+2, 0
	XORLW      50
	BTFSC      STATUS+0, 2
	GOTO       L__main95
	MOVF       _pass+3, 0
	XORLW      51
	BTFSC      STATUS+0, 2
	GOTO       L__main95
	MOVF       _pass+4, 0
	XORLW      52
	BTFSC      STATUS+0, 2
	GOTO       L__main95
	GOTO       L__main94
L__main95:
	GOTO       L_main15
L__main94:
;FINaL.c,144 :: 		counter++;
	INCF       _counter+0, 1
	BTFSC      STATUS+0, 2
	INCF       _counter+1, 1
;FINaL.c,145 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,146 :: 		Lcd_Out(1,1,txt8);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt8+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,147 :: 		Lcd_Out(2,1,txt9);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt9+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,148 :: 		Delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
	NOP
;FINaL.c,149 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,150 :: 		Lcd_Out(1,1,txt4);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt4+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,151 :: 		if(counter ==3){
	MOVLW      0
	XORWF      _counter+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main110
	MOVLW      3
	XORWF      _counter+0, 0
L__main110:
	BTFSS      STATUS+0, 2
	GOTO       L_main21
;FINaL.c,153 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,154 :: 		Lcd_Out(2,1,txt10);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt10+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,155 :: 		buzz();
	CALL       _buzz+0
;FINaL.c,157 :: 		break;
	GOTO       L_main15
;FINaL.c,159 :: 		}
L_main21:
;FINaL.c,160 :: 		for(i=0;i<5;i++)
	CLRF       _i+0
	CLRF       _i+1
L_main22:
	MOVLW      0
	SUBWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main111
	MOVLW      5
	SUBWF      _i+0, 0
L__main111:
	BTFSC      STATUS+0, 0
	GOTO       L_main23
;FINaL.c,162 :: 		kp=key();
	CALL       _key+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
;FINaL.c,163 :: 		pass[i]=kp;
	MOVF       _i+0, 0
	ADDLW      _pass+0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;FINaL.c,164 :: 		Lcd_Out(1,i,txt5);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVF       _i+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt5+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,160 :: 		for(i=0;i<5;i++)
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;FINaL.c,165 :: 		}
	GOTO       L_main22
L_main23:
;FINaL.c,167 :: 		}
	GOTO       L_main14
L_main15:
;FINaL.c,170 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,172 :: 		Lcd_Out(1,1,txt7);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt7+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,173 :: 		Delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
	NOP
;FINaL.c,174 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,175 :: 		Lcd_Out(1,1,txt6);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt6+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,176 :: 		set_servo_position(90); //open door
	MOVLW      90
	MOVWF      FARG_set_servo_position_degrees+0
	MOVLW      0
	MOVWF      FARG_set_servo_position_degrees+1
	CALL       _set_servo_position+0
;FINaL.c,179 :: 		Delay_ms(4000);
	MOVLW      41
	MOVWF      R11+0
	MOVLW      150
	MOVWF      R12+0
	MOVLW      127
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	DECFSZ     R11+0, 1
	GOTO       L_main26
;FINaL.c,180 :: 		set_servo_position(0); //CLose door
	CLRF       FARG_set_servo_position_degrees+0
	CLRF       FARG_set_servo_position_degrees+1
	CALL       _set_servo_position+0
;FINaL.c,186 :: 		}
	GOTO       L_main27
L_main9:
;FINaL.c,187 :: 		else if ( IncData == '0'){
	MOVF       _IncData+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;FINaL.c,189 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;FINaL.c,191 :: 		Lcd_Out(1,1,txt11);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _txt11+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;FINaL.c,193 :: 		break;
	GOTO       L_main4
;FINaL.c,202 :: 		}
L_main28:
L_main27:
;FINaL.c,214 :: 		temp = (PORTC & 0x01);
	MOVLW      1
	ANDWF      PORTC+0, 0
	MOVWF      _temp+0
	CLRF       _temp+1
	MOVLW      0
	ANDWF      _temp+1, 1
	MOVLW      0
	MOVWF      _temp+1
;FINaL.c,216 :: 		}
L_main8:
;FINaL.c,219 :: 		}
	GOTO       L_main3
L_main4:
;FINaL.c,220 :: 		}
	GOTO       L_main1
;FINaL.c,221 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_key:

;FINaL.c,226 :: 		unsigned char key()
;FINaL.c,228 :: 		PORTB=0X00; //set all bits in PORTB to 0
	CLRF       PORTB+0
;FINaL.c,230 :: 		while(COL1&&COL2&&COL3&&COL4); //wait for a key press
L_key29:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_key30
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_key30
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_key30
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_key30
L__key106:
	GOTO       L_key29
L_key30:
;FINaL.c,233 :: 		while(!COL1||!COL2||!COL3||!COL4) { //is checking if any of the column pins (COL1, COL2, COL3) are low. This means that if any of the column pins are connected to a button that is being pressed, the loop will continue to execute.
L_key33:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__key105
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__key105
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__key105
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__key105
	GOTO       L_key34
L__key105:
;FINaL.c,235 :: 		ROW1=0;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;FINaL.c,236 :: 		ROW2=ROW3=ROW4=1;
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L__key113
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L__key114
L__key113:
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
L__key114:
	BTFSC      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L__key115
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L__key116
L__key115:
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
L__key116:
;FINaL.c,238 :: 		if(!COL1||!COL2||!COL3|!COL4) {
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__key104
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__key104
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__key117
	BSF        114, 0
	GOTO       L__key118
L__key117:
	BCF        114, 0
L__key118:
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__key119
	BSF        3, 0
	GOTO       L__key120
L__key119:
	BCF        3, 0
L__key120:
	BTFSC      114, 0
	GOTO       L__key121
	BTFSC      3, 0
	GOTO       L__key121
	BCF        114, 0
	GOTO       L__key122
L__key121:
	BSF        114, 0
L__key122:
	BTFSC      114, 0
	GOTO       L__key104
	GOTO       L_key39
L__key104:
;FINaL.c,239 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key40:
	DECFSZ     R13+0, 1
	GOTO       L_key40
	DECFSZ     R12+0, 1
	GOTO       L_key40
	DECFSZ     R11+0, 1
	GOTO       L_key40
	NOP
;FINaL.c,241 :: 		rownum=0;
	CLRF       _rownum+0
;FINaL.c,242 :: 		break;
	GOTO       L_key34
;FINaL.c,243 :: 		}
L_key39:
;FINaL.c,245 :: 		ROW2=0;ROW1=ROW3=ROW4=1;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L__key123
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L__key124
L__key123:
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
L__key124:
	BTFSC      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L__key125
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L__key126
L__key125:
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
L__key126:
;FINaL.c,247 :: 		if(!COL1||!COL2||!COL3|!COL4) {
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__key103
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__key103
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__key127
	BSF        114, 0
	GOTO       L__key128
L__key127:
	BCF        114, 0
L__key128:
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__key129
	BSF        3, 0
	GOTO       L__key130
L__key129:
	BCF        3, 0
L__key130:
	BTFSC      114, 0
	GOTO       L__key131
	BTFSC      3, 0
	GOTO       L__key131
	BCF        114, 0
	GOTO       L__key132
L__key131:
	BSF        114, 0
L__key132:
	BTFSC      114, 0
	GOTO       L__key103
	GOTO       L_key43
L__key103:
;FINaL.c,248 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key44:
	DECFSZ     R13+0, 1
	GOTO       L_key44
	DECFSZ     R12+0, 1
	GOTO       L_key44
	DECFSZ     R11+0, 1
	GOTO       L_key44
	NOP
;FINaL.c,250 :: 		rownum=1;
	MOVLW      1
	MOVWF      _rownum+0
;FINaL.c,251 :: 		break;
	GOTO       L_key34
;FINaL.c,252 :: 		}
L_key43:
;FINaL.c,254 :: 		ROW3=0;ROW2=ROW1=ROW4=1;
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
	BTFSC      RB7_bit+0, BitPos(RB7_bit+0)
	GOTO       L__key133
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L__key134
L__key133:
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
L__key134:
	BTFSC      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L__key135
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L__key136
L__key135:
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
L__key136:
;FINaL.c,256 :: 		if(!COL1||!COL2||!COL3|!COL4) {
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__key102
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__key102
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__key137
	BSF        114, 0
	GOTO       L__key138
L__key137:
	BCF        114, 0
L__key138:
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__key139
	BSF        3, 0
	GOTO       L__key140
L__key139:
	BCF        3, 0
L__key140:
	BTFSC      114, 0
	GOTO       L__key141
	BTFSC      3, 0
	GOTO       L__key141
	BCF        114, 0
	GOTO       L__key142
L__key141:
	BSF        114, 0
L__key142:
	BTFSC      114, 0
	GOTO       L__key102
	GOTO       L_key47
L__key102:
;FINaL.c,257 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key48:
	DECFSZ     R13+0, 1
	GOTO       L_key48
	DECFSZ     R12+0, 1
	GOTO       L_key48
	DECFSZ     R11+0, 1
	GOTO       L_key48
	NOP
;FINaL.c,259 :: 		rownum=2;
	MOVLW      2
	MOVWF      _rownum+0
;FINaL.c,260 :: 		break;
	GOTO       L_key34
;FINaL.c,261 :: 		}
L_key47:
;FINaL.c,263 :: 		ROW4=0; ROW1=ROW2=ROW3=1;
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
	BTFSC      RB6_bit+0, BitPos(RB6_bit+0)
	GOTO       L__key143
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L__key144
L__key143:
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
L__key144:
	BTFSC      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L__key145
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L__key146
L__key145:
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
L__key146:
;FINaL.c,265 :: 		if(!COL1||!COL2||!COL3|!COL4){
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__key101
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__key101
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__key147
	BSF        114, 0
	GOTO       L__key148
L__key147:
	BCF        114, 0
L__key148:
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__key149
	BSF        3, 0
	GOTO       L__key150
L__key149:
	BCF        3, 0
L__key150:
	BTFSC      114, 0
	GOTO       L__key151
	BTFSC      3, 0
	GOTO       L__key151
	BCF        114, 0
	GOTO       L__key152
L__key151:
	BSF        114, 0
L__key152:
	BTFSC      114, 0
	GOTO       L__key101
	GOTO       L_key51
L__key101:
;FINaL.c,266 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key52:
	DECFSZ     R13+0, 1
	GOTO       L_key52
	DECFSZ     R12+0, 1
	GOTO       L_key52
	DECFSZ     R11+0, 1
	GOTO       L_key52
	NOP
;FINaL.c,268 :: 		rownum=3;
	MOVLW      3
	MOVWF      _rownum+0
;FINaL.c,269 :: 		break;
	GOTO       L_key34
;FINaL.c,270 :: 		}
L_key51:
;FINaL.c,271 :: 		}
	GOTO       L_key33
L_key34:
;FINaL.c,274 :: 		if(COL1==0&&COL2!=0&&COL3!=0&&COL4!=0)//if COL1 is pressed
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_key55
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_key55
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_key55
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_key55
L__key100:
;FINaL.c,276 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key56:
	DECFSZ     R13+0, 1
	GOTO       L_key56
	DECFSZ     R12+0, 1
	GOTO       L_key56
	DECFSZ     R11+0, 1
	GOTO       L_key56
	NOP
;FINaL.c,278 :: 		colnum=0;
	CLRF       _colnum+0
;FINaL.c,279 :: 		}
	GOTO       L_key57
L_key55:
;FINaL.c,280 :: 		else if(COL1!=0&&COL2==0&&COL3!=0&&COL4!=0)//if COL2 is pressed
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_key60
	BTFSC      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_key60
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_key60
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_key60
L__key99:
;FINaL.c,282 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key61:
	DECFSZ     R13+0, 1
	GOTO       L_key61
	DECFSZ     R12+0, 1
	GOTO       L_key61
	DECFSZ     R11+0, 1
	GOTO       L_key61
	NOP
;FINaL.c,284 :: 		colnum=1;
	MOVLW      1
	MOVWF      _colnum+0
;FINaL.c,285 :: 		}
	GOTO       L_key62
L_key60:
;FINaL.c,286 :: 		else if(COL1!=0&&COL2!=0&&COL3==0&&COL4!=0)//if COL3 is pressed
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_key65
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_key65
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_key65
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_key65
L__key98:
;FINaL.c,288 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key66:
	DECFSZ     R13+0, 1
	GOTO       L_key66
	DECFSZ     R12+0, 1
	GOTO       L_key66
	DECFSZ     R11+0, 1
	GOTO       L_key66
	NOP
;FINaL.c,290 :: 		colnum=2;
	MOVLW      2
	MOVWF      _colnum+0
;FINaL.c,291 :: 		}
	GOTO       L_key67
L_key65:
;FINaL.c,292 :: 		else if(COL1!=0&&COL2!=0&&COL3!=0&&COL4==0)//if COL3 is pressed
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_key70
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L_key70
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L_key70
	BTFSC      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L_key70
L__key97:
;FINaL.c,294 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_key71:
	DECFSZ     R13+0, 1
	GOTO       L_key71
	DECFSZ     R12+0, 1
	GOTO       L_key71
	DECFSZ     R11+0, 1
	GOTO       L_key71
	NOP
;FINaL.c,296 :: 		colnum=4;
	MOVLW      4
	MOVWF      _colnum+0
;FINaL.c,297 :: 		}
L_key70:
L_key67:
L_key62:
L_key57:
;FINaL.c,300 :: 		while(COL1==0||COL2==0||COL3==0||COL4==0);//to prevent from debouncing to filter out unwanted signals and ensure that only one button press is registered.
L_key72:
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L__key96
	BTFSS      RB1_bit+0, BitPos(RB1_bit+0)
	GOTO       L__key96
	BTFSS      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__key96
	BTFSS      RB3_bit+0, BitPos(RB3_bit+0)
	GOTO       L__key96
	GOTO       L_key73
L__key96:
	GOTO       L_key72
L_key73:
;FINaL.c,302 :: 		return (keypad[rownum][colnum]);
	MOVF       _rownum+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVLW      _keypad+0
	ADDWF      R0+0, 1
	MOVF       _colnum+0, 0
	ADDWF      R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
;FINaL.c,303 :: 		}
L_end_key:
	RETURN
; end of _key

_pwm_init:

;FINaL.c,308 :: 		void pwm_init() {
;FINaL.c,309 :: 		TRISC= TRISC & 0xF9;
	MOVLW      249
	ANDWF      TRISC+0, 1
;FINaL.c,311 :: 		CCP1CON= 0x0C;
	MOVLW      12
	MOVWF      CCP1CON+0
;FINaL.c,312 :: 		CCP2CON =0x0C;
	MOVLW      12
	MOVWF      CCP2CON+0
;FINaL.c,313 :: 		T2CON =T2CON |0x07;
	MOVLW      7
	IORWF      T2CON+0, 1
;FINaL.c,314 :: 		PR2= 249;
	MOVLW      249
	MOVWF      PR2+0
;FINaL.c,315 :: 		}
L_end_pwm_init:
	RETURN
; end of _pwm_init

_delay:

;FINaL.c,317 :: 		void delay(unsigned int count){
;FINaL.c,318 :: 		cntr = 0;
	CLRF       _cntr+0
	CLRF       _cntr+1
;FINaL.c,319 :: 		while(cntr < count);
L_delay76:
	MOVF       FARG_delay_count+1, 0
	SUBWF      _cntr+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay155
	MOVF       FARG_delay_count+0, 0
	SUBWF      _cntr+0, 0
L__delay155:
	BTFSC      STATUS+0, 0
	GOTO       L_delay77
	GOTO       L_delay76
L_delay77:
;FINaL.c,320 :: 		}
L_end_delay:
	RETURN
; end of _delay

_Delay_us:

;FINaL.c,321 :: 		void Delay_us(unsigned int microseconds) {
;FINaL.c,324 :: 		while (microseconds--) {
L_Delay_us78:
	MOVF       FARG_Delay_us_microseconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_Delay_us_microseconds+1, 0
	MOVWF      R0+1
	MOVLW      1
	SUBWF      FARG_Delay_us_microseconds+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_Delay_us_microseconds+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Delay_us79
;FINaL.c,325 :: 		for (i = 0; i < 12; i++) {
	CLRF       R2+0
	CLRF       R2+1
L_Delay_us80:
	MOVLW      0
	SUBWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Delay_us157
	MOVLW      12
	SUBWF      R2+0, 0
L__Delay_us157:
	BTFSC      STATUS+0, 0
	GOTO       L_Delay_us81
;FINaL.c,326 :: 		asm nop;
	NOP
;FINaL.c,325 :: 		for (i = 0; i < 12; i++) {
	INCF       R2+0, 1
	BTFSC      STATUS+0, 2
	INCF       R2+1, 1
;FINaL.c,327 :: 		}
	GOTO       L_Delay_us80
L_Delay_us81:
;FINaL.c,328 :: 		}
	GOTO       L_Delay_us78
L_Delay_us79:
;FINaL.c,329 :: 		}
L_end_Delay_us:
	RETURN
; end of _Delay_us

_Delay_ms:

;FINaL.c,331 :: 		void Delay_ms(unsigned int milliseconds) {
;FINaL.c,334 :: 		while (milliseconds--) {
L_Delay_ms83:
	MOVF       FARG_Delay_ms_milliseconds+0, 0
	MOVWF      R0+0
	MOVF       FARG_Delay_ms_milliseconds+1, 0
	MOVWF      R0+1
	MOVLW      1
	SUBWF      FARG_Delay_ms_milliseconds+0, 1
	BTFSS      STATUS+0, 0
	DECF       FARG_Delay_ms_milliseconds+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Delay_ms84
;FINaL.c,335 :: 		for (i = 0; i < 238; i++) {
	CLRF       R2+0
	CLRF       R2+1
L_Delay_ms85:
	MOVLW      0
	SUBWF      R2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Delay_ms159
	MOVLW      238
	SUBWF      R2+0, 0
L__Delay_ms159:
	BTFSC      STATUS+0, 0
	GOTO       L_Delay_ms86
;FINaL.c,336 :: 		Delay_us(1000);
	MOVLW      3
	MOVWF      R12+0
	MOVLW      151
	MOVWF      R13+0
L_Delay_ms88:
	DECFSZ     R13+0, 1
	GOTO       L_Delay_ms88
	DECFSZ     R12+0, 1
	GOTO       L_Delay_ms88
	NOP
	NOP
;FINaL.c,335 :: 		for (i = 0; i < 238; i++) {
	INCF       R2+0, 1
	BTFSC      STATUS+0, 2
	INCF       R2+1, 1
;FINaL.c,337 :: 		}
	GOTO       L_Delay_ms85
L_Delay_ms86:
;FINaL.c,338 :: 		}
	GOTO       L_Delay_ms83
L_Delay_ms84:
;FINaL.c,339 :: 		}
L_end_Delay_ms:
	RETURN
; end of _Delay_ms

_set_servo_position:

;FINaL.c,341 :: 		void set_servo_position(int degrees) {
;FINaL.c,342 :: 		int pulse_width = (degrees + 90) * 8 + 500; // Calculate pulse width (500 to 2400)
	MOVLW      90
	ADDWF      FARG_set_servo_position_degrees+0, 0
	MOVWF      R3+0
	MOVF       FARG_set_servo_position_degrees+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R3+1
	MOVLW      3
	MOVWF      R2+0
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__set_servo_position161:
	BTFSC      STATUS+0, 2
	GOTO       L__set_servo_position162
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__set_servo_position161
L__set_servo_position162:
	MOVLW      244
	ADDWF      R0+0, 0
	MOVWF      R3+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDLW      1
	MOVWF      R3+1
;FINaL.c,343 :: 		CCPR1L = pulse_width >> 2; // Set CCPR1L register
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	RRF        R0+1, 1
	RRF        R0+0, 1
	BCF        R0+1, 7
	BTFSC      R0+1, 6
	BSF        R0+1, 7
	MOVF       R0+0, 0
	MOVWF      CCPR1L+0
;FINaL.c,344 :: 		CCP1CON = (CCP1CON & 0xCF) | ((pulse_width & 0x03) << 4); // Set CCP1CON register
	MOVLW      207
	ANDWF      CCP1CON+0, 0
	MOVWF      R5+0
	MOVLW      3
	ANDWF      R3+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	IORWF      R5+0, 0
	MOVWF      CCP1CON+0
;FINaL.c,345 :: 		Delay_ms(50*4); // Delay for the servo to reach the desired position
	MOVLW      3
	MOVWF      R11+0
	MOVLW      8
	MOVWF      R12+0
	MOVLW      119
	MOVWF      R13+0
L_set_servo_position89:
	DECFSZ     R13+0, 1
	GOTO       L_set_servo_position89
	DECFSZ     R12+0, 1
	GOTO       L_set_servo_position89
	DECFSZ     R11+0, 1
	GOTO       L_set_servo_position89
;FINaL.c,346 :: 		}
L_end_set_servo_position:
	RETURN
; end of _set_servo_position

_buzz:

;FINaL.c,347 :: 		void buzz(){
;FINaL.c,348 :: 		counter=5;
	MOVLW      5
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;FINaL.c,349 :: 		while(counter >0){
L_buzz90:
	MOVF       _counter+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__buzz164
	MOVF       _counter+0, 0
	SUBLW      0
L__buzz164:
	BTFSC      STATUS+0, 0
	GOTO       L_buzz91
;FINaL.c,350 :: 		PORTC =PORTC| 0x02; //buzzer on
	BSF        PORTC+0, 1
;FINaL.c,351 :: 		Delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_buzz92:
	DECFSZ     R13+0, 1
	GOTO       L_buzz92
	DECFSZ     R12+0, 1
	GOTO       L_buzz92
	DECFSZ     R11+0, 1
	GOTO       L_buzz92
	NOP
;FINaL.c,352 :: 		PORTC =PORTC & 0xFD; //buzzer off
	MOVLW      253
	ANDWF      PORTC+0, 1
;FINaL.c,353 :: 		Delay_ms(50);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_buzz93:
	DECFSZ     R13+0, 1
	GOTO       L_buzz93
	DECFSZ     R12+0, 1
	GOTO       L_buzz93
	NOP
	NOP
;FINaL.c,355 :: 		counter --;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;FINaL.c,357 :: 		}
	GOTO       L_buzz90
L_buzz91:
;FINaL.c,361 :: 		}
L_end_buzz:
	RETURN
; end of _buzz
