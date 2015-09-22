/*
	\MCP2210
	@file bulk_led.c
	\author Bernardo Fávero Andreeti, Eduardo Luzzi e José Augusto Comiotto Rottini
	\version 2.4
	\date 08/2014
*/

#include <stdio.h>
#include <sys/types.h>

#include <libusb-1.0/libusb.h>

#include <my_global.h>
#include <mysql.h>	

/**
@def DEV_ENDPOINT
@brief DEV_ENDPOINT
 	 MCP2210 EndPoint.
 */
#define DEV_ENDPOINT 0x01
/**
@def HOST_ENDPOINT 
@brief HOST_ENDPOINT
 	 Computer EndPoint.
 */
#define HOST_ENDPOINT 0x81
/**
@def DEV_VID
@brief DEV_VID 0x81
 	 User configurable.
 */
#define DEV_VID 1240    
/**
@def DEV_PID
@brief DEV_PID 0x81
 	 Values for MCP2210.
 */  	   	  
#define DEV_PID 222	   	   		   


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

const unsigned short int DATA_LENGHT = 5;
const unsigned short int HEADER_LENGHT = 11;

int address_RX_FIFO, address_TX_normal_FIFO;
short int data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2 + 1 + 1], lost_data;

short int ADDRESS_short_1[2], ADDRESS_long_1[8];        // Source address
short int ADDRESS_short_2[2], ADDRESS_long_2[8];        // Destination address
short int PAN_ID_1[2];               // Source PAN ID
short int PAN_ID_2[2];               // Destination PAN ID
short int DATA_RX[DATA_LENGHT], DATA_TX[DATA_LENGHT], data_TX_normal_FIFO[DATA_LENGHT + HEADER_LENGHT + 2];
short int LQI, RSSI2, SEQ_NUMBER;
short int temp1;

/*
#if 0
void finish_with_error(MYSQL *con, libusb_device_handle *handle, libusb_context *ctx)
{
  fprintf(stderr, "%s\n", mysql_error(con));
  mysql_close(con);
  libusb_close(handle); // closes the library	
  libusb_exit(ctx); // exit context
  exit(1);        
}  	   		   
#endif
*/


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


/**
@brief transfer_data()
 	  This function calls the bulk transfer available on libusb.
 */


int transfer_data(libusb_device_handle *handle, unsigned char *data, MYSQL *con) 
{
	int byte_count, rslt;
	float dataF = 0;
	unsigned char ReceivedData[64];
	unsigned char *Response = ReceivedData;
	char query[100];
	
	/**
	@brief libusb_bulk_transfer()
 	  Send data to MCP2210.
	*/
	rslt = libusb_bulk_transfer(handle, DEV_ENDPOINT, data, 64, &byte_count, 0); 
	if(rslt == 0 && byte_count == 64)
	{
		/**
		@brief libusb_bulk_transfer()
			 Receives device response.
		*/
		rslt = libusb_bulk_transfer(handle, HOST_ENDPOINT, Response, 64, &byte_count, 0);
		if(rslt == 0 && byte_count == 64) // successfully received all bytes	
		{
			if(ReceivedData[0]==0x42 && ReceivedData[1]==0x00 && ReceivedData[2] == 0x01 && ReceivedData[3]==0x10) // condition for a new data read
			{
				printf("Received Data = %#02x\n", ReceivedData[4]); // prints received data

				dataF = ReceivedData[4];
				
				/*
				// generate query string to insert new data into the database
				snprintf(query, 100, "INSERT INTO subjectdata (subject_id, details, temperature) VALUES (1, 'MCP2210', ('%.2f'))", dataF);
				
				if (mysql_query(con, query)) {
      					fprintf(stderr, "%s\n", mysql_error(con));
 					mysql_close(con);
  				}  */
				return 3; // data succesfully read
			}
			return 2;
		}
		else
		{
			printf("Reading Error! ERROR CODE = %d\n", rslt);
			return 1;
		}
	}
	else
	{
		printf("Writing Error!\n");
		return 1;
	}
	return 0;
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

void Initialize() {
	short int i = 0;
  	//variable initialization
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

  	// Initialize SPI module


  	software_reset();                         // Activate software reset
  	RF_reset();                               // RF reset
  set_WAKE_from_pin();                      // Set wake from pin

  set_long_address(ADDRESS_long_2);         // Set long address
  set_short_address(ADDRESS_short_2);       // Set short address
  set_PAN_ID(PAN_ID_2);                     // Set PAN_ID

  init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
  nonbeacon_PAN_coordinator_device();
  set_TX_power(31);                         // Set max TX power
  set_frame_format_filter(1);               // 1 all frames, 3 data frame only
  set_reception_mode(1);                    // 1 normal mode

  pin_wake();                               // Wake from pin
}

int main(void)
{
	/*
	MYSQL *con = mysql_init(NULL);

	if (con == NULL) 
  	{
      		fprintf(stderr, "%s\n", mysql_error(con));
      		exit(1);
  	}  
  	// Connects to mysql database
	if (mysql_real_connect(con, "localhost", "bernardo", "bernardo", "storeddata", 0, NULL, 0) == NULL) // init var, server name, user, pass, db name 
  	{
      		fprintf(stderr, "%s\n", mysql_error(con));
  		mysql_close(con);
 	}
	*/
	
	libusb_device **list, *found = NULL;
	libusb_device_handle *handle = NULL;
	libusb_context *ctx = NULL;
	
	int r;
	ssize_t cnt, i, n, c=0;
	
	unsigned char SetCS[64], SetSpiS[64], TxSpi[64];
	unsigned char *SetChipSettings = SetCS, *SetSpiSettings = SetSpiS, *TransferSpiData = TxSpi;

	char dig1=0, dig2=0, dig3=0, degrees=0, battery=0;
		
		/* SET CHIP SETTINGS POWER-UP DEFAULT */
	SetChipSettings[0] = 0x60; // Set NVRAM Parameters Comand Code
	SetChipSettings[1] = 0x20; // Set Chip Settings
	SetChipSettings[2] = 0x00;
	SetChipSettings[3] = 0x00;
	SetChipSettings[4] = 0x00; //GP0 as GPIO =>RST
	SetChipSettings[5] = 0x00; //GP1 as GPIO =>WAKE
	for(n=6;n<13;n++)
	{
		SetChipSettings[n] = 0x01; // All GP's as Chip Select	
	}	
	SetChipSettings[13] = 0xFF; // GPIO Value
	SetChipSettings[14] = 0xFF;
	SetChipSettings[15] = 0xFF; // GPIO Direction
	SetChipSettings[16] = 0xFF;
	SetChipSettings[17] = 0x01; // Wake-up Disabled, No Interrupt Counting, SPI Bus is Released Between Transfer
	SetChipSettings[18] = 0x00; // Chip Settings not protected
	for(n=19;n<64;n++)
	{
		SetChipSettings[n] = 0x00; // Reserved	
	}
		/* SET SPI POWER-UP TRANSFER SETTINGS */
	SetSpiSettings[0] = 0x60; // Set NVRAM Parameters Comand Code
	SetSpiSettings[1] = 0x10; // Set SPI Transfer Settings
	SetSpiSettings[2] = 0x00; 
	SetSpiSettings[3] = 0x00;	
	SetSpiSettings[4] = 0x80; // 4 Bytes to configure Bit Rate
	SetSpiSettings[5] = 0x8D; 
	SetSpiSettings[6] = 0x5B; 
	SetSpiSettings[7] = 0x00; // 6.000.000 bps = 005B8D80 hex
	SetSpiSettings[8] = 0xFF; // Idle Chip Select Value
	SetSpiSettings[9] = 0xFF; 
	SetSpiSettings[10] = 0xFF; // Active Chip Select Value, GP4 = 0
	SetSpiSettings[11] = 0xFF; 
	SetSpiSettings[12] = 0x00; // Chip Select to Data Delay (low byte)
	SetSpiSettings[13] = 0x00; // Chip Select to Data Delay (high byte)
	SetSpiSettings[14] = 0x00; // Last Data Byte to CS (low byte)
	SetSpiSettings[15] = 0x00; // Last Data Byte to CS (high byte)
	SetSpiSettings[16] = 0x00; // Delay Between Subsequent Data Bytes (low byte)
	SetSpiSettings[17] = 0x00; // Delay Between Subsequent Data Bytes (high byte)
	SetSpiSettings[18] = 0x01; // Bytes to Transfer per SPI Transaction (low byte)
	SetSpiSettings[19] = 0x00; // Bytes to Transfer per SPI Transaction (high byte)
	SetSpiSettings[20] = 0x03; // SPI mode 3 - For communincation with PIC
	for(n=21;n<64;n++)
	{
		SetSpiSettings[n] = 0x00; // Reserved 
	}
		/* TRANSFER SPI DATA */
	TransferSpiData[0] = 0x42; // Transfer SPI Data Command Code
	TransferSpiData[1] = 0x01; // Number of bytes to be transferred
	TransferSpiData[2] = 0x00; 	
	TransferSpiData[3] = 0x00; // Reserved	
	TransferSpiData[4] = 0x00; // SPI data to be sent
	TransferSpiData[5] = 0xFF; 
	TransferSpiData[6] = 0xFF; 
	for(n=7;n<64;n++)
	{
		TransferSpiData[n] = 0xFF;  
	}
	
	Initialize();                      // Initialize MCU and Bee click board
	
	/**
	@brief libusb_init()
		Initialize library session.
	*/
	r = libusb_init(&ctx); // initialize library session
	if (r < 0)
		return r;
	/**
	@brief libusb_set_debug()
		Set log message verbosity.
	*/
	libusb_set_debug(ctx, 3);	
	/**
	@brief libusb_get_device_list()
		Get list of devices connected.
	*/
	cnt = libusb_get_device_list(ctx, &list); // get list of devices connected
	if (cnt < 0)
		return (int) cnt;

	for (i = 0; i < cnt; i++)
	{
		libusb_device *device = list[i];

		struct libusb_device_descriptor desc;
		/**
		@brief libusb_get_device_descriptor()
			Get device descriptor.
		*/
		libusb_get_device_descriptor(device, &desc); // get device descriptor
		
		if (desc.idVendor == DEV_VID && desc.idProduct == DEV_PID) 
		{
			found = device;
			printf("Found MCP2210 connected to the system!\n");
			break;
		}
	}	
	if (found)
	{
		/**
		@brief libusb_open_device_with_vid_pid()
			Try to get a handle to MCP2210 using corresponding VID and PID.
		*/
		handle = libusb_open_device_with_vid_pid(ctx, DEV_VID, DEV_PID); // try to get a handle to MCP2210 using corresponding VID and PID
		if(handle == NULL)
			printf("Error opening device!\n\t-ERROR CODE: %d\n",r);
		else
			printf("Device opened.\n\n"); 
	}
	else
	{
		printf("Device not found, exiting...\n");
		/**
		@brief libusb_free_device_list()
			Releases the device.
		*/
		libusb_free_device_list(list, 1);
		return 1;
	}

	libusb_free_device_list(list, 1); // releases the device
	
	if(libusb_kernel_driver_active(handle,0) == 1) // find out if kernel driver is attached
	{
		printf("\tKernel Driver Active, Detaching...\n");
		if(libusb_detach_kernel_driver(handle,0) == 0)
			printf("\t\t->Kernel Driver Detached!\n");
	}
	/**
	@brief libusb_claim_interface()
		Claim interface to MCP2210.
	*/
	r = libusb_claim_interface(handle,0); // claim interface 0 to MCP2210
	if(r<0)
	{
		printf("Could not claim interface, exiting...\n");
		libusb_close (handle); 	
		libusb_exit(ctx);
		return 1;
	}
	printf("\t->Claimed interface!\n");
		// First Step: Write command to Configure all GP's as CS
	r = transfer_data(handle, SetChipSettings, con);
	if(r == 1)
	{
		libusb_close (handle); 	
		libusb_exit(ctx);
		return 1;
	}
		// Second Step: Set SPI settings and select TC77 (GP7=0)
	r = transfer_data(handle, SetSpiSettings, con);
	if(r == 1)
	{
		libusb_close (handle); 	
		libusb_exit(ctx);
		return 1;
	}

	r = 0;
	// Third Step: Data read
	while(r != 3)
	{
		r = transfer_data(handle, TransferSpiData, con);
		sleep(1);
		if(r == 1) // error during communication
		{
			libusb_close (handle); 	
			libusb_exit(ctx);
			return 1;
		}
	}
	/**
	@brief libusb_release_interface()
		Release the claimed interface.
	*/
	r = libusb_release_interface(handle, 0); //release the claimed interface
	if(r!=0) 
	{
	        printf("Cannot Release Interface\n");
		libusb_close (handle); 	
		libusb_exit(ctx);
	        return 1;
	}
	printf("Released Interface\n");
	/**
	@brief libusb_close()
		Closes the library.
	*/
	libusb_close(handle); // closes the library	
	/**
	@brief libusb_exit()
		Exit context.
	*/
	libusb_exit(ctx); // exit context
	return 0;
}

