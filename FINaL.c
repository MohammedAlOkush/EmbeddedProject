// Start Keypad module connections
      #define ROW1 RB4_bit
      #define ROW2 RB5_bit
      #define ROW3 RB6_bit
      #define ROW4 RB7_bit
      #define COL1 RB0_bit
      #define COL2 RB1_bit
      #define COL3 RB2_bit
      #define COL4 RB3_bit
      // End Keypad module connections


      //Keypad functions

      unsigned char key();
      unsigned char keypad[4][4]={{'1','2','3','A'},{'4','5','6','B'},{'7','8','9','C'},{'*','0','#','D'}};
      unsigned char rownum,colnum;
      //End of Keypad functions


      //start of keypad  variables
      unsigned char Sel;//3Decimal points
      unsigned char Selkey[2];
      #define PASSWORD_LENGTH 4 //for setting the password
      //char password[PASSWORD_LENGTH] = '0000';  //set to be four

      char pass[4];
      char inputpass[4];
      unsigned char kp;
      unsigned char ki;
      //end of keypad variables
void pwm_init();
void Delay_ms(unsigned int milliseconds);
void Delay_us(unsigned int microseconds);
void set_servo_position(int degrees);
void buzz();
unsigned int k;
char IncData;
char opt;
unsigned int angle;
unsigned int cntr=0;
unsigned int cc;
unsigned int Dcntr;
unsigned char HL;//High Low
unsigned char flag;
unsigned int tick,i;
unsigned int T1overflow;
unsigned long T1counts;
unsigned long T1time;
unsigned long Distance;
unsigned int Kcntr;
unsigned int temp; //to check ir
unsigned int count;
unsigned int counter=0; // check incorrect attempts
//LCD                                                                                // LCD module connections
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4 at RD3_bit;
sbit LCD_D5 at RD4_bit;
sbit LCD_D6 at RD5_bit;
sbit LCD_D7 at RD6_bit;

sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD3_bit;
sbit LCD_D5_Direction at TRISD4_bit;
sbit LCD_D6_Direction at TRISD5_bit;
sbit LCD_D7_Direction at TRISD6_bit;
// End LCD module connections

char txt1[] = "WELCOME!!";
char txt2[] = "CHECKING ID...";
char txt3[] = "VERIFIED";
char txt4[] = "ENTER PASSWORD:";
char txt5[] = "*";
char txt6[] = "OPENING DOOR";
char txt7[] = "CORRECT" ;
char txt8[] = "INCORRECT";
char txt9[] = "TRY AGAIN" ;
char txt10[] = "HACKER DETECTED" ;
char txt11[] = "NOT VERIFIED";

                             // Loop variable

void Move_Delay() {                  // Function used for text moving
  Delay_ms(500);                     // You can change the moving speed here
}

void main(){
  Lcd_Init();                        // Initialize LCD

  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  pwm_init();
  TRISC=0x81; //rc7 & rc0 input rest out
  PORTC=0x00;
  TRISB = 0x0F;//keypad
  option_reg = option_reg&0x7F;//keypad   weak pullup
  set_servo_position(0);



                  // Write text in second row




 /*
  // Moving text
  for(i=0; i<4; i++) {               // Move text to the right 4 times
    Lcd_Cmd(_LCD_SHIFT_RIGHT);
    Move_Delay();
  } */

  while(1) {



             temp= (PORTC & 0x01);


        while(!temp){ //if sensor on
              Lcd_Out(1,1,txt1);
              Delay_ms(1000);
              Lcd_Out(1,1,txt2);
              while(!UART1_Data_Ready()); //Read from Bluetooth
              if (UART1_Data_Ready()){
              IncData = UART1_Read();           //Store the received data in IncData

              if ( IncData == '1') {            //If it received 1, check password
                  Lcd_Cmd(_LCD_CLEAR);
                  Lcd_Out(1,1,txt3);
                  Delay_ms(1500);
                  Lcd_Cmd(_LCD_CLEAR);
                  Lcd_Out(1,1,txt4);
                  for(i=0;i<5;i++)
                      {
                         kp=key();
                         pass[i]=kp;
                         Lcd_Out(1,i,txt5);
                         }

                   while(pass[1]!='1' || pass[2]!='2' && pass[3] != '3' && pass[4] !='4'){
                        counter++;
                        Lcd_Cmd(_LCD_CLEAR);
                        Lcd_Out(1,1,txt8);
                        Lcd_Out(2,1,txt9);
                        Delay_ms(1000);
                        Lcd_Cmd(_LCD_CLEAR);
                        Lcd_Out(1,1,txt4);
                        if(counter ==3){

                            Lcd_Cmd(_LCD_CLEAR);
                            Lcd_Out(2,1,txt10);
                            buzz();

                            break;

                        }
                        for(i=0;i<5;i++)
                        {
                         kp=key();
                         pass[i]=kp;
                         Lcd_Out(1,i,txt5);
                         }

                        }


                        Lcd_Cmd(_LCD_CLEAR);

                        Lcd_Out(1,1,txt7);
                        Delay_ms(1500);
                        Lcd_Cmd(_LCD_CLEAR);
                        Lcd_Out(1,1,txt6);
                        set_servo_position(90); //open door


                        Delay_ms(4000);
                        set_servo_position(0); //CLose door





                  }
                  else if ( IncData == '0'){

                             Lcd_Cmd(_LCD_CLEAR);

                             Lcd_Out(1,1,txt11);

                             break;








                  }


                                            //Clear Display








              temp = (PORTC & 0x01);

     }
     //==================

     }
}
}


//Start of keypad

unsigned char key()
{
    PORTB=0X00; //set all bits in PORTB to 0

    while(COL1&&COL2&&COL3&&COL4); //wait for a key press

    //scan the keypad for a specific key press
    while(!COL1||!COL2||!COL3||!COL4) { //is checking if any of the column pins (COL1, COL2, COL3) are low. This means that if any of the column pins are connected to a button that is being pressed, the loop will continue to execute.
        //set ROW1 to 0, ROW2, ROW3, ROW4 to 1
        ROW1=0;
        ROW2=ROW3=ROW4=1;
        //check if a key press is detected on ROW1
        if(!COL1||!COL2||!COL3|!COL4) {
        Delay_ms(100);
            //set rownum to indicate key press on ROW1
            rownum=0;
            break;
        }
        //set ROW2 to 0, ROW1, ROW3, ROW4 to 1
        ROW2=0;ROW1=ROW3=ROW4=1;
        //check if a key press is detected on ROW2
        if(!COL1||!COL2||!COL3|!COL4) {
        Delay_ms(100);
            //set rownum to indicate key press on ROW2
            rownum=1;
            break;
        }
        //set ROW3 to 0, ROW1, ROW2, ROW4 to 1
        ROW3=0;ROW2=ROW1=ROW4=1;
        //check if a key press is detected on ROW3
        if(!COL1||!COL2||!COL3|!COL4) {
        Delay_ms(100);
            //set rownum to indicate key press on ROW3
            rownum=2;
            break;
        }
        //set ROW4 to 0, ROW1, ROW2, ROW3 to 1
        ROW4=0; ROW1=ROW2=ROW3=1;
        //check if a key press is detected on ROW4
        if(!COL1||!COL2||!COL3|!COL4){
        Delay_ms(100);
            //set rownum to indicate key press on ROW4
            rownum=3;
            break;
        }
}

    //check which column the key press was detected on
    if(COL1==0&&COL2!=0&&COL3!=0&&COL4!=0)//if COL1 is pressed
    {
            Delay_ms(100);
            //set colnum to indicate key press on COL1
            colnum=0;
    }
    else if(COL1!=0&&COL2==0&&COL3!=0&&COL4!=0)//if COL2 is pressed
    {
            Delay_ms(100);
            //set colnum to indicate key press on COL2
            colnum=1;
    }
    else if(COL1!=0&&COL2!=0&&COL3==0&&COL4!=0)//if COL3 is pressed
    {
            Delay_ms(100);
            //set colnum to indicate key press on COL3
            colnum=2;
    }
    else if(COL1!=0&&COL2!=0&&COL3!=0&&COL4==0)//if COL3 is pressed
    {
            Delay_ms(100);
            //set colnum to indicate key press on COL4
            colnum=4;
    }

    //wait for key press to be released
    while(COL1==0||COL2==0||COL3==0||COL4==0);//to prevent from debouncing to filter out unwanted signals and ensure that only one button press is registered.
    //return the value of the keypad at the position indicated by the rownum and colnum variables
    return (keypad[rownum][colnum]);
}
//END of keypad


 //pwm for servo
void pwm_init() {
    TRISC= TRISC & 0xF9;

    CCP1CON= 0x0C;
    CCP2CON =0x0C;
    T2CON =T2CON |0x07;
    PR2= 249;
}

void delay(unsigned int count){
     cntr = 0;
     while(cntr < count);
}
void Delay_us(unsigned int microseconds) {
    unsigned int i;

    while (microseconds--) {
        for (i = 0; i < 12; i++) {
            asm nop;
        }
    }
}

void Delay_ms(unsigned int milliseconds) {
    unsigned int i;

    while (milliseconds--) {
        for (i = 0; i < 238; i++) {
            Delay_us(1000);
        }
    }
}

void set_servo_position(int degrees) {
    int pulse_width = (degrees + 90) * 8 + 500; // Calculate pulse width (500 to 2400)
    CCPR1L = pulse_width >> 2; // Set CCPR1L register
    CCP1CON = (CCP1CON & 0xCF) | ((pulse_width & 0x03) << 4); // Set CCP1CON register
    Delay_ms(50*4); // Delay for the servo to reach the desired position
}
void buzz(){
   counter=5;
                        while(counter >0){
                            PORTC =PORTC| 0x02; //buzzer on
                            Delay_ms(100);
                            PORTC =PORTC & 0xFD; //buzzer off
                            Delay_ms(50);

                            counter --;

                            }



}