
/////////////////////////////////////////
////// short address registers  /////////
/////////////////////////////////////////

#define RXMCR     0x00
#define PANIDL    0x01
#define PANIDH    0x02
#define SADRL     0x03
#define SADRH     0x04
#define EADR0     0x05
#define EADR1     0x06
#define EADR2     0x07
#define EADR3     0x08
#define EADR4     0x09
#define EADR5     0x0A
#define EADR6     0x0B
#define EADR7     0x0C
#define RXFLUSH   0x0D
#define ORDER     0x10
#define TXMCR     0x11
#define ACKTMOUT  0x12
#define ESLOTG1   0x13
#define SYMTICKL  0x14
#define SYMTICKH  0x15
#define PACON0    0x16
#define PACON1    0x17
#define PACON2    0x18
#define TXBCON0   0x1A
#define TXNCON    0x1B
#define TXG1CON   0x1C
#define TXG2CON   0x1D
#define ESLOTG23  0x1E
#define ESLOTG45  0x1F
#define ESLOTG67  0x20
#define TXPEND    0x21
#define WAKECON   0x22
#define FRMOFFSET 0x23
#define TXSTAT    0x24
#define TXBCON1   0x25
#define GATECLK   0x26
#define TXTIME    0x27
#define HSYMTMRL  0x28
#define HSYMTMRH  0x29
#define SOFTRST   0x2A
#define SECCON0   0x2C
#define SECCON1   0x2D
#define TXSTBL    0x2E
#define RXSR      0x30
#define INTSTAT   0x31
#define INTCON_M  0x32
#define GPIO      0x33
#define TRISGPIO  0x34
#define SLPACK    0x35
#define RFCTL     0x36
#define SECCR2    0x37
#define BBREG0    0x38
#define BBREG1    0x39
#define BBREG2    0x3A
#define BBREG3    0x3B
#define BBREG4    0x3C
#define BBREG6    0x3E
#define CCAEDTH   0x3F

///////////////////////////////////////////
//////// long address registers  //////////
///////////////////////////////////////////

#define RFCON0    0x200
#define RFCON1    0x201
#define RFCON2    0x202
#define RFCON3    0x203
#define RFCON5    0x205
#define RFCON6    0x206
#define RFCON7    0x207
#define RFCON8    0x208
#define SLPCAL0   0x209
#define SLPCAL1   0x20A
#define SLPCAL2   0x20B
#define RFSTATE   0x20F
#define RSSI      0x210
#define SLPCON0   0x211
#define SLPCON1   0x220
#define WAKETIMEL 0x222
#define WAKETIMEH 0x223
#define REMCNTL   0x224
#define REMCNTH   0x225
#define MAINCNT0  0x226
#define MAINCNT1  0x227
#define MAINCNT2  0x228
#define MAINCNT3  0x229
#define ASSOEADR0 0x230
#define ASSOEADR1 0x231
#define ASSOEADR2 0x232
#define ASSOEADR3 0x233
#define ASSOEADR4 0x234
#define ASSOEADR5 0x235
#define ASSOEADR6 0x236
#define ASSOEADR7 0x237
#define ASSOSADR0 0x238
#define ASSOSADR1 0x239
#define UPNONCE0  0x240
#define UPNONCE1  0x241
#define UPNONCE2  0x242
#define UPNONCE3  0x243
#define UPNONCE4  0x244
#define UPNONCE5  0x245
#define UPNONCE6  0x246
#define UPNONCE7  0x247
#define UPNONCE8  0x248
#define UPNONCE9  0x249
#define UPNONCE10 0x24A
#define UPNONCE11 0x24B
#define UPNONCE12 0x24C

// BEE Click Board connections
sbit CS2 at LATC0_bit;                // CS2 pin
sbit RST at LATC1_bit;               // RST pin
sbit INT at RC6_bit;                 // INT pin
sbit WAKE at LATC2_bit;              // WAKE pin

sbit CS2_Direction at TRISC0_bit;     // CS2 pin direction
sbit RST_Direction at TRISC1_bit;    // RST pin direction
sbit INT_Direction at TRISC6_bit;    // INT pin direction
sbit WAKE_Direction at TRISC2_bit;   // WAKE pin direction


sbit H3 at RB0_bit;     // Pinos termometro
sbit H2 at RB2_bit;
sbit H1 at RB4_bit;
sbit CLK_therm at RB1_bit;
sbit LD at RB3_bit;
sbit Serial_in at LATB7_bit;

sbit H3_Direction at TRISB0_bit;
sbit H2_Direction at TRISB2_bit;
sbit H1_Direction at TRISB4_bit;
sbit LD_Direction at TRISB1_bit;
sbit CLK_therm_Direction at TRISB3_bit;
sbit Serial_in_Direction at TRISB7_bit;  // Fim pinos termometro

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

short int ADDRESS_short_1[2], ADDRESS_long_1[8];        // Source address
short int ADDRESS_short_2[2], ADDRESS_long_2[8];        // Destination address
short int PAN_ID_1[2];               // Source PAN ID
short int PAN_ID_2[2];               // Destination PAN ID
short int DATA_RX[DATA_LENGHT], DATA_TX[DATA_LENGHT], data_TX_normal_FIFO[DATA_LENGHT + HEADER_LENGHT + 2];
short int LQI, RSSI2, SEQ_NUMBER, SN;
short int temp1;


int dig1 = '1', dig2 = '2', dig3 = '0', degrees = 0, battery = 0;

/*
 * Functions for reading and writing registers in short address memory space
 */
// write data in short address register
void write_ZIGBEE_short(short int address, short int data_r) {
  CS2 = 0;

  address = ((address << 1) & 0b01111111) | 0x01; // calculating addressing mode
  SPI1_Write(address);       // addressing register
  SPI1_Write(data_r);        // write data in register

  CS2 = 1;
}

// read data from short address register
short int read_ZIGBEE_short(short int address) {
  short int data_r = 0, dummy_data_r = 0;

  CS2 = 0;

  address = (address << 1) & 0b01111110;      // calculating addressing mode
  SPI1_Write(address);                        // addressing register
  data_r = SPI1_Read(dummy_data_r);           // read data from register

  CS2 = 1;
  return data_r;
}

/*
 * Functions for reading and writing registers in long address memory space
 */
// Write data in long address register
void write_ZIGBEE_long(int address, short int data_r) {
  short int address_high = 0, address_low = 0;

  CS2 = 0;

  address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;  // calculating addressing mode
  address_low  = (((short int)(address << 5)) & 0b11100000) | 0x10;  // calculating addressing mode
  SPI1_Write(address_high);           // addressing register
  SPI1_Write(address_low);            // addressing register
  SPI1_Write(data_r);                 // write data in registerr

  CS2 = 1;
}

// Read data from long address register
short int read_ZIGBEE_long(int address) {
  short int data_r = 0, dummy_data_r = 0;
  short int address_high = 0, address_low = 0;

  CS2 = 0;

  address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;  //calculating addressing mode
  address_low  = ((short int)(address << 5) & 0b11100000);         //calculating addressing mode
  SPI1_Write(address_high);            // addressing register
  SPI1_Write(address_low);             // addressing register
  data_r = SPI1_Read(dummy_data_r);    // read data from register

  CS2 = 1;
  return data_r;
}

/*
 * Transmit packet
 */
void start_transmit() {
  /*short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp | 0x01;                 // mask for start transmit*/
  write_ZIGBEE_short(TXNCON, 0b00000101);
}

/*
 * FIFO
 */
void read_RX_FIFO() {
  unsigned short int temp = 0;
  int i = 0;

  temp = read_ZIGBEE_short(BBREG1);      // disable receiving packets off air.
  temp = temp | 0x04;                    // mask for disable receiving packets
  write_ZIGBEE_short(BBREG1, temp);

  for(i=0; i<128; i++) {
    if(i <  (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
      data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);  // reading valid data from RX FIFO
    if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
      lost_data = read_ZIGBEE_long(address_RX_FIFO + i);        // reading invalid data from RX FIFO
  }
  
  SN =  data_RX_FIFO[3];      //ler o sequence number

  DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];               // coping valid data
  DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];               // coping valid data
  DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];               // coping valid data
  DATA_RX[3] = data_RX_FIFO[HEADER_LENGHT + 4];               // coping valid data
  DATA_RX[4] = data_RX_FIFO[HEADER_LENGHT + 5];               // coping valid data

  LQI   = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];  // coping valid data
  RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];  // coping valid data

  temp = read_ZIGBEE_short(BBREG1);      // enable receiving packets off air.
  temp = temp & (!0x04);                 // mask for enable receiving
  write_ZIGBEE_short(BBREG1, temp);
}

/*
 * ACK request
 */
void set_ACK(void){
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp | 0x04;                   // 0x04 mask for set ACK
  write_ZIGBEE_short(TXNCON, temp);
}

void set_not_ACK(void){
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp & (!0x04);                // 0x04 mask for set not ACK
  write_ZIGBEE_short(TXNCON, temp);
}

/*
 *  Encrypt
 */
void set_encrypt(void){
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp | 0x02;                   // mask for set encrypt
  write_ZIGBEE_short(TXNCON, temp);
}

void set_not_encrypt(void){
  short int temp = 0;

  temp = read_ZIGBEE_short(TXNCON);
  temp = temp & (!0x02);                // mask for set not encrypt
  write_ZIGBEE_short(TXNCON, temp);
}

void write_TX_normal_FIFO() {
  int i = 0;

  data_TX_normal_FIFO[0]  = HEADER_LENGHT;
  data_TX_normal_FIFO[1]  = HEADER_LENGHT + DATA_LENGHT;
  data_TX_normal_FIFO[2]  = 0x21;                        // control frame
  data_TX_normal_FIFO[3]  = 0x88;
  data_TX_normal_FIFO[4]  = SEQ_NUMBER;                  // sequence number
  data_TX_normal_FIFO[5]  = PAN_ID_2[1];                 // destinatoin pan
  data_TX_normal_FIFO[6]  = PAN_ID_2[0];
  data_TX_normal_FIFO[7]  = ADDRESS_short_2[0];          // destination address
  data_TX_normal_FIFO[8]  = ADDRESS_short_2[1];
  data_TX_normal_FIFO[9]  = PAN_ID_1[0];                 // source pan
  data_TX_normal_FIFO[10] = PAN_ID_1[1];
  data_TX_normal_FIFO[11] = ADDRESS_short_1[0];          // source address
  data_TX_normal_FIFO[12] = ADDRESS_short_1[1];

  data_TX_normal_FIFO[13] = DATA_TX[0];                  // data
  data_TX_normal_FIFO[14] = DATA_TX[1];                  // data
  data_TX_normal_FIFO[15] = DATA_TX[2];                  // data
  data_TX_normal_FIFO[16] = DATA_TX[3];                  // data
  data_TX_normal_FIFO[17] = DATA_TX[4];                  // data

  for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
    write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]); // write frame into normal FIFO
  }
  //"Bit is cleared at the next triggering of TXN FIFO." Set ack é feito direto na função "start_transmit();"
  //set_ACK();
  //set_not_encrypt();
  start_transmit();
}


/*
 * Reset functions
 */

// Reset from pin
void pin_reset() {
  RST = 0;  // activate reset
  Delay_ms(5);
  RST = 1;  // deactivate reset
  Delay_ms(5);
}

void PWR_reset() {
  write_ZIGBEE_short(SOFTRST, 0x04);   // 0x04  mask for RSTPWR bit
}

void BB_reset() {
  write_ZIGBEE_short(SOFTRST, 0x02);   // 0x02 mask for RSTBB bit
}

void MAC_reset() {
  write_ZIGBEE_short(SOFTRST, 0x01);   // 0x01 mask for RSTMAC bit
}

void software_reset() {                // PWR_reset,BB_reset and MAC_reset at once
  write_ZIGBEE_short(SOFTRST, 0x07);
}

void RF_reset() {
  short int temp = 0;
  temp = read_ZIGBEE_short(RFCTL);
  temp = temp | 0x04;                  // mask for RFRST bit
  write_ZIGBEE_short(RFCTL, temp);
  temp = temp & (!0x04);               // mask for RFRST bit
  write_ZIGBEE_short(RFCTL, temp);
  Delay_ms(1);
}

/*
 *  Interrupt
 */
void enable_interrupt() {
 write_ZIGBEE_short(INTCON_M, 0x00);   // 0x00  all interrupts are enable
}

/*
 *  Set channel
 */
void set_channel(short int channel_number) {               // 11-26 possible channels
  if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
  switch(channel_number) {
    case 11:
      write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
      break;
    case 12:
      write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
      break;
    case 13:
      write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
      break;
    case 14:
      write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
      break;
    case 15:
      write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
      break;
    case 16:
      write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
      break;
    case 17:
      write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
      break;
    case 18:
      write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
      break;
    case 19:
      write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
      break;
    case 20:
      write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
      break;
    case 21:
      write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
      break;
    case 22:
      write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
      break;
    case 23:
      write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
      break;
    case 24:
      write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
      break;
    case 25:
      write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
      break;
    case 26:
      write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
      break;
  }
  RF_reset();
}

/*
 *  Set CCA mode
 */
void set_CCA_mode(short int CCA_mode) {
  short int temp = 0;
  switch(CCA_mode) {
        case 1: {                               // ENERGY ABOVE THRESHOLD
          temp = read_ZIGBEE_short(BBREG2);
          temp = temp | 0x80;                   // 0x80 mask
          temp = temp & 0xDF;                   // 0xDF mask
          write_ZIGBEE_short(BBREG2, temp);
          write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
        }
        break;

        case 2: {                               // CARRIER SENSE ONLY
          temp = read_ZIGBEE_short(BBREG2);
          temp = temp | 0x40;                   // 0x40 mask
          temp = temp & 0x7F;                   // 0x7F mask
          write_ZIGBEE_short(BBREG2, temp);

          temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
          temp = temp | 0x38;
          temp = temp & 0xFB;
          write_ZIGBEE_short(BBREG2, temp);
        }
        break;

        case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
          temp = read_ZIGBEE_short(BBREG2);
          temp = temp | 0xC0;                   // 0xC0 mask
          write_ZIGBEE_short(BBREG2, temp);

          temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
          temp = temp | 0x38;                   // 0x38 mask
          temp = temp & 0xFB;                   // 0xFB mask
          write_ZIGBEE_short(BBREG2, temp);

          write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
        }
        break;
    }
 }

/*
 *  Set RSSI mode
 */
void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
  short int temp = 0;

  switch(RSSI_mode) {
    case 1: {
      temp = read_ZIGBEE_short(BBREG6);
      temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
      write_ZIGBEE_short(BBREG6, temp);
    }
    break;

    case 2:
      write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
      break;
  }
}

/*
 * Set type of device
 */
void nonbeacon_PAN_coordinator_device() {
  short int temp = 0;

  temp = read_ZIGBEE_short(RXMCR);
  temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
  write_ZIGBEE_short(RXMCR, temp);

  temp = read_ZIGBEE_short(TXMCR);
  temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
  write_ZIGBEE_short(TXMCR, temp);

  write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
}

void nonbeacon_coordinator_device() {
  short int temp = 0;

  temp = read_ZIGBEE_short(RXMCR);
  temp = temp | 0x04;                 // 0x04 mask for coordinator
  write_ZIGBEE_short(RXMCR, temp);

  temp = read_ZIGBEE_short(TXMCR);
  temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
  write_ZIGBEE_short(TXMCR, temp);

  write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
}

void nonbeacon_device() {
  short int temp = 0;

  temp = read_ZIGBEE_short(RXMCR);
  temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
  write_ZIGBEE_short(RXMCR, temp);

  temp = read_ZIGBEE_short(TXMCR);
  temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
  write_ZIGBEE_short(TXMCR, temp);
}





/*
 * Interframe spacing
 */
void set_IFS_recomended() {
  short int temp = 0;

  write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period

  temp = read_ZIGBEE_short(TXPEND);
  temp = temp | 0x7C;                 // MinLIFSPeriod
  write_ZIGBEE_short(TXPEND, temp);

  temp = read_ZIGBEE_short(TXSTBL);
  temp = temp | 0x90;                 // MinLIFSPeriod
  write_ZIGBEE_short(TXSTBL, temp);

  temp = read_ZIGBEE_short(TXTIME);
  temp = temp | 0x31;                 // TurnaroundTime
  write_ZIGBEE_short(TXTIME, temp);
}

void set_IFS_default() {
  short int temp = 0;

  write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period

  temp = read_ZIGBEE_short(TXPEND);
  temp = temp | 0x84;                 // Min LIFS Period
  write_ZIGBEE_short(TXPEND, temp);

  temp = read_ZIGBEE_short(TXSTBL);
  temp = temp | 0x50;                 // Min LIFS Period
  write_ZIGBEE_short(TXSTBL, temp);

  temp = read_ZIGBEE_short(TXTIME);
  temp = temp | 0x41;                 // Turnaround Time
  write_ZIGBEE_short(TXTIME, temp);
}

/*
 * Reception mode
 */
void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
  short int temp = 0;

  switch(r_mode) {
   case 1: {
     temp = read_ZIGBEE_short(RXMCR);      // normal mode
     temp = temp & (!0x03);                // mask for normal mode
     write_ZIGBEE_short(RXMCR, temp);
   }
   break;

   case 2: {
     temp = read_ZIGBEE_short(RXMCR);      // error mode
     temp = temp & (!0x01);                // mask for error mode
     temp = temp | 0x02;                   // mask for error mode
     write_ZIGBEE_short(RXMCR, temp);
   }
   break;

   case 3: {
     temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
     temp = temp & (!0x02);                // mask for promiscuous mode
     temp = temp | 0x01;                   // mask for promiscuous mode
     write_ZIGBEE_short(RXMCR, temp);
   }
   break;
  }
}

/*
 *  Frame format filter
 */
void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
  short int temp = 0;

  switch(fff_mode) {
   case 1: {
     temp = read_ZIGBEE_short(RXFLUSH);      // all frames
     temp = temp & (!0x0E);                  // mask for all frames
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;

   case 2: {
     temp = read_ZIGBEE_short(RXFLUSH);      // command only
     temp = temp & (!0x06);                  // mask for command only
     temp = temp | 0x08;                     // mask for command only
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;

   case 3: {
     temp = read_ZIGBEE_short(RXFLUSH);      // data only
     temp = temp & (!0x0A);                  // mask for data only
     temp = temp | 0x04;                     // mask for data only
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;

   case 4: {
     temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
     temp = temp & (!0x0C);                  // mask for beacon only
     temp = temp | 0x02;                     // mask for beacon only
     write_ZIGBEE_short(RXFLUSH, temp);
   }
   break;
  }
}

/*
 *  Flush RX FIFO pointer
 */
void flush_RX_FIFO_pointer() {
  short int temp;

  temp = read_ZIGBEE_short(RXFLUSH);
  temp = temp | 0x01;                        // mask for flush RX FIFO
  write_ZIGBEE_short(RXFLUSH, temp);
}

/*
 * Address
 */
void set_short_address(short int * address) {
  write_ZIGBEE_short(SADRL, address[0]);
  write_ZIGBEE_short(SADRH, address[1]);
}

void set_long_address(short int * address) {
  short int i = 0;

  for(i = 0; i < 8; i++) {
    write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
  }
}

void set_PAN_ID(short int * address) {
  write_ZIGBEE_short(PANIDL, address[0]);
  write_ZIGBEE_short(PANIDH, address[1]);
}

/*
 * Wake
 */
void set_wake_from_pin() {
  short int temp = 0;

  WAKE = 0;
  temp = read_ZIGBEE_short(RXFLUSH);
  temp = temp | 0x60;                     // mask
  write_ZIGBEE_short(RXFLUSH, temp);

  temp = read_ZIGBEE_short(WAKECON);
  temp = temp | 0x80;
  write_ZIGBEE_short(WAKECON, temp);
}

void pin_wake() {
  WAKE = 1;
  Delay_ms(5);
}

/*
 * PLL
 */
void enable_PLL() {
  write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
}

void disable_PLL() {
  write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
}

/*
 * Tx power
 */
void set_TX_power(unsigned short int power) {             // 0-31 possible variants
  if((power < 0) || (power > 31))
    power = 31;
  power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
  power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
  write_ZIGBEE_long(RFCON3, power);
}

/*
* Init ZIGBEE module
*/
void init_ZIGBEE_basic() {
  write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
  write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
  write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
  enable_PLL();                       // Enable PLL (PLLEN = 1)
  write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
  write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
  write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
  write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
}

void init_ZIGBEE_nonbeacon() {
  init_ZIGBEE_basic();
  set_CCA_mode(1);     // Set CCA mode to ED and set threshold
  set_RSSI_mode(2);    // RSSI2 mode
  enable_interrupt();  // Enables all interrupts
  set_channel(11);     // Channel 11
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


// ======================================================== Termômetro ==============================

char Decoder_therm (short int digit, short int code_d){

  switch(code_d){
    case 0b00000111: {
        if (digit == 1){
          return ' ';
        }
      }
      break;
    case 0b00000101:{
      if (digit == 1){
        return '4';
      }
    }
      break;
    case 0b00000100:{
      if ((digit == 2) || (digit == 3)){
        return '0';
      }
    }
      break;
    case 0b01101101:{
      if ((digit == 2) || (digit == 3)){
        return '1';
      }
    }
      break;
    case 0b01000010:{
      if ((digit == 2) || (digit == 3)){
        return '2';
      }
    }
      break;
    case 0b01001000:{
      if ((digit == 2) || (digit == 3)){
        return '3';
      }
    }
      break;
    case 0b00101001:{
      if ((digit == 2) || (digit == 3)){
        return '4';
      }
    }
      break;
    case 0b00011000:{
      if ((digit == 2) || (digit == 3)){
        return '5';
      }
    }
      break;
    case 0b00010000:{
      if ((digit == 2) || (digit == 3)){
        return '6';
      }
    }
      break;
    case 0b01001101:{
      if ((digit == 2) || (digit == 3)){
        return '7';
      }
    }
      break;
    case 0b000000000:{
      if ((digit == 2) || (digit == 3)){
        return '8';
      }
      else if (digit == 1){
        return '3';
      }
    }
      break;
    case 0b00001000:{
      if ((digit == 2) || (digit == 3)){
        return '9';
      }
    }
      break;
    case 0b00100001:{
      if (digit == 2){
        return 'H';
      }
    }
      break;
    case 0b00110110:{
      if (digit == 2){
        return 'L';
      }
    }
      break;
    case 0b01110111:{
      if (digit == 3){
        return 'i';
      }
    }
      break;
    case 0b01110000:{
      if (digit == 3){
        return 'o';
      }
    }
      break;
    default:
      return 'E';
      break;
  }
  return 'E';
}

// Rbo = H3; Rb1 = Clk; Rb2 = H2; Rb3 = LD; Rb4 = H1, Rb7 = Serial in
void Read_therm_serial(){
  unsigned short loop;
  dig1=0;
  dig2=0;
  dig3=0;
  degrees=0;
  battery=0;

  while (H1 == 0) {} // Wait H1 to be 1
  LD = 1;             // Set LD = 1
  for (loop = 0; loop < 8; loop++){
    if (loop == 0){
      dig1 <<= 1;
      dig1 += Serial_in;
    }
    else if ((loop >= 1) && (loop <= 3)){
      dig2 <<= 1;
      dig2 += Serial_in;
    }
    else if ((loop >= 4) && (loop <= 6)){
      dig3 <<= 1;
      dig3 += Serial_in;
    }
    else {
      degrees <<= 1;
      degrees += Serial_in;
    }
    CLK_therm = 1;   // Generate a pulse of clock
    delay_us(500);
    CLK_therm = 0;
  }
  LD = 0; // Set LD = 0

  while (H2 == 0) {}    // Wait H2 to be 1
  LD = 1;              // Set LD = 1
  for (loop = 0; loop < 8; loop++){
    if (loop == 0){
      dig1 <<= 1;
      dig1 += Serial_in;
    }
    else if ((loop >= 1) && (loop <= 3)){
      dig2 <<= 1;
      dig2 += Serial_in;
    }
    else if ((loop >= 4) && (loop <= 6)){
      dig3 <<= 1;
      dig3 += Serial_in;
    }
    else {
      degrees <<= 1;
      degrees += Serial_in;
    }
    CLK_therm = 1;   // Generate a pulse of clock
    delay_us(500);
    CLK_therm = 0;
  }
  LD = 0; // Set LD = 0

  while (H3 == 0) {}          // Wait H3 to be 1
  LD = 1;                    // Set LD = 1
  for (loop = 0; loop < 8; loop++){
    if (loop == 0){
      dig1 <<= 1;
      dig1 += Serial_in;
    }
    else if (loop == 2){
      dig2 <<= 1;
      dig2 += Serial_in;
    }
    else if (loop == 5){
      dig3 <<= 1;
      dig3 += Serial_in;
    }
    else if (loop == 6){
      battery = Serial_in;
    }
    else if (loop == 7){
      degrees <<= 1;
      degrees += Serial_in;
    }
    CLK_therm = 1;    // Generate a pulse of clock
    delay_us(500);
    CLK_therm = 0;
  }
  LD = 0;   // Set LD = 0

  dig1 = Decoder_therm(1, dig1);
  dig2 = Decoder_therm(2, dig2);
  dig3 = Decoder_therm(3, dig3);

  Lcd_Chr(1, 1, dig1);
  Lcd_Chr(1, 2, dig2);
  if ((dig3 == 'i')||(dig3 == 'o')){
      Lcd_Chr(1, 3, dig3);
      Lcd_Chr(1, 4, ' ');
  }else{
      Lcd_Chr(1, 3, '.');
      Lcd_Chr(1, 4, dig3);
  }

  if (battery == 1){
    battery = 'b';
    Lcd_Out(2, 0, "           ");
  }
  else {
    battery = 'B';
    Lcd_Out(2, 0, "low battery");
  }

  if (degrees == 2){
    degrees = 'C';
    Lcd_Chr(1, 5, 'C');
  }
  else {
    degrees = 'c';
    Lcd_Chr(1, 5, ' ');
  }
}


void Initialize() {
  short int i = 0;
  //variable initialization
  LQI = 0;
  RSSI2 = 0;
  SEQ_NUMBER = 0x01;
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
  GIE_bit = 0;           // Disable interrupts

  TRISA = 0x00;          // Set direction to be output
  TRISB = 0x00;          // Set direction to be output
  TRISC = 0x00;          // Set direction to be output
  TRISD = 0x00;          // Set direction to be output

  CS2_Direction = 0;      // Set direction to be output
  RST_Direction  = 0;    // Set direction to be output
  INT_Direction  = 1;    // Set direction to be input
  WAKE_Direction = 0;    // Set direction to be output


  H3_Direction = 1;      // Direcao pinos termometro
  H2_Direction = 1;
  H1_Direction = 1;
  Serial_in_Direction = 1;
  LD_Direction = 0;
  CLK_therm_Direction = 0;

  DATA_TX[0] = 0;        // Initialize first byte
  DATA_TX[1] = 0;        // Initialize first byte
  DATA_TX[2] = 0;        // Initialize first byte
  DATA_TX[3] = 0;        // Initialize first byte
  DATA_TX[4] = 0;        // Initialize first byte

  PORTD = 0;             // Clear PORTD register
  LATD  = 0;             // Clear LATD register

  Delay_ms(15);

  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off

  // Initialize SPI module
  SPI1_Init_AdvancEd(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
  pin_reset();                              // Activate reset from pin
  software_reset();                         // Activate software reset
  RF_reset();                               // RF reset
  set_WAKE_from_pin();                      // Set wake from pin

  set_long_address(ADDRESS_long_2);         // Set long address
  set_short_address(ADDRESS_short_2);       // Set short address
  set_PAN_ID(PAN_ID_1);                     // Set PAN_ID

  init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
  nonbeacon_PAN_coordinator_device();
  set_TX_power(31);                         // Set max TX power
  set_frame_format_filter(1);               // 1 all frames, 3 data frame only
  set_reception_mode(1);                    // 1 normal mode

  pin_wake();                               // Wake from pin
}

void main() {
     char d1=0, d2=0, d3=0, deg=0, bat=0;
     char lastD1=0, lastD2=0, lastD3=0, lastDeg=0, lastBat=0, lastSN=0;
     short int i, cont = 0, cond=0, repPack=0;
     char texto[16];
     char trans = 0; //quando trans = 1 está operando no modo transmissor, se trans = 0 está no modo receptor
     
     Initialize();                      // Initialize MCU and Bee click board
     
     while(1) {
              if(trans == 0){
                      Lcd_Chr(2,5,'b');
                      if(Debounce_INT() == 0 ){

                              temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
                              read_RX_FIFO();                     // Read receive data
                              d1=DATA_RX[0];
                              d2=DATA_RX[1];
                              d3=DATA_RX[2];
                              deg=DATA_RX[3];
                              bat=DATA_RX[4];

                              cond = 1;

                      }
                      else if(cond > 0){
                           Delay_us(910);
                           cond ++;
                           if(cond == 100){
                                   Initialize();
                                   write_TX_normal_FIFO();
                                   Lcd_Chr(1,1,'b');
                                   trans = 1;
                           }
                      }
              } //final trans = 0
              if(trans == 1){
                      Delay_ms(3000);
                      //Read_therm_serial();
                      DATA_TX[0]='3';
                      DATA_TX[1]=dig2;
                      DATA_TX[2]=dig3;
                      DATA_TX[3]=degrees;
                      DATA_TX[4]=battery;
                      write_TX_normal_FIFO();
                      i = read_ZIGBEE_short(TXSTAT);

                      SEQ_NUMBER++;

                      if((i & 1) == 0){
                             trans = 2;
                             cond = 0;
                             Initialize();
                             Lcd_Chr(1,1,'a');
                             Delay_ms(900);
                      }
                      else if((i & 1) == 1){
                           Lcd_Chr(1,1,'r');
                      }
              }   //final trans ==1
      }//final while
}
