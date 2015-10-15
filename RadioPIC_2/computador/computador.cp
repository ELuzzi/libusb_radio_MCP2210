#line 1 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
#line 117 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
sbit CS2 at LATC0_bit;
sbit RST at LATC1_bit;
sbit INT at RC6_bit;
sbit WAKE at LATC2_bit;

sbit CS2_Direction at TRISC0_bit;
sbit RST_Direction at TRISC1_bit;
sbit INT_Direction at TRISC6_bit;
sbit WAKE_Direction at TRISC2_bit;

sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;

sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;

sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;

const unsigned short int DATA_LENGHT = 5;
const unsigned short int HEADER_LENGHT = 11;

int address_RX_FIFO, address_TX_normal_FIFO;
short int data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2 + 1 + 1], lost_data;

short int ADDRESS_short_1[2], ADDRESS_long_1[8];
short int ADDRESS_short_2[2], ADDRESS_long_2[8];
short int PAN_ID_1[2];
short int PAN_ID_2[2];
short int DATA_RX[DATA_LENGHT], DATA_TX[DATA_LENGHT], data_TX_normal_FIFO[DATA_LENGHT + HEADER_LENGHT + 2];
short int LQI, RSSI2, SEQ_NUMBER, SN;
short int temp1;

int dig1 = '1', dig2 = '2', dig3 = '0', degrees = 0, battery = 0;
#line 163 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void write_ZIGBEE_short(short int address, short int data_r) {
 CS2 = 0;

 address = ((address << 1) & 0b01111111) | 0x01;
 SPI1_Write(address);
 SPI1_Write(data_r);

 CS2 = 1;
}


short int read_ZIGBEE_short(short int address) {
 short int data_r = 0, dummy_data_r = 0;

 CS2 = 0;

 address = (address << 1) & 0b01111110;
 SPI1_Write(address);
 data_r = SPI1_Read(dummy_data_r);

 CS2 = 1;
 return data_r;
}
#line 191 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void write_ZIGBEE_long(int address, short int data_r) {
 short int address_high = 0, address_low = 0;

 CS2 = 0;

 address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;
 address_low = (((short int)(address << 5)) & 0b11100000) | 0x10;
 SPI1_Write(address_high);
 SPI1_Write(address_low);
 SPI1_Write(data_r);

 CS2 = 1;
}


short int read_ZIGBEE_long(int address) {
 short int data_r = 0, dummy_data_r = 0;
 short int address_high = 0, address_low = 0;

 CS2 = 0;

 address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;
 address_low = ((short int)(address << 5) & 0b11100000);
 SPI1_Write(address_high);
 SPI1_Write(address_low);
 data_r = SPI1_Read(dummy_data_r);

 CS2 = 1;
 return data_r;
}
#line 225 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void start_transmit() {
#line 230 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
 write_ZIGBEE_short( 0x1B , 0b00000101);
}
#line 236 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void read_RX_FIFO() {
 unsigned short int temp = 0;
 int i = 0;

 temp = read_ZIGBEE_short( 0x39 );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x39 , temp);

 for(i=0; i<128; i++) {
 if(i < (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
 data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);
 if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
 lost_data = read_ZIGBEE_long(address_RX_FIFO + i);
 }

 SN = data_RX_FIFO[3];

 DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];
 DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];
 DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];
 DATA_RX[3] = data_RX_FIFO[HEADER_LENGHT + 4];
 DATA_RX[4] = data_RX_FIFO[HEADER_LENGHT + 5];

 LQI = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];
 RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];

 temp = read_ZIGBEE_short( 0x39 );
 temp = temp & (!0x04);
 write_ZIGBEE_short( 0x39 , temp);
}
#line 270 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_ACK(void){
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x1B , temp);
}

void set_not_ACK(void){
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp & (!0x04);
 write_ZIGBEE_short( 0x1B , temp);
}
void Frame_ACK(void){
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x12 );
 temp = temp | 0x80;
 write_ZIGBEE_short( 0x12 , temp);
}

void set_ACK_recipient(void){
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x00 , temp);
}
#line 305 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_encrypt(void){
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp | 0x02;
 write_ZIGBEE_short( 0x1B , temp);
}

void set_not_encrypt(void){
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x1B );
 temp = temp & (!0x02);
 write_ZIGBEE_short( 0x1B , temp);
}

void write_TX_normal_FIFO() {
 int i = 0;

 data_TX_normal_FIFO[0] = HEADER_LENGHT;
 data_TX_normal_FIFO[1] = HEADER_LENGHT + DATA_LENGHT;
 data_TX_normal_FIFO[2] = 0x21;
 data_TX_normal_FIFO[3] = 0x88;
 data_TX_normal_FIFO[4] = SEQ_NUMBER;
 data_TX_normal_FIFO[5] = PAN_ID_2[1];
 data_TX_normal_FIFO[6] = PAN_ID_2[0];
 data_TX_normal_FIFO[7] = ADDRESS_short_2[0];
 data_TX_normal_FIFO[8] = ADDRESS_short_2[1];
 data_TX_normal_FIFO[9] = PAN_ID_1[0];
 data_TX_normal_FIFO[10] = PAN_ID_1[1];
 data_TX_normal_FIFO[11] = ADDRESS_short_1[0];
 data_TX_normal_FIFO[12] = ADDRESS_short_1[1];

 data_TX_normal_FIFO[13] = DATA_TX[0];
 data_TX_normal_FIFO[14] = DATA_TX[1];
 data_TX_normal_FIFO[15] = DATA_TX[2];
 data_TX_normal_FIFO[16] = DATA_TX[3];
 data_TX_normal_FIFO[17] = DATA_TX[4];

 for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
 write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]);
 }



 start_transmit();
}
#line 359 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void pin_reset() {
 RST = 0;
 Delay_ms(5);
 RST = 1;
 Delay_ms(5);
}

void PWR_reset() {
 write_ZIGBEE_short( 0x2A , 0x04);
}

void BB_reset() {
 write_ZIGBEE_short( 0x2A , 0x02);
}

void MAC_reset() {
 write_ZIGBEE_short( 0x2A , 0x01);
}

void software_reset() {
 write_ZIGBEE_short( 0x2A , 0x07);
}

void RF_reset() {
 short int temp = 0;
 temp = read_ZIGBEE_short( 0x36 );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x36 , temp);
 temp = temp & (!0x04);
 write_ZIGBEE_short( 0x36 , temp);
 Delay_ms(1);
}
#line 395 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void enable_interrupt() {
 write_ZIGBEE_short( 0x32 , 0x00);
}
#line 402 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_channel(short int channel_number) {
 if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
 switch(channel_number) {
 case 11:
 write_ZIGBEE_long( 0x200 , 0x02);
 break;
 case 12:
 write_ZIGBEE_long( 0x200 , 0x12);
 break;
 case 13:
 write_ZIGBEE_long( 0x200 , 0x22);
 break;
 case 14:
 write_ZIGBEE_long( 0x200 , 0x32);
 break;
 case 15:
 write_ZIGBEE_long( 0x200 , 0x42);
 break;
 case 16:
 write_ZIGBEE_long( 0x200 , 0x52);
 break;
 case 17:
 write_ZIGBEE_long( 0x200 , 0x62);
 break;
 case 18:
 write_ZIGBEE_long( 0x200 , 0x72);
 break;
 case 19:
 write_ZIGBEE_long( 0x200 , 0x82);
 break;
 case 20:
 write_ZIGBEE_long( 0x200 , 0x92);
 break;
 case 21:
 write_ZIGBEE_long( 0x200 , 0xA2);
 break;
 case 22:
 write_ZIGBEE_long( 0x200 , 0xB2);
 break;
 case 23:
 write_ZIGBEE_long( 0x200 , 0xC2);
 break;
 case 24:
 write_ZIGBEE_long( 0x200 , 0xD2);
 break;
 case 25:
 write_ZIGBEE_long( 0x200 , 0xE2);
 break;
 case 26:
 write_ZIGBEE_long( 0x200 , 0xF2);
 break;
 }
 RF_reset();
}
#line 460 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_CCA_mode(short int CCA_mode) {
 short int temp = 0;
 switch(CCA_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x80;
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x3A , temp);
 write_ZIGBEE_short( 0x3F , 0x60);
 }
 break;

 case 2: {
 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x40;
 temp = temp & 0x7F;
 write_ZIGBEE_short( 0x3A , temp);

 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x38;
 temp = temp & 0xFB;
 write_ZIGBEE_short( 0x3A , temp);
 }
 break;

 case 3: {
 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0xC0;
 write_ZIGBEE_short( 0x3A , temp);

 temp = read_ZIGBEE_short( 0x3A );
 temp = temp | 0x38;
 temp = temp & 0xFB;
 write_ZIGBEE_short( 0x3A , temp);

 write_ZIGBEE_short( 0x3F , 0x60);
 }
 break;
 }
 }
#line 504 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_RSSI_mode(short int RSSI_mode) {
 short int temp = 0;

 switch(RSSI_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x3E );
 temp = temp | 0x80;
 write_ZIGBEE_short( 0x3E , temp);
 }
 break;

 case 2:
 write_ZIGBEE_short( 0x3E , 0x40);
 break;
 }
}
#line 524 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void nonbeacon_PAN_coordinator_device() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x00 );
 temp = temp | 0x08;
 write_ZIGBEE_short( 0x00 , temp);

 temp = read_ZIGBEE_short( 0x11 );
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x11 , temp);

 write_ZIGBEE_short( 0x10 , 0xFF);
}

void nonbeacon_coordinator_device() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x00 );
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x00 , temp);

 temp = read_ZIGBEE_short( 0x11 );
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x11 , temp);

 write_ZIGBEE_short( 0x10 , 0xFF);
}

void nonbeacon_device() {
 short int temp = 0;

 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & 0xF3;
 write_ZIGBEE_short( 0x00 , temp);

 temp = read_ZIGBEE_short( 0x11 );
 temp = temp & 0xDF;
 write_ZIGBEE_short( 0x11 , temp);
}
#line 571 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_IFS_recomended() {
 short int temp = 0;

 write_ZIGBEE_short( 0x00 , 0x93);

 temp = read_ZIGBEE_short( 0x21 );
 temp = temp | 0x7C;
 write_ZIGBEE_short( 0x21 , temp);

 temp = read_ZIGBEE_short( 0x2E );
 temp = temp | 0x90;
 write_ZIGBEE_short( 0x2E , temp);

 temp = read_ZIGBEE_short( 0x27 );
 temp = temp | 0x31;
 write_ZIGBEE_short( 0x27 , temp);
}

void set_IFS_default() {
 short int temp = 0;

 write_ZIGBEE_short( 0x00 , 0x75);

 temp = read_ZIGBEE_short( 0x21 );
 temp = temp | 0x84;
 write_ZIGBEE_short( 0x21 , temp);

 temp = read_ZIGBEE_short( 0x2E );
 temp = temp | 0x50;
 write_ZIGBEE_short( 0x2E , temp);

 temp = read_ZIGBEE_short( 0x27 );
 temp = temp | 0x41;
 write_ZIGBEE_short( 0x27 , temp);
}
#line 610 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_reception_mode(short int r_mode) {
 short int temp = 0;

 switch(r_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & (!0x03);
 write_ZIGBEE_short( 0x00 , temp);
 }
 break;

 case 2: {
 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & (!0x01);
 temp = temp | 0x02;
 write_ZIGBEE_short( 0x00 , temp);
 }
 break;

 case 3: {
 temp = read_ZIGBEE_short( 0x00 );
 temp = temp & (!0x02);
 temp = temp | 0x01;
 write_ZIGBEE_short( 0x00 , temp);
 }
 break;
 }
}
#line 642 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_frame_format_filter(short int fff_mode) {
 short int temp = 0;

 switch(fff_mode) {
 case 1: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x0E);
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;

 case 2: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x06);
 temp = temp | 0x08;
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;

 case 3: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x0A);
 temp = temp | 0x04;
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;

 case 4: {
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp & (!0x0C);
 temp = temp | 0x02;
 write_ZIGBEE_short( 0x0D , temp);
 }
 break;
 }
}
#line 682 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void flush_RX_FIFO_pointer() {
 short int temp;

 temp = read_ZIGBEE_short( 0x0D );
 temp = temp | 0x01;
 write_ZIGBEE_short( 0x0D , temp);
}
#line 693 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_short_address(short int * address) {
 write_ZIGBEE_short( 0x03 , address[0]);
 write_ZIGBEE_short( 0x04 , address[1]);
}

void set_long_address(short int * address) {
 short int i = 0;

 for(i = 0; i < 8; i++) {
 write_ZIGBEE_short( 0x05  + i, address[i]);
 }
}

void set_PAN_ID(short int * address) {
 write_ZIGBEE_short( 0x01 , address[0]);
 write_ZIGBEE_short( 0x02 , address[1]);
}
#line 714 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_wake_from_pin() {
 short int temp = 0;

 WAKE = 0;
 temp = read_ZIGBEE_short( 0x0D );
 temp = temp | 0x60;
 write_ZIGBEE_short( 0x0D , temp);

 temp = read_ZIGBEE_short( 0x22 );
 temp = temp | 0x80;
 write_ZIGBEE_short( 0x22 , temp);
}

void pin_wake() {
 WAKE = 1;
 Delay_ms(5);
}
#line 735 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void enable_PLL() {
 write_ZIGBEE_long( 0x202 , 0x80);
}

void disable_PLL() {
 write_ZIGBEE_long( 0x202 , 0x00);
}
#line 746 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void set_TX_power(unsigned short int power) {
 if((power < 0) || (power > 31))
 power = 31;
 power = 31 - power;
 power = ((power & 0b00011111) << 3) & 0b11111000;
 write_ZIGBEE_long( 0x203 , power);
}
#line 757 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
void init_ZIGBEE_basic() {
 write_ZIGBEE_short( 0x18 , 0x98);
 write_ZIGBEE_short( 0x2E , 0x95);
 write_ZIGBEE_long( 0x201 , 0x01);
 enable_PLL();
 write_ZIGBEE_long( 0x206 , 0x90);
 write_ZIGBEE_long( 0x207 , 0x80);
 write_ZIGBEE_long( 0x208 , 0x10);
 write_ZIGBEE_long( 0x220 , 0x21);
}

void init_ZIGBEE_nonbeacon() {
 init_ZIGBEE_basic();
 set_CCA_mode(1);
 set_RSSI_mode(2);
 enable_interrupt();
 set_channel(11);
 RF_reset();
}

char Debounce_INT() {
 char i = 0, j = 0, intn_d = 0;
 for(i = 0; i < 5; i++) {
 intn_d = INT;
 if (intn_d == 1)
 j++;
 }
 if (j > 2)
 return 1;
 else
 return 0;
}

void Initialize() {
 short int i = 0;

 LQI = 0;
 RSSI2 = 0;
 SEQ_NUMBER = 0x23;
 lost_data = 0;
 address_RX_FIFO = 0x300;
 address_TX_normal_FIFO = 0;

 for (i = 0; i < 2; i++) {
 ADDRESS_short_1[i] = 1;
 ADDRESS_short_2[i] = 2;
 PAN_ID_1[i] = 3;
 PAN_ID_2[i] = 3;
 }

 for (i = 0; i < 8; i++) {
 ADDRESS_long_1[i] = 1;
 ADDRESS_long_2[i] = 2;
 }

 ADCON1 = 0x0F;
 GIE_bit = 0;

 TRISA = 0x00;
 TRISB = 0x00;
 TRISC = 0x00;
 TRISD = 0x00;

 CS2_Direction = 0;
 RST_Direction = 0;
 INT_Direction = 1;
 WAKE_Direction = 0;

 DATA_TX[0] = 0;
 DATA_TX[1] = 0;
 DATA_TX[2] = 0;
 DATA_TX[3] = 0;
 DATA_TX[4] = 0;

 PORTD = 0;
 LATD = 0;

 Delay_ms(15);

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
 pin_reset();
 software_reset();
 RF_reset();
 set_WAKE_from_pin();

 set_long_address(ADDRESS_long_2);
 set_short_address(ADDRESS_short_2);
 set_PAN_ID(PAN_ID_2);

 init_ZIGBEE_nonbeacon();
 nonbeacon_PAN_coordinator_device();
 set_TX_power(31);
 set_frame_format_filter(1);
 set_reception_mode(1);

 pin_wake();
}

void main() {
 char d1=0, d2=0, d3=0, deg=0, bat=0, seqN=0;
 short int i, cont = 0;
 char texto[16];
 char trans = 0;

 Initialize();

 while(1) {
 if(trans == 0){
 delay_ms(1000);
 if(Debounce_INT() == 0 ){
 temp1 = read_ZIGBEE_short( 0x31 );
 read_RX_FIFO();
 seqN = SN;
 d1=DATA_RX[0];
 d2=DATA_RX[1];
 d3=DATA_RX[2];
 deg=DATA_RX[3];
 bat=DATA_RX[4];

 Lcd_Chr(1, 1, d1);
 Lcd_Chr(1, 2, d2);



 IntToStr(seqN, texto);
 Lcd_Out(2,1,texto);

 }
 }
 if(trans == 1){

 delay_ms(1000);

 DATA_TX[0]=dig1;
 DATA_TX[1]=dig2;
 DATA_TX[2]=dig3;
 DATA_TX[3]=degrees;
 DATA_TX[4]=battery;
 write_TX_normal_FIFO();
 i = read_ZIGBEE_short( 0x24 );
#line 905 "C:/Users/User/Documents/libusb_radio_MCP2210/RadioPIC_2/computador/computador.c"
 delay_ms(1000);

 DATA_TX[0]='3';
 DATA_TX[1]='4';
 DATA_TX[2]='5';
 DATA_TX[3]=degrees;
 DATA_TX[4]=battery;
 write_TX_normal_FIFO();
 i = read_ZIGBEE_short( 0x24 );
 IntToStr(i, texto);
 Lcd_Out(1,1,texto);

 if(i == 0){
 trans = 0;
 }
 }

 }
}
