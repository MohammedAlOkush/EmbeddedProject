#line 1 "C:/Users/fawaz/OneDrive/Desktop/yazan/Final Project/FINaL.c"
#line 15 "C:/Users/fawaz/OneDrive/Desktop/yazan/Final Project/FINaL.c"
 unsigned char key();
 unsigned char keypad[4][4]={{'1','2','3','A'},{'4','5','6','B'},{'7','8','9','C'},{'*','0','#','D'}};
 unsigned char rownum,colnum;




 unsigned char Sel;
 unsigned char Selkey[2];



 char pass[4];
 char inputpass[4];
 unsigned char kp;
 unsigned char ki;

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
unsigned char HL;
unsigned char flag;
unsigned int tick,i;
unsigned int T1overflow;
unsigned long T1counts;
unsigned long T1time;
unsigned long Distance;
unsigned int Kcntr;
unsigned int temp;
unsigned int count;
unsigned int counter=0;

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



void Move_Delay() {
 Delay_ms(500);
}

void main(){
 Lcd_Init();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 pwm_init();
 TRISC=0x81;
 PORTC=0x00;
 TRISB = 0x0F;
 option_reg = option_reg&0x7F;
 set_servo_position(0);
#line 115 "C:/Users/fawaz/OneDrive/Desktop/yazan/Final Project/FINaL.c"
 while(1) {



 temp= (PORTC & 0x01);


 while(!temp){
 Lcd_Out(1,1,txt1);
 Delay_ms(1000);
 Lcd_Out(1,1,txt2);
 while(!UART1_Data_Ready());
 if (UART1_Data_Ready()){
 IncData = UART1_Read();

 if ( IncData == '1') {
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
 set_servo_position(90);


 Delay_ms(4000);
 set_servo_position(0);





 }
 else if ( IncData == '0'){

 Lcd_Cmd(_LCD_CLEAR);

 Lcd_Out(1,1,txt11);

 break;








 }
#line 214 "C:/Users/fawaz/OneDrive/Desktop/yazan/Final Project/FINaL.c"
 temp = (PORTC & 0x01);

 }


 }
}
}




unsigned char key()
{
 PORTB=0X00;

 while( RB0_bit && RB1_bit && RB2_bit && RB3_bit );


 while(! RB0_bit ||! RB1_bit ||! RB2_bit ||! RB3_bit ) {

  RB4_bit =0;
  RB5_bit = RB6_bit = RB7_bit =1;

 if(! RB0_bit ||! RB1_bit ||! RB2_bit |! RB3_bit ) {
 Delay_ms(100);

 rownum=0;
 break;
 }

  RB5_bit =0; RB4_bit = RB6_bit = RB7_bit =1;

 if(! RB0_bit ||! RB1_bit ||! RB2_bit |! RB3_bit ) {
 Delay_ms(100);

 rownum=1;
 break;
 }

  RB6_bit =0; RB5_bit = RB4_bit = RB7_bit =1;

 if(! RB0_bit ||! RB1_bit ||! RB2_bit |! RB3_bit ) {
 Delay_ms(100);

 rownum=2;
 break;
 }

  RB7_bit =0;  RB4_bit = RB5_bit = RB6_bit =1;

 if(! RB0_bit ||! RB1_bit ||! RB2_bit |! RB3_bit ){
 Delay_ms(100);

 rownum=3;
 break;
 }
}


 if( RB0_bit ==0&& RB1_bit !=0&& RB2_bit !=0&& RB3_bit !=0)
 {
 Delay_ms(100);

 colnum=0;
 }
 else if( RB0_bit !=0&& RB1_bit ==0&& RB2_bit !=0&& RB3_bit !=0)
 {
 Delay_ms(100);

 colnum=1;
 }
 else if( RB0_bit !=0&& RB1_bit !=0&& RB2_bit ==0&& RB3_bit !=0)
 {
 Delay_ms(100);

 colnum=2;
 }
 else if( RB0_bit !=0&& RB1_bit !=0&& RB2_bit !=0&& RB3_bit ==0)
 {
 Delay_ms(100);

 colnum=4;
 }


 while( RB0_bit ==0|| RB1_bit ==0|| RB2_bit ==0|| RB3_bit ==0);

 return (keypad[rownum][colnum]);
}




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
 int pulse_width = (degrees + 90) * 8 + 500;
 CCPR1L = pulse_width >> 2;
 CCP1CON = (CCP1CON & 0xCF) | ((pulse_width & 0x03) << 4);
 Delay_ms(50*4);
}
void buzz(){
 counter=5;
 while(counter >0){
 PORTC =PORTC| 0x02;
 Delay_ms(100);
 PORTC =PORTC & 0xFD;
 Delay_ms(50);

 counter --;

 }



}
