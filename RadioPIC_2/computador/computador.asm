
_write_ZIGBEE_short:
;computador.c,163 :: 		void write_ZIGBEE_short(short int address, short int data_r) {
;computador.c,164 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;computador.c,166 :: 		address = ((address << 1) & 0b01111111) | 0x01; // calculating addressing mode
	MOVF        FARG_write_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       127
	ANDWF       R0, 1 
	BSF         R0, 0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_address+0 
;computador.c,167 :: 		SPI1_Write(address);       // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;computador.c,168 :: 		SPI1_Write(data_r);        // write data in register
	MOVF        FARG_write_ZIGBEE_short_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;computador.c,170 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;computador.c,171 :: 		}
	RETURN      0
; end of _write_ZIGBEE_short

_read_ZIGBEE_short:
	CLRF        read_ZIGBEE_short_dummy_data_r_L0+0 
;computador.c,174 :: 		short int read_ZIGBEE_short(short int address) {
;computador.c,177 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;computador.c,179 :: 		address = (address << 1) & 0b01111110;      // calculating addressing mode
	MOVF        FARG_read_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       126
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_read_ZIGBEE_short_address+0 
;computador.c,180 :: 		SPI1_Write(address);                        // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;computador.c,181 :: 		data_r = SPI1_Read(dummy_data_r);           // read data from register
	MOVF        read_ZIGBEE_short_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;computador.c,183 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;computador.c,184 :: 		return data_r;
;computador.c,185 :: 		}
	RETURN      0
; end of _read_ZIGBEE_short

_write_ZIGBEE_long:
	CLRF        write_ZIGBEE_long_address_low_L0+0 
;computador.c,191 :: 		void write_ZIGBEE_long(int address, short int data_r) {
;computador.c,194 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;computador.c,196 :: 		address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;  // calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__write_ZIGBEE_long92:
	BZ          L__write_ZIGBEE_long93
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long92
L__write_ZIGBEE_long93:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;computador.c,197 :: 		address_low  = (((short int)(address << 5)) & 0b11100000) | 0x10;  // calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       write_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__write_ZIGBEE_long94:
	BZ          L__write_ZIGBEE_long95
	RLCF        write_ZIGBEE_long_address_low_L0+0, 1 
	BCF         write_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long94
L__write_ZIGBEE_long95:
	MOVLW       224
	ANDWF       write_ZIGBEE_long_address_low_L0+0, 1 
	BSF         write_ZIGBEE_long_address_low_L0+0, 4 
;computador.c,198 :: 		SPI1_Write(address_high);           // addressing register
	CALL        _SPI1_Write+0, 0
;computador.c,199 :: 		SPI1_Write(address_low);            // addressing register
	MOVF        write_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;computador.c,200 :: 		SPI1_Write(data_r);                 // write data in registerr
	MOVF        FARG_write_ZIGBEE_long_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;computador.c,202 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;computador.c,203 :: 		}
	RETURN      0
; end of _write_ZIGBEE_long

_read_ZIGBEE_long:
	CLRF        read_ZIGBEE_long_address_low_L0+0 
	CLRF        read_ZIGBEE_long_dummy_data_r_L0+0 
;computador.c,206 :: 		short int read_ZIGBEE_long(int address) {
;computador.c,210 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;computador.c,212 :: 		address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;  //calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__read_ZIGBEE_long96:
	BZ          L__read_ZIGBEE_long97
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long96
L__read_ZIGBEE_long97:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;computador.c,213 :: 		address_low  = ((short int)(address << 5) & 0b11100000);         //calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       read_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__read_ZIGBEE_long98:
	BZ          L__read_ZIGBEE_long99
	RLCF        read_ZIGBEE_long_address_low_L0+0, 1 
	BCF         read_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long98
L__read_ZIGBEE_long99:
	MOVLW       224
	ANDWF       read_ZIGBEE_long_address_low_L0+0, 1 
;computador.c,214 :: 		SPI1_Write(address_high);            // addressing register
	CALL        _SPI1_Write+0, 0
;computador.c,215 :: 		SPI1_Write(address_low);             // addressing register
	MOVF        read_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;computador.c,216 :: 		data_r = SPI1_Read(dummy_data_r);    // read data from register
	MOVF        read_ZIGBEE_long_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;computador.c,218 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;computador.c,219 :: 		return data_r;
;computador.c,220 :: 		}
	RETURN      0
; end of _read_ZIGBEE_long

_start_transmit:
;computador.c,225 :: 		void start_transmit() {
;computador.c,230 :: 		write_ZIGBEE_short(TXNCON, 0b00000101);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       5
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,231 :: 		}
	RETURN      0
; end of _start_transmit

_read_RX_FIFO:
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
;computador.c,236 :: 		void read_RX_FIFO() {
;computador.c,240 :: 		temp = read_ZIGBEE_short(BBREG1);      // disable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,241 :: 		temp = temp | 0x04;                    // mask for disable receiving packets
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,242 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,244 :: 		for(i=0; i<128; i++) {
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
L_read_RX_FIFO0:
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO100
	MOVLW       128
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO100:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO1
;computador.c,245 :: 		if(i <  (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO101
	MOVLW       32
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO101:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO3
;computador.c,246 :: 		data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);  // reading valid data from RX FIFO
	MOVLW       _data_RX_FIFO+0
	ADDWF       read_RX_FIFO_i_L0+0, 0 
	MOVWF       FLOC__read_RX_FIFO+0 
	MOVLW       hi_addr(_data_RX_FIFO+0
	ADDWFC      read_RX_FIFO_i_L0+1, 0 
	MOVWF       FLOC__read_RX_FIFO+1 
	MOVF        read_RX_FIFO_i_L0+0, 0 
	ADDWF       _address_RX_FIFO+0, 0 
	MOVWF       FARG_read_ZIGBEE_long_address+0 
	MOVF        read_RX_FIFO_i_L0+1, 0 
	ADDWFC      _address_RX_FIFO+1, 0 
	MOVWF       FARG_read_ZIGBEE_long_address+1 
	CALL        _read_ZIGBEE_long+0, 0
	MOVFF       FLOC__read_RX_FIFO+0, FSR1L
	MOVFF       FLOC__read_RX_FIFO+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_read_RX_FIFO3:
;computador.c,247 :: 		if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO102
	MOVLW       32
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO102:
	BTFSS       STATUS+0, 0 
	GOTO        L_read_RX_FIFO4
;computador.c,248 :: 		lost_data = read_ZIGBEE_long(address_RX_FIFO + i);        // reading invalid data from RX FIFO
	MOVF        read_RX_FIFO_i_L0+0, 0 
	ADDWF       _address_RX_FIFO+0, 0 
	MOVWF       FARG_read_ZIGBEE_long_address+0 
	MOVF        read_RX_FIFO_i_L0+1, 0 
	ADDWFC      _address_RX_FIFO+1, 0 
	MOVWF       FARG_read_ZIGBEE_long_address+1 
	CALL        _read_ZIGBEE_long+0, 0
	MOVF        R0, 0 
	MOVWF       _lost_data+0 
L_read_RX_FIFO4:
;computador.c,244 :: 		for(i=0; i<128; i++) {
	INFSNZ      read_RX_FIFO_i_L0+0, 1 
	INCF        read_RX_FIFO_i_L0+1, 1 
;computador.c,249 :: 		}
	GOTO        L_read_RX_FIFO0
L_read_RX_FIFO1:
;computador.c,251 :: 		SN =  data_RX_FIFO[3];      //ler o sequence number
	MOVF        _data_RX_FIFO+3, 0 
	MOVWF       _SN+0 
;computador.c,253 :: 		DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];               // coping valid data
	MOVF        _data_RX_FIFO+12, 0 
	MOVWF       _DATA_RX+0 
;computador.c,254 :: 		DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];               // coping valid data
	MOVF        _data_RX_FIFO+13, 0 
	MOVWF       _DATA_RX+1 
;computador.c,255 :: 		DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];               // coping valid data
	MOVF        _data_RX_FIFO+14, 0 
	MOVWF       _DATA_RX+2 
;computador.c,256 :: 		DATA_RX[3] = data_RX_FIFO[HEADER_LENGHT + 4];               // coping valid data
	MOVF        _data_RX_FIFO+15, 0 
	MOVWF       _DATA_RX+3 
;computador.c,257 :: 		DATA_RX[4] = data_RX_FIFO[HEADER_LENGHT + 5];               // coping valid data
	MOVF        _data_RX_FIFO+16, 0 
	MOVWF       _DATA_RX+4 
;computador.c,258 :: 		DATA_RX[5] = data_RX_FIFO[HEADER_LENGHT + 6];               // coping valid data
	MOVF        _data_RX_FIFO+17, 0 
	MOVWF       _DATA_RX+5 
;computador.c,259 :: 		DATA_RX[6] = data_RX_FIFO[HEADER_LENGHT + 7];               // coping valid data
	MOVF        _data_RX_FIFO+18, 0 
	MOVWF       _DATA_RX+6 
;computador.c,260 :: 		DATA_RX[7] = data_RX_FIFO[HEADER_LENGHT + 8];               // coping valid data
	MOVF        _data_RX_FIFO+19, 0 
	MOVWF       _DATA_RX+7 
;computador.c,261 :: 		DATA_RX[8] = data_RX_FIFO[HEADER_LENGHT + 9];               // coping valid data
	MOVF        _data_RX_FIFO+20, 0 
	MOVWF       _DATA_RX+8 
;computador.c,262 :: 		DATA_RX[9] = data_RX_FIFO[HEADER_LENGHT + 10];               // coping valid data
	MOVF        _data_RX_FIFO+21, 0 
	MOVWF       _DATA_RX+9 
;computador.c,263 :: 		DATA_RX[10] = data_RX_FIFO[HEADER_LENGHT + 11];               // coping valid data
	MOVF        _data_RX_FIFO+22, 0 
	MOVWF       _DATA_RX+10 
;computador.c,264 :: 		DATA_RX[11] = data_RX_FIFO[HEADER_LENGHT + 12];               // coping valid data
	MOVF        _data_RX_FIFO+23, 0 
	MOVWF       _DATA_RX+11 
;computador.c,265 :: 		DATA_RX[12] = data_RX_FIFO[HEADER_LENGHT + 13];               // coping valid data
	MOVF        _data_RX_FIFO+24, 0 
	MOVWF       _DATA_RX+12 
;computador.c,266 :: 		DATA_RX[13] = data_RX_FIFO[HEADER_LENGHT + 14];               // coping valid data
	MOVF        _data_RX_FIFO+25, 0 
	MOVWF       _DATA_RX+13 
;computador.c,267 :: 		DATA_RX[14] = data_RX_FIFO[HEADER_LENGHT + 15];               // coping valid data
	MOVF        _data_RX_FIFO+26, 0 
	MOVWF       _DATA_RX+14 
;computador.c,268 :: 		DATA_RX[15] = data_RX_FIFO[HEADER_LENGHT + 16];               // coping valid data
	MOVF        _data_RX_FIFO+27, 0 
	MOVWF       _DATA_RX+15 
;computador.c,270 :: 		LQI   = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];  // coping valid data
	MOVF        _data_RX_FIFO+30, 0 
	MOVWF       _LQI+0 
;computador.c,271 :: 		RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];  // coping valid data
	MOVF        _data_RX_FIFO+31, 0 
	MOVWF       _RSSI2+0 
;computador.c,273 :: 		temp = read_ZIGBEE_short(BBREG1);      // enable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,274 :: 		temp = temp & (!0x04);                 // mask for enable receiving
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,275 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,276 :: 		}
	RETURN      0
; end of _read_RX_FIFO

_set_ACK:
;computador.c,281 :: 		void set_ACK(void){
;computador.c,284 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,285 :: 		temp = temp | 0x04;                   // 0x04 mask for set ACK
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,286 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,287 :: 		}
	RETURN      0
; end of _set_ACK

_set_not_ACK:
;computador.c,289 :: 		void set_not_ACK(void){
;computador.c,292 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,293 :: 		temp = temp & (!0x04);                // 0x04 mask for set not ACK
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,294 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,295 :: 		}
	RETURN      0
; end of _set_not_ACK

_Frame_ACK:
;computador.c,296 :: 		void Frame_ACK(void){
;computador.c,299 :: 		temp = read_ZIGBEE_short(ACKTMOUT);
	MOVLW       18
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,300 :: 		temp = temp | 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,301 :: 		write_ZIGBEE_short(ACKTMOUT, temp);
	MOVLW       18
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,302 :: 		}
	RETURN      0
; end of _Frame_ACK

_set_ACK_recipient:
;computador.c,304 :: 		void set_ACK_recipient(void){
;computador.c,307 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,308 :: 		temp = temp & 0xDF;
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,309 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,310 :: 		}
	RETURN      0
; end of _set_ACK_recipient

_set_encrypt:
;computador.c,316 :: 		void set_encrypt(void){
;computador.c,319 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,320 :: 		temp = temp | 0x02;                   // mask for set encrypt
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,321 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,322 :: 		}
	RETURN      0
; end of _set_encrypt

_set_not_encrypt:
;computador.c,324 :: 		void set_not_encrypt(void){
;computador.c,327 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,328 :: 		temp = temp & (!0x02);                // mask for set not encrypt
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,329 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,330 :: 		}
	RETURN      0
; end of _set_not_encrypt

_write_TX_normal_FIFO:
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
;computador.c,332 :: 		void write_TX_normal_FIFO() {
;computador.c,335 :: 		data_TX_normal_FIFO[0]  = HEADER_LENGHT;
	MOVLW       11
	MOVWF       _data_TX_normal_FIFO+0 
;computador.c,336 :: 		data_TX_normal_FIFO[1]  = HEADER_LENGHT + DATA_LENGHT;
	MOVLW       27
	MOVWF       _data_TX_normal_FIFO+1 
;computador.c,337 :: 		data_TX_normal_FIFO[2]  = 0x21;                        // control frame
	MOVLW       33
	MOVWF       _data_TX_normal_FIFO+2 
;computador.c,338 :: 		data_TX_normal_FIFO[3]  = 0x88;
	MOVLW       136
	MOVWF       _data_TX_normal_FIFO+3 
;computador.c,339 :: 		data_TX_normal_FIFO[4]  = SEQ_NUMBER;                  // sequence number
	MOVF        _SEQ_NUMBER+0, 0 
	MOVWF       _data_TX_normal_FIFO+4 
;computador.c,340 :: 		data_TX_normal_FIFO[5]  = PAN_ID_2[1];                 // destinatoin pan
	MOVF        _PAN_ID_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+5 
;computador.c,341 :: 		data_TX_normal_FIFO[6]  = PAN_ID_2[0];
	MOVF        _PAN_ID_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+6 
;computador.c,342 :: 		data_TX_normal_FIFO[7]  = ADDRESS_short_2[0];          // destination address
	MOVF        _ADDRESS_short_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+7 
;computador.c,343 :: 		data_TX_normal_FIFO[8]  = ADDRESS_short_2[1];
	MOVF        _ADDRESS_short_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+8 
;computador.c,344 :: 		data_TX_normal_FIFO[9]  = PAN_ID_1[0];                 // source pan
	MOVF        _PAN_ID_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+9 
;computador.c,345 :: 		data_TX_normal_FIFO[10] = PAN_ID_1[1];
	MOVF        _PAN_ID_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+10 
;computador.c,346 :: 		data_TX_normal_FIFO[11] = ADDRESS_short_1[0];          // source address
	MOVF        _ADDRESS_short_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+11 
;computador.c,347 :: 		data_TX_normal_FIFO[12] = ADDRESS_short_1[1];
	MOVF        _ADDRESS_short_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+12 
;computador.c,349 :: 		data_TX_normal_FIFO[13] = DATA_TX[0];                  // data
	MOVF        _DATA_TX+0, 0 
	MOVWF       _data_TX_normal_FIFO+13 
;computador.c,350 :: 		data_TX_normal_FIFO[14] = DATA_TX[1];                  // data
	MOVF        _DATA_TX+1, 0 
	MOVWF       _data_TX_normal_FIFO+14 
;computador.c,351 :: 		data_TX_normal_FIFO[15] = DATA_TX[2];                  // data
	MOVF        _DATA_TX+2, 0 
	MOVWF       _data_TX_normal_FIFO+15 
;computador.c,352 :: 		data_TX_normal_FIFO[16] = DATA_TX[3];                  // data
	MOVF        _DATA_TX+3, 0 
	MOVWF       _data_TX_normal_FIFO+16 
;computador.c,353 :: 		data_TX_normal_FIFO[17] = DATA_TX[4];                  // data
	MOVF        _DATA_TX+4, 0 
	MOVWF       _data_TX_normal_FIFO+17 
;computador.c,354 :: 		data_TX_normal_FIFO[18] = DATA_TX[5];                  // data
	MOVF        _DATA_TX+5, 0 
	MOVWF       _data_TX_normal_FIFO+18 
;computador.c,355 :: 		data_TX_normal_FIFO[19] = DATA_TX[6];                  // data
	MOVF        _DATA_TX+6, 0 
	MOVWF       _data_TX_normal_FIFO+19 
;computador.c,356 :: 		data_TX_normal_FIFO[20] = DATA_TX[7];                  // data
	MOVF        _DATA_TX+7, 0 
	MOVWF       _data_TX_normal_FIFO+20 
;computador.c,357 :: 		data_TX_normal_FIFO[21] = DATA_TX[8];                  // data
	MOVF        _DATA_TX+8, 0 
	MOVWF       _data_TX_normal_FIFO+21 
;computador.c,358 :: 		data_TX_normal_FIFO[22] = DATA_TX[9];                  // data
	MOVF        _DATA_TX+9, 0 
	MOVWF       _data_TX_normal_FIFO+22 
;computador.c,359 :: 		data_TX_normal_FIFO[23] = DATA_TX[10];                  // data
	MOVF        _DATA_TX+10, 0 
	MOVWF       _data_TX_normal_FIFO+23 
;computador.c,360 :: 		data_TX_normal_FIFO[24] = DATA_TX[11];                  // data
	MOVF        _DATA_TX+11, 0 
	MOVWF       _data_TX_normal_FIFO+24 
;computador.c,361 :: 		data_TX_normal_FIFO[25] = DATA_TX[12];                  // data
	MOVF        _DATA_TX+12, 0 
	MOVWF       _data_TX_normal_FIFO+25 
;computador.c,362 :: 		data_TX_normal_FIFO[26] = DATA_TX[13];                  // data
	MOVF        _DATA_TX+13, 0 
	MOVWF       _data_TX_normal_FIFO+26 
;computador.c,363 :: 		data_TX_normal_FIFO[27] = DATA_TX[14];                  // data
	MOVF        _DATA_TX+14, 0 
	MOVWF       _data_TX_normal_FIFO+27 
;computador.c,364 :: 		data_TX_normal_FIFO[28] = DATA_TX[15];                  // data
	MOVF        _DATA_TX+15, 0 
	MOVWF       _data_TX_normal_FIFO+28 
;computador.c,367 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
L_write_TX_normal_FIFO5:
	MOVLW       128
	XORWF       write_TX_normal_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_TX_normal_FIFO103
	MOVLW       29
	SUBWF       write_TX_normal_FIFO_i_L0+0, 0 
L__write_TX_normal_FIFO103:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_TX_normal_FIFO6
;computador.c,368 :: 		write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]); // write frame into normal FIFO
	MOVF        write_TX_normal_FIFO_i_L0+0, 0 
	ADDWF       _address_TX_normal_FIFO+0, 0 
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVF        write_TX_normal_FIFO_i_L0+1, 0 
	ADDWFC      _address_TX_normal_FIFO+1, 0 
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       _data_TX_normal_FIFO+0
	ADDWF       write_TX_normal_FIFO_i_L0+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_data_TX_normal_FIFO+0
	ADDWFC      write_TX_normal_FIFO_i_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,367 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	INFSNZ      write_TX_normal_FIFO_i_L0+0, 1 
	INCF        write_TX_normal_FIFO_i_L0+1, 1 
;computador.c,369 :: 		}
	GOTO        L_write_TX_normal_FIFO5
L_write_TX_normal_FIFO6:
;computador.c,373 :: 		start_transmit();
	CALL        _start_transmit+0, 0
;computador.c,374 :: 		}
	RETURN      0
; end of _write_TX_normal_FIFO

_pin_reset:
;computador.c,382 :: 		void pin_reset() {
;computador.c,383 :: 		RST = 0;  // activate reset
	BCF         LATC1_bit+0, 1 
;computador.c,384 :: 		Delay_ms(5);
	MOVLW       17
	MOVWF       R12, 0
	MOVLW       58
	MOVWF       R13, 0
L_pin_reset8:
	DECFSZ      R13, 1, 0
	BRA         L_pin_reset8
	DECFSZ      R12, 1, 0
	BRA         L_pin_reset8
	NOP
;computador.c,385 :: 		RST = 1;  // deactivate reset
	BSF         LATC1_bit+0, 1 
;computador.c,386 :: 		Delay_ms(5);
	MOVLW       17
	MOVWF       R12, 0
	MOVLW       58
	MOVWF       R13, 0
L_pin_reset9:
	DECFSZ      R13, 1, 0
	BRA         L_pin_reset9
	DECFSZ      R12, 1, 0
	BRA         L_pin_reset9
	NOP
;computador.c,387 :: 		}
	RETURN      0
; end of _pin_reset

_PWR_reset:
;computador.c,389 :: 		void PWR_reset() {
;computador.c,390 :: 		write_ZIGBEE_short(SOFTRST, 0x04);   // 0x04  mask for RSTPWR bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       4
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,391 :: 		}
	RETURN      0
; end of _PWR_reset

_BB_reset:
;computador.c,393 :: 		void BB_reset() {
;computador.c,394 :: 		write_ZIGBEE_short(SOFTRST, 0x02);   // 0x02 mask for RSTBB bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,395 :: 		}
	RETURN      0
; end of _BB_reset

_MAC_reset:
;computador.c,397 :: 		void MAC_reset() {
;computador.c,398 :: 		write_ZIGBEE_short(SOFTRST, 0x01);   // 0x01 mask for RSTMAC bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,399 :: 		}
	RETURN      0
; end of _MAC_reset

_software_reset:
;computador.c,401 :: 		void software_reset() {                // PWR_reset,BB_reset and MAC_reset at once
;computador.c,402 :: 		write_ZIGBEE_short(SOFTRST, 0x07);
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,403 :: 		}
	RETURN      0
; end of _software_reset

_RF_reset:
	CLRF        RF_reset_temp_L0+0 
;computador.c,405 :: 		void RF_reset() {
;computador.c,407 :: 		temp = read_ZIGBEE_short(RFCTL);
	MOVLW       54
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;computador.c,408 :: 		temp = temp | 0x04;                  // mask for RFRST bit
	BSF         R0, 2 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;computador.c,409 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,410 :: 		temp = temp & (!0x04);               // mask for RFRST bit
	MOVLW       0
	ANDWF       RF_reset_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;computador.c,411 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,412 :: 		Delay_ms(1);
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       61
	MOVWF       R13, 0
L_RF_reset10:
	DECFSZ      R13, 1, 0
	BRA         L_RF_reset10
	DECFSZ      R12, 1, 0
	BRA         L_RF_reset10
	NOP
	NOP
;computador.c,413 :: 		}
	RETURN      0
; end of _RF_reset

_enable_interrupt:
;computador.c,418 :: 		void enable_interrupt() {
;computador.c,419 :: 		write_ZIGBEE_short(INTCON_M, 0x00);   // 0x00  all interrupts are enable
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CLRF        FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,420 :: 		}
	RETURN      0
; end of _enable_interrupt

_set_channel:
;computador.c,425 :: 		void set_channel(short int channel_number) {               // 11-26 possible channels
;computador.c,426 :: 		if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
	MOVLW       128
	XORLW       26
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel90
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       11
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel90
	GOTO        L_set_channel13
L__set_channel90:
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
L_set_channel13:
;computador.c,427 :: 		switch(channel_number) {
	GOTO        L_set_channel14
;computador.c,428 :: 		case 11:
L_set_channel16:
;computador.c,429 :: 		write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,430 :: 		break;
	GOTO        L_set_channel15
;computador.c,431 :: 		case 12:
L_set_channel17:
;computador.c,432 :: 		write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       18
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,433 :: 		break;
	GOTO        L_set_channel15
;computador.c,434 :: 		case 13:
L_set_channel18:
;computador.c,435 :: 		write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,436 :: 		break;
	GOTO        L_set_channel15
;computador.c,437 :: 		case 14:
L_set_channel19:
;computador.c,438 :: 		write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,439 :: 		break;
	GOTO        L_set_channel15
;computador.c,440 :: 		case 15:
L_set_channel20:
;computador.c,441 :: 		write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       66
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,442 :: 		break;
	GOTO        L_set_channel15
;computador.c,443 :: 		case 16:
L_set_channel21:
;computador.c,444 :: 		write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       82
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,445 :: 		break;
	GOTO        L_set_channel15
;computador.c,446 :: 		case 17:
L_set_channel22:
;computador.c,447 :: 		write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       98
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,448 :: 		break;
	GOTO        L_set_channel15
;computador.c,449 :: 		case 18:
L_set_channel23:
;computador.c,450 :: 		write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       114
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,451 :: 		break;
	GOTO        L_set_channel15
;computador.c,452 :: 		case 19:
L_set_channel24:
;computador.c,453 :: 		write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       130
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,454 :: 		break;
	GOTO        L_set_channel15
;computador.c,455 :: 		case 20:
L_set_channel25:
;computador.c,456 :: 		write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       146
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,457 :: 		break;
	GOTO        L_set_channel15
;computador.c,458 :: 		case 21:
L_set_channel26:
;computador.c,459 :: 		write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       162
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,460 :: 		break;
	GOTO        L_set_channel15
;computador.c,461 :: 		case 22:
L_set_channel27:
;computador.c,462 :: 		write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       178
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,463 :: 		break;
	GOTO        L_set_channel15
;computador.c,464 :: 		case 23:
L_set_channel28:
;computador.c,465 :: 		write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       194
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,466 :: 		break;
	GOTO        L_set_channel15
;computador.c,467 :: 		case 24:
L_set_channel29:
;computador.c,468 :: 		write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       210
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,469 :: 		break;
	GOTO        L_set_channel15
;computador.c,470 :: 		case 25:
L_set_channel30:
;computador.c,471 :: 		write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       226
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,472 :: 		break;
	GOTO        L_set_channel15
;computador.c,473 :: 		case 26:
L_set_channel31:
;computador.c,474 :: 		write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       242
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,475 :: 		break;
	GOTO        L_set_channel15
;computador.c,476 :: 		}
L_set_channel14:
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel16
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel17
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel18
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel19
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel20
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel21
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel22
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       18
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel23
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       19
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel24
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel25
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel26
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       22
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel27
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       23
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel28
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       24
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel29
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       25
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel30
	MOVF        FARG_set_channel_channel_number+0, 0 
	XORLW       26
	BTFSC       STATUS+0, 2 
	GOTO        L_set_channel31
L_set_channel15:
;computador.c,477 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;computador.c,478 :: 		}
	RETURN      0
; end of _set_channel

_set_CCA_mode:
;computador.c,483 :: 		void set_CCA_mode(short int CCA_mode) {
;computador.c,485 :: 		switch(CCA_mode) {
	GOTO        L_set_CCA_mode32
;computador.c,486 :: 		case 1: {                               // ENERGY ABOVE THRESHOLD
L_set_CCA_mode34:
;computador.c,487 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,488 :: 		temp = temp | 0x80;                   // 0x80 mask
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,489 :: 		temp = temp & 0xDF;                   // 0xDF mask
	MOVLW       223
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;computador.c,490 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,491 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,493 :: 		break;
	GOTO        L_set_CCA_mode33
;computador.c,495 :: 		case 2: {                               // CARRIER SENSE ONLY
L_set_CCA_mode35:
;computador.c,496 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,497 :: 		temp = temp | 0x40;                   // 0x40 mask
	MOVLW       64
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,498 :: 		temp = temp & 0x7F;                   // 0x7F mask
	MOVLW       127
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;computador.c,499 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,501 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,502 :: 		temp = temp | 0x38;
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,503 :: 		temp = temp & 0xFB;
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;computador.c,504 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,506 :: 		break;
	GOTO        L_set_CCA_mode33
;computador.c,508 :: 		case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
L_set_CCA_mode36:
;computador.c,509 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,510 :: 		temp = temp | 0xC0;                   // 0xC0 mask
	MOVLW       192
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,511 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,513 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,514 :: 		temp = temp | 0x38;                   // 0x38 mask
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,515 :: 		temp = temp & 0xFB;                   // 0xFB mask
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;computador.c,516 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,518 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,520 :: 		break;
	GOTO        L_set_CCA_mode33
;computador.c,521 :: 		}
L_set_CCA_mode32:
	MOVF        FARG_set_CCA_mode_CCA_mode+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_set_CCA_mode34
	MOVF        FARG_set_CCA_mode_CCA_mode+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_set_CCA_mode35
	MOVF        FARG_set_CCA_mode_CCA_mode+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_set_CCA_mode36
L_set_CCA_mode33:
;computador.c,522 :: 		}
	RETURN      0
; end of _set_CCA_mode

_set_RSSI_mode:
;computador.c,527 :: 		void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
;computador.c,530 :: 		switch(RSSI_mode) {
	GOTO        L_set_RSSI_mode37
;computador.c,531 :: 		case 1: {
L_set_RSSI_mode39:
;computador.c,532 :: 		temp = read_ZIGBEE_short(BBREG6);
	MOVLW       62
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,533 :: 		temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,534 :: 		write_ZIGBEE_short(BBREG6, temp);
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,536 :: 		break;
	GOTO        L_set_RSSI_mode38
;computador.c,538 :: 		case 2:
L_set_RSSI_mode40:
;computador.c,539 :: 		write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       64
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,540 :: 		break;
	GOTO        L_set_RSSI_mode38
;computador.c,541 :: 		}
L_set_RSSI_mode37:
	MOVF        FARG_set_RSSI_mode_RSSI_mode+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_set_RSSI_mode39
	MOVF        FARG_set_RSSI_mode_RSSI_mode+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_set_RSSI_mode40
L_set_RSSI_mode38:
;computador.c,542 :: 		}
	RETURN      0
; end of _set_RSSI_mode

_nonbeacon_PAN_coordinator_device:
;computador.c,547 :: 		void nonbeacon_PAN_coordinator_device() {
;computador.c,550 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,551 :: 		temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,552 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,554 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,555 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,556 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,558 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,559 :: 		}
	RETURN      0
; end of _nonbeacon_PAN_coordinator_device

_nonbeacon_coordinator_device:
;computador.c,561 :: 		void nonbeacon_coordinator_device() {
;computador.c,564 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,565 :: 		temp = temp | 0x04;                 // 0x04 mask for coordinator
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,566 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,568 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,569 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,570 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,572 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,573 :: 		}
	RETURN      0
; end of _nonbeacon_coordinator_device

_nonbeacon_device:
;computador.c,575 :: 		void nonbeacon_device() {
;computador.c,578 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,579 :: 		temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
	MOVLW       243
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,580 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,582 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,583 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,584 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,585 :: 		}
	RETURN      0
; end of _nonbeacon_device

_set_IFS_recomended:
;computador.c,594 :: 		void set_IFS_recomended() {
;computador.c,597 :: 		write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       147
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,599 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,600 :: 		temp = temp | 0x7C;                 // MinLIFSPeriod
	MOVLW       124
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,601 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,603 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,604 :: 		temp = temp | 0x90;                 // MinLIFSPeriod
	MOVLW       144
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,605 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,607 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,608 :: 		temp = temp | 0x31;                 // TurnaroundTime
	MOVLW       49
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,609 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,610 :: 		}
	RETURN      0
; end of _set_IFS_recomended

_set_IFS_default:
;computador.c,612 :: 		void set_IFS_default() {
;computador.c,615 :: 		write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       117
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,617 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,618 :: 		temp = temp | 0x84;                 // Min LIFS Period
	MOVLW       132
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,619 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,621 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,622 :: 		temp = temp | 0x50;                 // Min LIFS Period
	MOVLW       80
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,623 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,625 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,626 :: 		temp = temp | 0x41;                 // Turnaround Time
	MOVLW       65
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,627 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,628 :: 		}
	RETURN      0
; end of _set_IFS_default

_set_reception_mode:
;computador.c,633 :: 		void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
;computador.c,636 :: 		switch(r_mode) {
	GOTO        L_set_reception_mode41
;computador.c,637 :: 		case 1: {
L_set_reception_mode43:
;computador.c,638 :: 		temp = read_ZIGBEE_short(RXMCR);      // normal mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,639 :: 		temp = temp & (!0x03);                // mask for normal mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,640 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,642 :: 		break;
	GOTO        L_set_reception_mode42
;computador.c,644 :: 		case 2: {
L_set_reception_mode44:
;computador.c,645 :: 		temp = read_ZIGBEE_short(RXMCR);      // error mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,646 :: 		temp = temp & (!0x01);                // mask for error mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,647 :: 		temp = temp | 0x02;                   // mask for error mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;computador.c,648 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,650 :: 		break;
	GOTO        L_set_reception_mode42
;computador.c,652 :: 		case 3: {
L_set_reception_mode45:
;computador.c,653 :: 		temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,654 :: 		temp = temp & (!0x02);                // mask for promiscuous mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,655 :: 		temp = temp | 0x01;                   // mask for promiscuous mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 0 
;computador.c,656 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,658 :: 		break;
	GOTO        L_set_reception_mode42
;computador.c,659 :: 		}
L_set_reception_mode41:
	MOVF        FARG_set_reception_mode_r_mode+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_set_reception_mode43
	MOVF        FARG_set_reception_mode_r_mode+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_set_reception_mode44
	MOVF        FARG_set_reception_mode_r_mode+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_set_reception_mode45
L_set_reception_mode42:
;computador.c,660 :: 		}
	RETURN      0
; end of _set_reception_mode

_set_frame_format_filter:
;computador.c,665 :: 		void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
;computador.c,668 :: 		switch(fff_mode) {
	GOTO        L_set_frame_format_filter46
;computador.c,669 :: 		case 1: {
L_set_frame_format_filter48:
;computador.c,670 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // all frames
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,671 :: 		temp = temp & (!0x0E);                  // mask for all frames
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,672 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,674 :: 		break;
	GOTO        L_set_frame_format_filter47
;computador.c,676 :: 		case 2: {
L_set_frame_format_filter49:
;computador.c,677 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // command only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,678 :: 		temp = temp & (!0x06);                  // mask for command only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,679 :: 		temp = temp | 0x08;                     // mask for command only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 3 
;computador.c,680 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,682 :: 		break;
	GOTO        L_set_frame_format_filter47
;computador.c,684 :: 		case 3: {
L_set_frame_format_filter50:
;computador.c,685 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // data only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,686 :: 		temp = temp & (!0x0A);                  // mask for data only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,687 :: 		temp = temp | 0x04;                     // mask for data only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 2 
;computador.c,688 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,690 :: 		break;
	GOTO        L_set_frame_format_filter47
;computador.c,692 :: 		case 4: {
L_set_frame_format_filter51:
;computador.c,693 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,694 :: 		temp = temp & (!0x0C);                  // mask for beacon only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,695 :: 		temp = temp | 0x02;                     // mask for beacon only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;computador.c,696 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,698 :: 		break;
	GOTO        L_set_frame_format_filter47
;computador.c,699 :: 		}
L_set_frame_format_filter46:
	MOVF        FARG_set_frame_format_filter_fff_mode+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_set_frame_format_filter48
	MOVF        FARG_set_frame_format_filter_fff_mode+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_set_frame_format_filter49
	MOVF        FARG_set_frame_format_filter_fff_mode+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_set_frame_format_filter50
	MOVF        FARG_set_frame_format_filter_fff_mode+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_set_frame_format_filter51
L_set_frame_format_filter47:
;computador.c,700 :: 		}
	RETURN      0
; end of _set_frame_format_filter

_flush_RX_FIFO_pointer:
;computador.c,705 :: 		void flush_RX_FIFO_pointer() {
;computador.c,708 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,709 :: 		temp = temp | 0x01;                        // mask for flush RX FIFO
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,710 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,711 :: 		}
	RETURN      0
; end of _flush_RX_FIFO_pointer

_set_short_address:
;computador.c,716 :: 		void set_short_address(short int * address) {
;computador.c,717 :: 		write_ZIGBEE_short(SADRL, address[0]);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_short_address_address+0, FSR0L
	MOVFF       FARG_set_short_address_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,718 :: 		write_ZIGBEE_short(SADRH, address[1]);
	MOVLW       4
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       1
	ADDWF       FARG_set_short_address_address+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_set_short_address_address+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,719 :: 		}
	RETURN      0
; end of _set_short_address

_set_long_address:
	CLRF        set_long_address_i_L0+0 
;computador.c,721 :: 		void set_long_address(short int * address) {
;computador.c,724 :: 		for(i = 0; i < 8; i++) {
	CLRF        set_long_address_i_L0+0 
L_set_long_address52:
	MOVLW       128
	XORWF       set_long_address_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_set_long_address53
;computador.c,725 :: 		write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
	MOVF        set_long_address_i_L0+0, 0 
	ADDLW       5
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        set_long_address_i_L0+0, 0 
	ADDWF       FARG_set_long_address_address+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	BTFSC       set_long_address_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FARG_set_long_address_address+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,724 :: 		for(i = 0; i < 8; i++) {
	INCF        set_long_address_i_L0+0, 1 
;computador.c,726 :: 		}
	GOTO        L_set_long_address52
L_set_long_address53:
;computador.c,727 :: 		}
	RETURN      0
; end of _set_long_address

_set_PAN_ID:
;computador.c,729 :: 		void set_PAN_ID(short int * address) {
;computador.c,730 :: 		write_ZIGBEE_short(PANIDL, address[0]);
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_PAN_ID_address+0, FSR0L
	MOVFF       FARG_set_PAN_ID_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,731 :: 		write_ZIGBEE_short(PANIDH, address[1]);
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       1
	ADDWF       FARG_set_PAN_ID_address+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_set_PAN_ID_address+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,732 :: 		}
	RETURN      0
; end of _set_PAN_ID

_set_wake_from_pin:
;computador.c,737 :: 		void set_wake_from_pin() {
;computador.c,740 :: 		WAKE = 0;
	BCF         LATC2_bit+0, 2 
;computador.c,741 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,742 :: 		temp = temp | 0x60;                     // mask
	MOVLW       96
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,743 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,745 :: 		temp = read_ZIGBEE_short(WAKECON);
	MOVLW       34
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;computador.c,746 :: 		temp = temp | 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;computador.c,747 :: 		write_ZIGBEE_short(WAKECON, temp);
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,748 :: 		}
	RETURN      0
; end of _set_wake_from_pin

_pin_wake:
;computador.c,750 :: 		void pin_wake() {
;computador.c,751 :: 		WAKE = 1;
	BSF         LATC2_bit+0, 2 
;computador.c,752 :: 		Delay_ms(5);
	MOVLW       17
	MOVWF       R12, 0
	MOVLW       58
	MOVWF       R13, 0
L_pin_wake55:
	DECFSZ      R13, 1, 0
	BRA         L_pin_wake55
	DECFSZ      R12, 1, 0
	BRA         L_pin_wake55
	NOP
;computador.c,753 :: 		}
	RETURN      0
; end of _pin_wake

_enable_PLL:
;computador.c,758 :: 		void enable_PLL() {
;computador.c,759 :: 		write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,760 :: 		}
	RETURN      0
; end of _enable_PLL

_disable_PLL:
;computador.c,762 :: 		void disable_PLL() {
;computador.c,763 :: 		write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	CLRF        FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,764 :: 		}
	RETURN      0
; end of _disable_PLL

_set_TX_power:
;computador.c,769 :: 		void set_TX_power(unsigned short int power) {             // 0-31 possible variants
;computador.c,770 :: 		if((power < 0) || (power > 31))
	MOVLW       0
	SUBWF       FARG_set_TX_power_power+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power91
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power91
	GOTO        L_set_TX_power58
L__set_TX_power91:
;computador.c,771 :: 		power = 31;
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
L_set_TX_power58:
;computador.c,772 :: 		power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_set_TX_power_power+0 
;computador.c,773 :: 		power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
	MOVLW       31
	ANDWF       R0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       248
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_set_TX_power_power+0 
;computador.c,774 :: 		write_ZIGBEE_long(RFCON3, power);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,775 :: 		}
	RETURN      0
; end of _set_TX_power

_init_ZIGBEE_basic:
;computador.c,780 :: 		void init_ZIGBEE_basic() {
;computador.c,781 :: 		write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
	MOVLW       24
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       152
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,782 :: 		write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       149
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;computador.c,783 :: 		write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,784 :: 		enable_PLL();                       // Enable PLL (PLLEN = 1)
	CALL        _enable_PLL+0, 0
;computador.c,785 :: 		write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
	MOVLW       6
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       144
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,786 :: 		write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,787 :: 		write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
	MOVLW       8
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,788 :: 		write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
	MOVLW       32
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;computador.c,789 :: 		}
	RETURN      0
; end of _init_ZIGBEE_basic

_init_ZIGBEE_nonbeacon:
;computador.c,791 :: 		void init_ZIGBEE_nonbeacon() {
;computador.c,792 :: 		init_ZIGBEE_basic();
	CALL        _init_ZIGBEE_basic+0, 0
;computador.c,793 :: 		set_CCA_mode(1);     // Set CCA mode to ED and set threshold
	MOVLW       1
	MOVWF       FARG_set_CCA_mode_CCA_mode+0 
	CALL        _set_CCA_mode+0, 0
;computador.c,794 :: 		set_RSSI_mode(2);    // RSSI2 mode
	MOVLW       2
	MOVWF       FARG_set_RSSI_mode_RSSI_mode+0 
	CALL        _set_RSSI_mode+0, 0
;computador.c,795 :: 		enable_interrupt();  // Enables all interrupts
	CALL        _enable_interrupt+0, 0
;computador.c,796 :: 		set_channel(11);     // Channel 11
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
	CALL        _set_channel+0, 0
;computador.c,797 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;computador.c,798 :: 		}
	RETURN      0
; end of _init_ZIGBEE_nonbeacon

_Debounce_INT:
	CLRF        Debounce_INT_intn_d_L0+0 
	CLRF        Debounce_INT_j_L0+0 
	CLRF        Debounce_INT_i_L0+0 
;computador.c,800 :: 		char Debounce_INT() {
;computador.c,802 :: 		for(i = 0; i < 5; i++) {
	CLRF        Debounce_INT_i_L0+0 
L_Debounce_INT59:
	MOVLW       5
	SUBWF       Debounce_INT_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT60
;computador.c,803 :: 		intn_d = INT;
	MOVLW       0
	BTFSC       RC6_bit+0, 6 
	MOVLW       1
	MOVWF       Debounce_INT_intn_d_L0+0 
;computador.c,804 :: 		if (intn_d == 1)
	MOVF        Debounce_INT_intn_d_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Debounce_INT62
;computador.c,805 :: 		j++;
	INCF        Debounce_INT_j_L0+0, 1 
L_Debounce_INT62:
;computador.c,802 :: 		for(i = 0; i < 5; i++) {
	INCF        Debounce_INT_i_L0+0, 1 
;computador.c,806 :: 		}
	GOTO        L_Debounce_INT59
L_Debounce_INT60:
;computador.c,807 :: 		if (j > 2)
	MOVF        Debounce_INT_j_L0+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT63
;computador.c,808 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_Debounce_INT63:
;computador.c,810 :: 		return 0;
	CLRF        R0 
;computador.c,811 :: 		}
	RETURN      0
; end of _Debounce_INT

_Initialize:
	CLRF        Initialize_i_L0+0 
;computador.c,813 :: 		void Initialize() {
;computador.c,816 :: 		LQI = 0;
	CLRF        _LQI+0 
;computador.c,817 :: 		RSSI2 = 0;
	CLRF        _RSSI2+0 
;computador.c,818 :: 		SEQ_NUMBER = 0x64;
	MOVLW       100
	MOVWF       _SEQ_NUMBER+0 
;computador.c,819 :: 		lost_data = 0;
	CLRF        _lost_data+0 
;computador.c,820 :: 		address_RX_FIFO = 0x300;
	MOVLW       0
	MOVWF       _address_RX_FIFO+0 
	MOVLW       3
	MOVWF       _address_RX_FIFO+1 
;computador.c,821 :: 		address_TX_normal_FIFO = 0;
	CLRF        _address_TX_normal_FIFO+0 
	CLRF        _address_TX_normal_FIFO+1 
;computador.c,823 :: 		for (i = 0; i < 2; i++) {
	CLRF        Initialize_i_L0+0 
L_Initialize65:
	MOVLW       128
	XORWF       Initialize_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Initialize66
;computador.c,824 :: 		ADDRESS_short_1[i] = 1;
	MOVLW       _ADDRESS_short_1+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_ADDRESS_short_1+0
	MOVWF       FSR1H 
	MOVF        Initialize_i_L0+0, 0 
	ADDWF       FSR1L, 1 
	MOVLW       0
	BTFSC       Initialize_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;computador.c,825 :: 		ADDRESS_short_2[i] = 2;
	MOVLW       _ADDRESS_short_2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_ADDRESS_short_2+0
	MOVWF       FSR1H 
	MOVF        Initialize_i_L0+0, 0 
	ADDWF       FSR1L, 1 
	MOVLW       0
	BTFSC       Initialize_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;computador.c,826 :: 		PAN_ID_1[i] = 3;
	MOVLW       _PAN_ID_1+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_PAN_ID_1+0
	MOVWF       FSR1H 
	MOVF        Initialize_i_L0+0, 0 
	ADDWF       FSR1L, 1 
	MOVLW       0
	BTFSC       Initialize_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;computador.c,827 :: 		PAN_ID_2[i] = 3;
	MOVLW       _PAN_ID_2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_PAN_ID_2+0
	MOVWF       FSR1H 
	MOVF        Initialize_i_L0+0, 0 
	ADDWF       FSR1L, 1 
	MOVLW       0
	BTFSC       Initialize_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       3
	MOVWF       POSTINC1+0 
;computador.c,823 :: 		for (i = 0; i < 2; i++) {
	INCF        Initialize_i_L0+0, 1 
;computador.c,828 :: 		}
	GOTO        L_Initialize65
L_Initialize66:
;computador.c,830 :: 		for (i = 0; i < 8; i++) {
	CLRF        Initialize_i_L0+0 
L_Initialize68:
	MOVLW       128
	XORWF       Initialize_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Initialize69
;computador.c,831 :: 		ADDRESS_long_1[i] = 1;
	MOVLW       _ADDRESS_long_1+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_ADDRESS_long_1+0
	MOVWF       FSR1H 
	MOVF        Initialize_i_L0+0, 0 
	ADDWF       FSR1L, 1 
	MOVLW       0
	BTFSC       Initialize_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       1
	MOVWF       POSTINC1+0 
;computador.c,832 :: 		ADDRESS_long_2[i] = 2;
	MOVLW       _ADDRESS_long_2+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(_ADDRESS_long_2+0
	MOVWF       FSR1H 
	MOVF        Initialize_i_L0+0, 0 
	ADDWF       FSR1L, 1 
	MOVLW       0
	BTFSC       Initialize_i_L0+0, 7 
	MOVLW       255
	ADDWFC      FSR1H, 1 
	MOVLW       2
	MOVWF       POSTINC1+0 
;computador.c,830 :: 		for (i = 0; i < 8; i++) {
	INCF        Initialize_i_L0+0, 1 
;computador.c,833 :: 		}
	GOTO        L_Initialize68
L_Initialize69:
;computador.c,835 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;computador.c,836 :: 		GIE_bit = 0;           // Disable interrupts
	BCF         GIE_bit+0, 7 
;computador.c,838 :: 		TRISA = 0x00;          // Set direction to be output
	CLRF        TRISA+0 
;computador.c,839 :: 		TRISB = 0x00;          // Set direction to be output
	CLRF        TRISB+0 
;computador.c,840 :: 		TRISC = 0x00;          // Set direction to be output
	CLRF        TRISC+0 
;computador.c,841 :: 		TRISD = 0x00;          // Set direction to be output
	CLRF        TRISD+0 
;computador.c,843 :: 		CS2_Direction = 0;      // Set direction to be output
	BCF         TRISC0_bit+0, 0 
;computador.c,844 :: 		RST_Direction  = 0;    // Set direction to be output
	BCF         TRISC1_bit+0, 1 
;computador.c,845 :: 		INT_Direction  = 1;    // Set direction to be input
	BSF         TRISC6_bit+0, 6 
;computador.c,846 :: 		WAKE_Direction = 0;    // Set direction to be output
	BCF         TRISC2_bit+0, 2 
;computador.c,848 :: 		DATA_TX[0] = 0;        // Initialize first byte
	CLRF        _DATA_TX+0 
;computador.c,849 :: 		DATA_TX[1] = 0;        // Initialize first byte
	CLRF        _DATA_TX+1 
;computador.c,850 :: 		DATA_TX[2] = 0;        // Initialize first byte
	CLRF        _DATA_TX+2 
;computador.c,851 :: 		DATA_TX[3] = 0;        // Initialize first byte
	CLRF        _DATA_TX+3 
;computador.c,852 :: 		DATA_TX[4] = 0;        // Initialize first byte
	CLRF        _DATA_TX+4 
;computador.c,854 :: 		PORTD = 0;             // Clear PORTD register
	CLRF        PORTD+0 
;computador.c,855 :: 		LATD  = 0;             // Clear LATD register
	CLRF        LATD+0 
;computador.c,857 :: 		Delay_ms(15);
	MOVLW       49
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_Initialize71:
	DECFSZ      R13, 1, 0
	BRA         L_Initialize71
	DECFSZ      R12, 1, 0
	BRA         L_Initialize71
	NOP
;computador.c,859 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;computador.c,860 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;computador.c,861 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;computador.c,864 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;computador.c,865 :: 		pin_reset();                              // Activate reset from pin
	CALL        _pin_reset+0, 0
;computador.c,866 :: 		software_reset();                         // Activate software reset
	CALL        _software_reset+0, 0
;computador.c,867 :: 		RF_reset();                               // RF reset
	CALL        _RF_reset+0, 0
;computador.c,868 :: 		set_WAKE_from_pin();                      // Set wake from pin
	CALL        _set_wake_from_pin+0, 0
;computador.c,870 :: 		set_long_address(ADDRESS_long_2);         // Set long address
	MOVLW       _ADDRESS_long_2+0
	MOVWF       FARG_set_long_address_address+0 
	MOVLW       hi_addr(_ADDRESS_long_2+0
	MOVWF       FARG_set_long_address_address+1 
	CALL        _set_long_address+0, 0
;computador.c,871 :: 		set_short_address(ADDRESS_short_2);       // Set short address
	MOVLW       _ADDRESS_short_2+0
	MOVWF       FARG_set_short_address_address+0 
	MOVLW       hi_addr(_ADDRESS_short_2+0
	MOVWF       FARG_set_short_address_address+1 
	CALL        _set_short_address+0, 0
;computador.c,872 :: 		set_PAN_ID(PAN_ID_2);                     // Set PAN_ID
	MOVLW       _PAN_ID_2+0
	MOVWF       FARG_set_PAN_ID_address+0 
	MOVLW       hi_addr(_PAN_ID_2+0
	MOVWF       FARG_set_PAN_ID_address+1 
	CALL        _set_PAN_ID+0, 0
;computador.c,874 :: 		init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
	CALL        _init_ZIGBEE_nonbeacon+0, 0
;computador.c,875 :: 		nonbeacon_PAN_coordinator_device();
	CALL        _nonbeacon_PAN_coordinator_device+0, 0
;computador.c,876 :: 		set_TX_power(31);                         // Set max TX power
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
	CALL        _set_TX_power+0, 0
;computador.c,877 :: 		set_frame_format_filter(1);               // 1 all frames, 3 data frame only
	MOVLW       1
	MOVWF       FARG_set_frame_format_filter_fff_mode+0 
	CALL        _set_frame_format_filter+0, 0
;computador.c,878 :: 		set_reception_mode(1);                    // 1 normal mode
	MOVLW       1
	MOVWF       FARG_set_reception_mode_r_mode+0 
	CALL        _set_reception_mode+0, 0
;computador.c,880 :: 		pin_wake();                               // Wake from pin
	CALL        _pin_wake+0, 0
;computador.c,881 :: 		}
	RETURN      0
; end of _Initialize

_main:
	MOVLW       1
	MOVWF       main_trans_L0+0 
	CLRF        main_repPack_L0+0 
	CLRF        main_cond_L0+0 
	CLRF        main_cont_L0+0 
	MOVLW       1
	MOVWF       main_i_L0+0 
	CLRF        main_lastSN_L0+0 
	CLRF        main_lastBat_L0+0 
	CLRF        main_lastDeg_L0+0 
	CLRF        main_lastD3_L0+0 
	CLRF        main_lastD2_L0+0 
	MOVLW       255
	MOVWF       main_lastD1_L0+0 
	CLRF        main_seqN_L0+0 
	CLRF        main_d2_L0+0 
	CLRF        main_d1_L0+0 
;computador.c,883 :: 		void main() {
;computador.c,891 :: 		Initialize();                      // Initialize MCU and Bee click board
	CALL        _Initialize+0, 0
;computador.c,892 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;computador.c,897 :: 		while(1) {
L_main72:
;computador.c,898 :: 		if(trans == 0){
	MOVF        main_trans_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main74
;computador.c,899 :: 		Lcd_Chr(2,5,'b');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;computador.c,900 :: 		if(Debounce_INT() == 0 ){
	CALL        _Debounce_INT+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main75
;computador.c,901 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
	MOVLW       49
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       _temp1+0 
;computador.c,902 :: 		read_RX_FIFO();                     // Read receive data
	CALL        _read_RX_FIFO+0, 0
;computador.c,903 :: 		d1=DATA_RX[15];
	MOVF        _DATA_RX+15, 0 
	MOVWF       main_d1_L0+0 
;computador.c,904 :: 		d2=DATA_RX[1];
	MOVF        _DATA_RX+1, 0 
	MOVWF       main_d2_L0+0 
;computador.c,908 :: 		cond = 1;
	MOVLW       1
	MOVWF       main_cond_L0+0 
;computador.c,910 :: 		}
	GOTO        L_main76
L_main75:
;computador.c,911 :: 		else if(cond > 0){
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	BTFSC       main_cond_L0+0, 7 
	MOVLW       127
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main104
	MOVF        main_cond_L0+0, 0 
	SUBLW       0
L__main104:
	BTFSC       STATUS+0, 0 
	GOTO        L_main77
;computador.c,912 :: 		Delay_us(910);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       243
	MOVWF       R13, 0
L_main78:
	DECFSZ      R13, 1, 0
	BRA         L_main78
	DECFSZ      R12, 1, 0
	BRA         L_main78
	NOP
;computador.c,913 :: 		cond ++;
	INCF        main_cond_L0+0, 1 
;computador.c,914 :: 		if(cond == 100){
	MOVF        main_cond_L0+0, 0 
	XORLW       100
	BTFSS       STATUS+0, 2 
	GOTO        L_main79
;computador.c,915 :: 		trans = 1;
	MOVLW       1
	MOVWF       main_trans_L0+0 
;computador.c,916 :: 		Initialize();                      // Initialize MCU and Bee click board
	CALL        _Initialize+0, 0
;computador.c,917 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;computador.c,918 :: 		Lcd_Chr(2,1,'b');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       98
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;computador.c,919 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;computador.c,920 :: 		}
L_main79:
;computador.c,921 :: 		}
	GOTO        L_main80
L_main77:
;computador.c,923 :: 		Delay_us(910);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       243
	MOVWF       R13, 0
L_main81:
	DECFSZ      R13, 1, 0
	BRA         L_main81
	DECFSZ      R12, 1, 0
	BRA         L_main81
	NOP
;computador.c,924 :: 		cond2++;
	INFSNZ      main_cond2_L0+0, 1 
	INCF        main_cond2_L0+1, 1 
;computador.c,925 :: 		Lcd_Chr(1,5,'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;computador.c,926 :: 		if(cond2 == 1500){
	MOVF        main_cond2_L0+1, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVLW       220
	XORWF       main_cond2_L0+0, 0 
L__main105:
	BTFSS       STATUS+0, 2 
	GOTO        L_main82
;computador.c,927 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;computador.c,928 :: 		Delay_ms(1000);
	MOVLW       13
	MOVWF       R11, 0
	MOVLW       175
	MOVWF       R12, 0
	MOVLW       182
	MOVWF       R13, 0
L_main83:
	DECFSZ      R13, 1, 0
	BRA         L_main83
	DECFSZ      R12, 1, 0
	BRA         L_main83
	DECFSZ      R11, 1, 0
	BRA         L_main83
	NOP
;computador.c,929 :: 		trans = 1;
	MOVLW       1
	MOVWF       main_trans_L0+0 
;computador.c,930 :: 		}
L_main82:
;computador.c,931 :: 		}
L_main80:
L_main76:
;computador.c,933 :: 		} //final trans = 0
L_main74:
;computador.c,934 :: 		if(trans == 1){
	MOVF        main_trans_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main84
;computador.c,935 :: 		Delay_ms(3000);
	MOVLW       39
	MOVWF       R11, 0
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       38
	MOVWF       R13, 0
L_main85:
	DECFSZ      R13, 1, 0
	BRA         L_main85
	DECFSZ      R12, 1, 0
	BRA         L_main85
	DECFSZ      R11, 1, 0
	BRA         L_main85
	NOP
;computador.c,937 :: 		DATA_TX[0]='3';
	MOVLW       51
	MOVWF       _DATA_TX+0 
;computador.c,938 :: 		DATA_TX[1]=dig2;
	MOVF        _dig2+0, 0 
	MOVWF       _DATA_TX+1 
;computador.c,939 :: 		DATA_TX[2]=dig3;
	MOVF        _dig3+0, 0 
	MOVWF       _DATA_TX+2 
;computador.c,940 :: 		DATA_TX[3]=degrees;
	MOVF        _degrees+0, 0 
	MOVWF       _DATA_TX+3 
;computador.c,941 :: 		DATA_TX[4]=battery;
	MOVF        _battery+0, 0 
	MOVWF       _DATA_TX+4 
;computador.c,942 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;computador.c,943 :: 		i = read_ZIGBEE_short(TXSTAT);
	MOVLW       36
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       main_i_L0+0 
;computador.c,945 :: 		SEQ_NUMBER++;
	INCF        _SEQ_NUMBER+0, 1 
;computador.c,947 :: 		if((i & 1) == 0){
	MOVLW       1
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVLW       0
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVLW       0
	XORWF       R1, 0 
L__main106:
	BTFSS       STATUS+0, 2 
	GOTO        L_main86
;computador.c,948 :: 		trans = 0;
	CLRF        main_trans_L0+0 
;computador.c,949 :: 		cond = 0;
	CLRF        main_cond_L0+0 
;computador.c,950 :: 		cond2 = 0;
	CLRF        main_cond2_L0+0 
	CLRF        main_cond2_L0+1 
;computador.c,951 :: 		Initialize();
	CALL        _Initialize+0, 0
;computador.c,952 :: 		Lcd_Chr(1,1,'a');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       97
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;computador.c,953 :: 		Delay_ms(900);
	MOVLW       12
	MOVWF       R11, 0
	MOVLW       107
	MOVWF       R12, 0
	MOVLW       9
	MOVWF       R13, 0
L_main87:
	DECFSZ      R13, 1, 0
	BRA         L_main87
	DECFSZ      R12, 1, 0
	BRA         L_main87
	DECFSZ      R11, 1, 0
	BRA         L_main87
	NOP
	NOP
;computador.c,954 :: 		}
	GOTO        L_main88
L_main86:
;computador.c,955 :: 		else if((i & 1) == 1){
	MOVLW       1
	ANDWF       main_i_L0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main89
;computador.c,956 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;computador.c,957 :: 		Lcd_Chr(1,1,d1);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        main_d1_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;computador.c,958 :: 		Lcd_Chr(1,2,d2);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        main_d2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;computador.c,959 :: 		}
L_main89:
L_main88:
;computador.c,960 :: 		}   //final trans ==1
L_main84:
;computador.c,961 :: 		}//final while
	GOTO        L_main72
;computador.c,962 :: 		}
	GOTO        $+0
; end of _main
