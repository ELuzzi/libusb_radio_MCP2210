
_write_ZIGBEE_short:
;sensor.c,179 :: 		void write_ZIGBEE_short(short int address, short int data_r) {
;sensor.c,180 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;sensor.c,182 :: 		address = ((address << 1) & 0b01111111) | 0x01; // calculating addressing mode
	MOVF        FARG_write_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       127
	ANDWF       R0, 1 
	BSF         R0, 0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_address+0 
;sensor.c,183 :: 		SPI1_Write(address);       // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;sensor.c,184 :: 		SPI1_Write(data_r);        // write data in register
	MOVF        FARG_write_ZIGBEE_short_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;sensor.c,186 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;sensor.c,187 :: 		}
	RETURN      0
; end of _write_ZIGBEE_short

_read_ZIGBEE_short:
	CLRF        read_ZIGBEE_short_dummy_data_r_L0+0 
;sensor.c,190 :: 		short int read_ZIGBEE_short(short int address) {
;sensor.c,193 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;sensor.c,195 :: 		address = (address << 1) & 0b01111110;      // calculating addressing mode
	MOVF        FARG_read_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       126
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_read_ZIGBEE_short_address+0 
;sensor.c,196 :: 		SPI1_Write(address);                        // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;sensor.c,197 :: 		data_r = SPI1_Read(dummy_data_r);           // read data from register
	MOVF        read_ZIGBEE_short_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;sensor.c,199 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;sensor.c,200 :: 		return data_r;
;sensor.c,201 :: 		}
	RETURN      0
; end of _read_ZIGBEE_short

_write_ZIGBEE_long:
	CLRF        write_ZIGBEE_long_address_low_L0+0 
;sensor.c,207 :: 		void write_ZIGBEE_long(int address, short int data_r) {
;sensor.c,210 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;sensor.c,212 :: 		address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;  // calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__write_ZIGBEE_long205:
	BZ          L__write_ZIGBEE_long206
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long205
L__write_ZIGBEE_long206:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;sensor.c,213 :: 		address_low  = (((short int)(address << 5)) & 0b11100000) | 0x10;  // calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       write_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__write_ZIGBEE_long207:
	BZ          L__write_ZIGBEE_long208
	RLCF        write_ZIGBEE_long_address_low_L0+0, 1 
	BCF         write_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long207
L__write_ZIGBEE_long208:
	MOVLW       224
	ANDWF       write_ZIGBEE_long_address_low_L0+0, 1 
	BSF         write_ZIGBEE_long_address_low_L0+0, 4 
;sensor.c,214 :: 		SPI1_Write(address_high);           // addressing register
	CALL        _SPI1_Write+0, 0
;sensor.c,215 :: 		SPI1_Write(address_low);            // addressing register
	MOVF        write_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;sensor.c,216 :: 		SPI1_Write(data_r);                 // write data in registerr
	MOVF        FARG_write_ZIGBEE_long_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;sensor.c,218 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;sensor.c,219 :: 		}
	RETURN      0
; end of _write_ZIGBEE_long

_read_ZIGBEE_long:
	CLRF        read_ZIGBEE_long_address_low_L0+0 
	CLRF        read_ZIGBEE_long_dummy_data_r_L0+0 
;sensor.c,222 :: 		short int read_ZIGBEE_long(int address) {
;sensor.c,226 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;sensor.c,228 :: 		address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;  //calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__read_ZIGBEE_long209:
	BZ          L__read_ZIGBEE_long210
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long209
L__read_ZIGBEE_long210:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;sensor.c,229 :: 		address_low  = ((short int)(address << 5) & 0b11100000);         //calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       read_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__read_ZIGBEE_long211:
	BZ          L__read_ZIGBEE_long212
	RLCF        read_ZIGBEE_long_address_low_L0+0, 1 
	BCF         read_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long211
L__read_ZIGBEE_long212:
	MOVLW       224
	ANDWF       read_ZIGBEE_long_address_low_L0+0, 1 
;sensor.c,230 :: 		SPI1_Write(address_high);            // addressing register
	CALL        _SPI1_Write+0, 0
;sensor.c,231 :: 		SPI1_Write(address_low);             // addressing register
	MOVF        read_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;sensor.c,232 :: 		data_r = SPI1_Read(dummy_data_r);    // read data from register
	MOVF        read_ZIGBEE_long_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;sensor.c,234 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;sensor.c,235 :: 		return data_r;
;sensor.c,236 :: 		}
	RETURN      0
; end of _read_ZIGBEE_long

_start_transmit:
;sensor.c,241 :: 		void start_transmit() {
;sensor.c,244 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,245 :: 		temp = temp | 0x01;                 // mask for start transmit
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,246 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,247 :: 		}
	RETURN      0
; end of _start_transmit

_read_RX_FIFO:
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
;sensor.c,252 :: 		void read_RX_FIFO() {
;sensor.c,256 :: 		temp = read_ZIGBEE_short(BBREG1);      // disable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,257 :: 		temp = temp | 0x04;                    // mask for disable receiving packets
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,258 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,260 :: 		for(i=0; i<128; i++) {
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
L_read_RX_FIFO0:
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO213
	MOVLW       128
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO213:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO1
;sensor.c,261 :: 		if(i <  (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO214
	MOVLW       21
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO214:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO3
;sensor.c,262 :: 		data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);  // reading valid data from RX FIFO
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
;sensor.c,263 :: 		if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO215
	MOVLW       21
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO215:
	BTFSS       STATUS+0, 0 
	GOTO        L_read_RX_FIFO4
;sensor.c,264 :: 		lost_data = read_ZIGBEE_long(address_RX_FIFO + i);        // reading invalid data from RX FIFO
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
;sensor.c,260 :: 		for(i=0; i<128; i++) {
	INFSNZ      read_RX_FIFO_i_L0+0, 1 
	INCF        read_RX_FIFO_i_L0+1, 1 
;sensor.c,265 :: 		}
	GOTO        L_read_RX_FIFO0
L_read_RX_FIFO1:
;sensor.c,267 :: 		DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];               // coping valid data
	MOVF        _data_RX_FIFO+12, 0 
	MOVWF       _DATA_RX+0 
;sensor.c,268 :: 		DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];               // coping valid data
	MOVF        _data_RX_FIFO+13, 0 
	MOVWF       _DATA_RX+1 
;sensor.c,269 :: 		DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];               // coping valid data
	MOVF        _data_RX_FIFO+14, 0 
	MOVWF       _DATA_RX+2 
;sensor.c,270 :: 		DATA_RX[3] = data_RX_FIFO[HEADER_LENGHT + 4];               // coping valid data
	MOVF        _data_RX_FIFO+15, 0 
	MOVWF       _DATA_RX+3 
;sensor.c,271 :: 		DATA_RX[4] = data_RX_FIFO[HEADER_LENGHT + 5];               // coping valid data
	MOVF        _data_RX_FIFO+16, 0 
	MOVWF       _DATA_RX+4 
;sensor.c,273 :: 		LQI   = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];  // coping valid data
	MOVF        _data_RX_FIFO+19, 0 
	MOVWF       _LQI+0 
;sensor.c,274 :: 		RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];  // coping valid data
	MOVF        _data_RX_FIFO+20, 0 
	MOVWF       _RSSI2+0 
;sensor.c,276 :: 		temp = read_ZIGBEE_short(BBREG1);      // enable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,277 :: 		temp = temp & (!0x04);                 // mask for enable receiving
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,278 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,279 :: 		}
	RETURN      0
; end of _read_RX_FIFO

_set_ACK:
	CLRF        set_ACK_temp_L0+0 
;sensor.c,284 :: 		void set_ACK(void){
;sensor.c,289 :: 		write_ZIGBEE_short(TXNCON, 0b00000101);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       5
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,290 :: 		}
	RETURN      0
; end of _set_ACK

_set_not_ACK:
;sensor.c,292 :: 		void set_not_ACK(void){
;sensor.c,295 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,296 :: 		temp = temp & (!0x04);                // 0x04 mask for set not ACK
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,297 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,298 :: 		}
	RETURN      0
; end of _set_not_ACK

_Frame_ACK:
;sensor.c,300 :: 		void Frame_ACK(void){
;sensor.c,303 :: 		temp = read_ZIGBEE_short(ACKTMOUT);
	MOVLW       18
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,304 :: 		temp = temp | 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,305 :: 		write_ZIGBEE_short(ACKTMOUT, temp);
	MOVLW       18
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,306 :: 		}
	RETURN      0
; end of _Frame_ACK

_set_encrypt:
;sensor.c,311 :: 		void set_encrypt(void){
;sensor.c,314 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,315 :: 		temp = temp | 0x02;                   // mask for set encrypt
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,316 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,317 :: 		}
	RETURN      0
; end of _set_encrypt

_set_not_encrypt:
;sensor.c,319 :: 		void set_not_encrypt(void){
;sensor.c,322 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,323 :: 		temp = temp & (!0x02);                // mask for set not encrypt
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,324 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,325 :: 		}
	RETURN      0
; end of _set_not_encrypt

_write_TX_normal_FIFO:
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
;sensor.c,327 :: 		void write_TX_normal_FIFO() {
;sensor.c,330 :: 		data_TX_normal_FIFO[0]  = HEADER_LENGHT;
	MOVLW       11
	MOVWF       _data_TX_normal_FIFO+0 
;sensor.c,331 :: 		data_TX_normal_FIFO[1]  = HEADER_LENGHT + DATA_LENGHT;
	MOVLW       16
	MOVWF       _data_TX_normal_FIFO+1 
;sensor.c,332 :: 		data_TX_normal_FIFO[2]  = 0x21;                        // control frame
	MOVLW       33
	MOVWF       _data_TX_normal_FIFO+2 
;sensor.c,333 :: 		data_TX_normal_FIFO[3]  = 0x88;
	MOVLW       136
	MOVWF       _data_TX_normal_FIFO+3 
;sensor.c,334 :: 		data_TX_normal_FIFO[4]  = SEQ_NUMBER;                  // sequence number
	MOVF        _SEQ_NUMBER+0, 0 
	MOVWF       _data_TX_normal_FIFO+4 
;sensor.c,335 :: 		data_TX_normal_FIFO[5]  = PAN_ID_2[1];                 // destinatoin pan
	MOVF        _PAN_ID_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+5 
;sensor.c,336 :: 		data_TX_normal_FIFO[6]  = PAN_ID_2[0];
	MOVF        _PAN_ID_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+6 
;sensor.c,337 :: 		data_TX_normal_FIFO[7]  = ADDRESS_short_2[0];          // destination address
	MOVF        _ADDRESS_short_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+7 
;sensor.c,338 :: 		data_TX_normal_FIFO[8]  = ADDRESS_short_2[1];
	MOVF        _ADDRESS_short_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+8 
;sensor.c,339 :: 		data_TX_normal_FIFO[9]  = PAN_ID_1[0];                 // source pan
	MOVF        _PAN_ID_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+9 
;sensor.c,340 :: 		data_TX_normal_FIFO[10] = PAN_ID_1[1];
	MOVF        _PAN_ID_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+10 
;sensor.c,341 :: 		data_TX_normal_FIFO[11] = ADDRESS_short_1[0];          // source address
	MOVF        _ADDRESS_short_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+11 
;sensor.c,342 :: 		data_TX_normal_FIFO[12] = ADDRESS_short_1[1];
	MOVF        _ADDRESS_short_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+12 
;sensor.c,344 :: 		data_TX_normal_FIFO[13] = DATA_TX[0];                  // data
	MOVF        _DATA_TX+0, 0 
	MOVWF       _data_TX_normal_FIFO+13 
;sensor.c,345 :: 		data_TX_normal_FIFO[14] = DATA_TX[1];                  // data
	MOVF        _DATA_TX+1, 0 
	MOVWF       _data_TX_normal_FIFO+14 
;sensor.c,346 :: 		data_TX_normal_FIFO[15] = DATA_TX[2];                  // data
	MOVF        _DATA_TX+2, 0 
	MOVWF       _data_TX_normal_FIFO+15 
;sensor.c,347 :: 		data_TX_normal_FIFO[16] = DATA_TX[3];                  // data
	MOVF        _DATA_TX+3, 0 
	MOVWF       _data_TX_normal_FIFO+16 
;sensor.c,348 :: 		data_TX_normal_FIFO[17] = DATA_TX[4];                  // data
	MOVF        _DATA_TX+4, 0 
	MOVWF       _data_TX_normal_FIFO+17 
;sensor.c,350 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
L_write_TX_normal_FIFO5:
	MOVLW       128
	XORWF       write_TX_normal_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_TX_normal_FIFO216
	MOVLW       18
	SUBWF       write_TX_normal_FIFO_i_L0+0, 0 
L__write_TX_normal_FIFO216:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_TX_normal_FIFO6
;sensor.c,351 :: 		write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]); // write frame into normal FIFO
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
;sensor.c,350 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	INFSNZ      write_TX_normal_FIFO_i_L0+0, 1 
	INCF        write_TX_normal_FIFO_i_L0+1, 1 
;sensor.c,352 :: 		}
	GOTO        L_write_TX_normal_FIFO5
L_write_TX_normal_FIFO6:
;sensor.c,355 :: 		set_ACK();
	CALL        _set_ACK+0, 0
;sensor.c,358 :: 		}
	RETURN      0
; end of _write_TX_normal_FIFO

_pin_reset:
;sensor.c,366 :: 		void pin_reset() {
;sensor.c,367 :: 		RST = 0;  // activate reset
	BCF         LATC1_bit+0, 1 
;sensor.c,368 :: 		Delay_ms(5);
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
;sensor.c,369 :: 		RST = 1;  // deactivate reset
	BSF         LATC1_bit+0, 1 
;sensor.c,370 :: 		Delay_ms(5);
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
;sensor.c,371 :: 		}
	RETURN      0
; end of _pin_reset

_PWR_reset:
;sensor.c,373 :: 		void PWR_reset() {
;sensor.c,374 :: 		write_ZIGBEE_short(SOFTRST, 0x04);   // 0x04  mask for RSTPWR bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       4
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,375 :: 		}
	RETURN      0
; end of _PWR_reset

_BB_reset:
;sensor.c,377 :: 		void BB_reset() {
;sensor.c,378 :: 		write_ZIGBEE_short(SOFTRST, 0x02);   // 0x02 mask for RSTBB bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,379 :: 		}
	RETURN      0
; end of _BB_reset

_MAC_reset:
;sensor.c,381 :: 		void MAC_reset() {
;sensor.c,382 :: 		write_ZIGBEE_short(SOFTRST, 0x01);   // 0x01 mask for RSTMAC bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,383 :: 		}
	RETURN      0
; end of _MAC_reset

_software_reset:
;sensor.c,385 :: 		void software_reset() {                // PWR_reset,BB_reset and MAC_reset at once
;sensor.c,386 :: 		write_ZIGBEE_short(SOFTRST, 0x07);
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,387 :: 		}
	RETURN      0
; end of _software_reset

_RF_reset:
	CLRF        RF_reset_temp_L0+0 
;sensor.c,389 :: 		void RF_reset() {
;sensor.c,391 :: 		temp = read_ZIGBEE_short(RFCTL);
	MOVLW       54
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;sensor.c,392 :: 		temp = temp | 0x04;                  // mask for RFRST bit
	BSF         R0, 2 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;sensor.c,393 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,394 :: 		temp = temp & (!0x04);               // mask for RFRST bit
	MOVLW       0
	ANDWF       RF_reset_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;sensor.c,395 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,396 :: 		Delay_ms(1);
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
;sensor.c,397 :: 		}
	RETURN      0
; end of _RF_reset

_enable_interrupt:
;sensor.c,402 :: 		void enable_interrupt() {
;sensor.c,403 :: 		write_ZIGBEE_short(INTCON_M, 0x00);   // 0x00  all interrupts are enable
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CLRF        FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,404 :: 		}
	RETURN      0
; end of _enable_interrupt

_set_channel:
;sensor.c,409 :: 		void set_channel(short int channel_number) {               // 11-26 possible channels
;sensor.c,410 :: 		if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
	MOVLW       128
	XORLW       26
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel188
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       11
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel188
	GOTO        L_set_channel13
L__set_channel188:
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
L_set_channel13:
;sensor.c,411 :: 		switch(channel_number) {
	GOTO        L_set_channel14
;sensor.c,412 :: 		case 11:
L_set_channel16:
;sensor.c,413 :: 		write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,414 :: 		break;
	GOTO        L_set_channel15
;sensor.c,415 :: 		case 12:
L_set_channel17:
;sensor.c,416 :: 		write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       18
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,417 :: 		break;
	GOTO        L_set_channel15
;sensor.c,418 :: 		case 13:
L_set_channel18:
;sensor.c,419 :: 		write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,420 :: 		break;
	GOTO        L_set_channel15
;sensor.c,421 :: 		case 14:
L_set_channel19:
;sensor.c,422 :: 		write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,423 :: 		break;
	GOTO        L_set_channel15
;sensor.c,424 :: 		case 15:
L_set_channel20:
;sensor.c,425 :: 		write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       66
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,426 :: 		break;
	GOTO        L_set_channel15
;sensor.c,427 :: 		case 16:
L_set_channel21:
;sensor.c,428 :: 		write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       82
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,429 :: 		break;
	GOTO        L_set_channel15
;sensor.c,430 :: 		case 17:
L_set_channel22:
;sensor.c,431 :: 		write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       98
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,432 :: 		break;
	GOTO        L_set_channel15
;sensor.c,433 :: 		case 18:
L_set_channel23:
;sensor.c,434 :: 		write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       114
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,435 :: 		break;
	GOTO        L_set_channel15
;sensor.c,436 :: 		case 19:
L_set_channel24:
;sensor.c,437 :: 		write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       130
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,438 :: 		break;
	GOTO        L_set_channel15
;sensor.c,439 :: 		case 20:
L_set_channel25:
;sensor.c,440 :: 		write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       146
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,441 :: 		break;
	GOTO        L_set_channel15
;sensor.c,442 :: 		case 21:
L_set_channel26:
;sensor.c,443 :: 		write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       162
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,444 :: 		break;
	GOTO        L_set_channel15
;sensor.c,445 :: 		case 22:
L_set_channel27:
;sensor.c,446 :: 		write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       178
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,447 :: 		break;
	GOTO        L_set_channel15
;sensor.c,448 :: 		case 23:
L_set_channel28:
;sensor.c,449 :: 		write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       194
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,450 :: 		break;
	GOTO        L_set_channel15
;sensor.c,451 :: 		case 24:
L_set_channel29:
;sensor.c,452 :: 		write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       210
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,453 :: 		break;
	GOTO        L_set_channel15
;sensor.c,454 :: 		case 25:
L_set_channel30:
;sensor.c,455 :: 		write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       226
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,456 :: 		break;
	GOTO        L_set_channel15
;sensor.c,457 :: 		case 26:
L_set_channel31:
;sensor.c,458 :: 		write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       242
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,459 :: 		break;
	GOTO        L_set_channel15
;sensor.c,460 :: 		}
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
;sensor.c,461 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;sensor.c,462 :: 		}
	RETURN      0
; end of _set_channel

_set_CCA_mode:
;sensor.c,467 :: 		void set_CCA_mode(short int CCA_mode) {
;sensor.c,469 :: 		switch(CCA_mode) {
	GOTO        L_set_CCA_mode32
;sensor.c,470 :: 		case 1: {                               // ENERGY ABOVE THRESHOLD
L_set_CCA_mode34:
;sensor.c,471 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,472 :: 		temp = temp | 0x80;                   // 0x80 mask
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,473 :: 		temp = temp & 0xDF;                   // 0xDF mask
	MOVLW       223
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;sensor.c,474 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,475 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,477 :: 		break;
	GOTO        L_set_CCA_mode33
;sensor.c,479 :: 		case 2: {                               // CARRIER SENSE ONLY
L_set_CCA_mode35:
;sensor.c,480 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,481 :: 		temp = temp | 0x40;                   // 0x40 mask
	MOVLW       64
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,482 :: 		temp = temp & 0x7F;                   // 0x7F mask
	MOVLW       127
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;sensor.c,483 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,485 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,486 :: 		temp = temp | 0x38;
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,487 :: 		temp = temp & 0xFB;
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;sensor.c,488 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,490 :: 		break;
	GOTO        L_set_CCA_mode33
;sensor.c,492 :: 		case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
L_set_CCA_mode36:
;sensor.c,493 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,494 :: 		temp = temp | 0xC0;                   // 0xC0 mask
	MOVLW       192
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,495 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,497 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,498 :: 		temp = temp | 0x38;                   // 0x38 mask
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,499 :: 		temp = temp & 0xFB;                   // 0xFB mask
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;sensor.c,500 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,502 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,504 :: 		break;
	GOTO        L_set_CCA_mode33
;sensor.c,505 :: 		}
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
;sensor.c,506 :: 		}
	RETURN      0
; end of _set_CCA_mode

_set_RSSI_mode:
;sensor.c,511 :: 		void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
;sensor.c,514 :: 		switch(RSSI_mode) {
	GOTO        L_set_RSSI_mode37
;sensor.c,515 :: 		case 1: {
L_set_RSSI_mode39:
;sensor.c,516 :: 		temp = read_ZIGBEE_short(BBREG6);
	MOVLW       62
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,517 :: 		temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,518 :: 		write_ZIGBEE_short(BBREG6, temp);
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,520 :: 		break;
	GOTO        L_set_RSSI_mode38
;sensor.c,522 :: 		case 2:
L_set_RSSI_mode40:
;sensor.c,523 :: 		write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       64
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,524 :: 		break;
	GOTO        L_set_RSSI_mode38
;sensor.c,525 :: 		}
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
;sensor.c,526 :: 		}
	RETURN      0
; end of _set_RSSI_mode

_nonbeacon_PAN_coordinator_device:
;sensor.c,531 :: 		void nonbeacon_PAN_coordinator_device() {
;sensor.c,534 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,535 :: 		temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,536 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,538 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,539 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,540 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,542 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,543 :: 		}
	RETURN      0
; end of _nonbeacon_PAN_coordinator_device

_nonbeacon_coordinator_device:
;sensor.c,545 :: 		void nonbeacon_coordinator_device() {
;sensor.c,548 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,549 :: 		temp = temp | 0x04;                 // 0x04 mask for coordinator
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,550 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,552 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,553 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,554 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,556 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,557 :: 		}
	RETURN      0
; end of _nonbeacon_coordinator_device

_nonbeacon_device:
;sensor.c,559 :: 		void nonbeacon_device() {
;sensor.c,562 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,563 :: 		temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
	MOVLW       243
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,564 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,566 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,567 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,568 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,569 :: 		}
	RETURN      0
; end of _nonbeacon_device

_set_IFS_recomended:
;sensor.c,578 :: 		void set_IFS_recomended() {
;sensor.c,581 :: 		write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       147
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,583 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,584 :: 		temp = temp | 0x7C;                 // MinLIFSPeriod
	MOVLW       124
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,585 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,587 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,588 :: 		temp = temp | 0x90;                 // MinLIFSPeriod
	MOVLW       144
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,589 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,591 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,592 :: 		temp = temp | 0x31;                 // TurnaroundTime
	MOVLW       49
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,593 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,594 :: 		}
	RETURN      0
; end of _set_IFS_recomended

_set_IFS_default:
;sensor.c,596 :: 		void set_IFS_default() {
;sensor.c,599 :: 		write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       117
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,601 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,602 :: 		temp = temp | 0x84;                 // Min LIFS Period
	MOVLW       132
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,603 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,605 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,606 :: 		temp = temp | 0x50;                 // Min LIFS Period
	MOVLW       80
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,607 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,609 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,610 :: 		temp = temp | 0x41;                 // Turnaround Time
	MOVLW       65
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,611 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,612 :: 		}
	RETURN      0
; end of _set_IFS_default

_set_reception_mode:
;sensor.c,617 :: 		void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
;sensor.c,620 :: 		switch(r_mode) {
	GOTO        L_set_reception_mode41
;sensor.c,621 :: 		case 1: {
L_set_reception_mode43:
;sensor.c,622 :: 		temp = read_ZIGBEE_short(RXMCR);      // normal mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,623 :: 		temp = temp & (!0x03);                // mask for normal mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,624 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,626 :: 		break;
	GOTO        L_set_reception_mode42
;sensor.c,628 :: 		case 2: {
L_set_reception_mode44:
;sensor.c,629 :: 		temp = read_ZIGBEE_short(RXMCR);      // error mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,630 :: 		temp = temp & (!0x01);                // mask for error mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,631 :: 		temp = temp | 0x02;                   // mask for error mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;sensor.c,632 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,634 :: 		break;
	GOTO        L_set_reception_mode42
;sensor.c,636 :: 		case 3: {
L_set_reception_mode45:
;sensor.c,637 :: 		temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,638 :: 		temp = temp & (!0x02);                // mask for promiscuous mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,639 :: 		temp = temp | 0x01;                   // mask for promiscuous mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 0 
;sensor.c,640 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,642 :: 		break;
	GOTO        L_set_reception_mode42
;sensor.c,643 :: 		}
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
;sensor.c,644 :: 		}
	RETURN      0
; end of _set_reception_mode

_set_frame_format_filter:
;sensor.c,649 :: 		void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
;sensor.c,652 :: 		switch(fff_mode) {
	GOTO        L_set_frame_format_filter46
;sensor.c,653 :: 		case 1: {
L_set_frame_format_filter48:
;sensor.c,654 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // all frames
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,655 :: 		temp = temp & (!0x0E);                  // mask for all frames
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,656 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,658 :: 		break;
	GOTO        L_set_frame_format_filter47
;sensor.c,660 :: 		case 2: {
L_set_frame_format_filter49:
;sensor.c,661 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // command only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,662 :: 		temp = temp & (!0x06);                  // mask for command only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,663 :: 		temp = temp | 0x08;                     // mask for command only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 3 
;sensor.c,664 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,666 :: 		break;
	GOTO        L_set_frame_format_filter47
;sensor.c,668 :: 		case 3: {
L_set_frame_format_filter50:
;sensor.c,669 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // data only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,670 :: 		temp = temp & (!0x0A);                  // mask for data only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,671 :: 		temp = temp | 0x04;                     // mask for data only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 2 
;sensor.c,672 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,674 :: 		break;
	GOTO        L_set_frame_format_filter47
;sensor.c,676 :: 		case 4: {
L_set_frame_format_filter51:
;sensor.c,677 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,678 :: 		temp = temp & (!0x0C);                  // mask for beacon only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,679 :: 		temp = temp | 0x02;                     // mask for beacon only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;sensor.c,680 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,682 :: 		break;
	GOTO        L_set_frame_format_filter47
;sensor.c,683 :: 		}
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
;sensor.c,684 :: 		}
	RETURN      0
; end of _set_frame_format_filter

_flush_RX_FIFO_pointer:
;sensor.c,689 :: 		void flush_RX_FIFO_pointer() {
;sensor.c,692 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,693 :: 		temp = temp | 0x01;                        // mask for flush RX FIFO
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,694 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,695 :: 		}
	RETURN      0
; end of _flush_RX_FIFO_pointer

_set_short_address:
;sensor.c,700 :: 		void set_short_address(short int * address) {
;sensor.c,701 :: 		write_ZIGBEE_short(SADRL, address[0]);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_short_address_address+0, FSR0L
	MOVFF       FARG_set_short_address_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,702 :: 		write_ZIGBEE_short(SADRH, address[1]);
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
;sensor.c,703 :: 		}
	RETURN      0
; end of _set_short_address

_set_long_address:
	CLRF        set_long_address_i_L0+0 
;sensor.c,705 :: 		void set_long_address(short int * address) {
;sensor.c,708 :: 		for(i = 0; i < 8; i++) {
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
;sensor.c,709 :: 		write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
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
;sensor.c,708 :: 		for(i = 0; i < 8; i++) {
	INCF        set_long_address_i_L0+0, 1 
;sensor.c,710 :: 		}
	GOTO        L_set_long_address52
L_set_long_address53:
;sensor.c,711 :: 		}
	RETURN      0
; end of _set_long_address

_set_PAN_ID:
;sensor.c,713 :: 		void set_PAN_ID(short int * address) {
;sensor.c,714 :: 		write_ZIGBEE_short(PANIDL, address[0]);
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_PAN_ID_address+0, FSR0L
	MOVFF       FARG_set_PAN_ID_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,715 :: 		write_ZIGBEE_short(PANIDH, address[1]);
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
;sensor.c,716 :: 		}
	RETURN      0
; end of _set_PAN_ID

_set_wake_from_pin:
;sensor.c,721 :: 		void set_wake_from_pin() {
;sensor.c,724 :: 		WAKE = 0;
	BCF         LATC2_bit+0, 2 
;sensor.c,725 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,726 :: 		temp = temp | 0x60;                     // mask
	MOVLW       96
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,727 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,729 :: 		temp = read_ZIGBEE_short(WAKECON);
	MOVLW       34
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,730 :: 		temp = temp | 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;sensor.c,731 :: 		write_ZIGBEE_short(WAKECON, temp);
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,732 :: 		}
	RETURN      0
; end of _set_wake_from_pin

_pin_wake:
;sensor.c,734 :: 		void pin_wake() {
;sensor.c,735 :: 		WAKE = 1;
	BSF         LATC2_bit+0, 2 
;sensor.c,736 :: 		Delay_ms(5);
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
;sensor.c,737 :: 		}
	RETURN      0
; end of _pin_wake

_enable_PLL:
;sensor.c,742 :: 		void enable_PLL() {
;sensor.c,743 :: 		write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,744 :: 		}
	RETURN      0
; end of _enable_PLL

_disable_PLL:
;sensor.c,746 :: 		void disable_PLL() {
;sensor.c,747 :: 		write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	CLRF        FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,748 :: 		}
	RETURN      0
; end of _disable_PLL

_set_TX_power:
;sensor.c,753 :: 		void set_TX_power(unsigned short int power) {             // 0-31 possible variants
;sensor.c,754 :: 		if((power < 0) || (power > 31))
	MOVLW       0
	SUBWF       FARG_set_TX_power_power+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power189
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power189
	GOTO        L_set_TX_power58
L__set_TX_power189:
;sensor.c,755 :: 		power = 31;
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
L_set_TX_power58:
;sensor.c,756 :: 		power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_set_TX_power_power+0 
;sensor.c,757 :: 		power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
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
;sensor.c,758 :: 		write_ZIGBEE_long(RFCON3, power);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,759 :: 		}
	RETURN      0
; end of _set_TX_power

_init_ZIGBEE_basic:
;sensor.c,764 :: 		void init_ZIGBEE_basic() {
;sensor.c,765 :: 		write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
	MOVLW       24
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       152
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,766 :: 		write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       149
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;sensor.c,767 :: 		write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,768 :: 		enable_PLL();                       // Enable PLL (PLLEN = 1)
	CALL        _enable_PLL+0, 0
;sensor.c,769 :: 		write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
	MOVLW       6
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       144
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,770 :: 		write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,771 :: 		write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
	MOVLW       8
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,772 :: 		write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
	MOVLW       32
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;sensor.c,773 :: 		}
	RETURN      0
; end of _init_ZIGBEE_basic

_init_ZIGBEE_nonbeacon:
;sensor.c,775 :: 		void init_ZIGBEE_nonbeacon() {
;sensor.c,776 :: 		init_ZIGBEE_basic();
	CALL        _init_ZIGBEE_basic+0, 0
;sensor.c,777 :: 		set_CCA_mode(1);     // Set CCA mode to ED and set threshold
	MOVLW       1
	MOVWF       FARG_set_CCA_mode_CCA_mode+0 
	CALL        _set_CCA_mode+0, 0
;sensor.c,778 :: 		set_RSSI_mode(2);    // RSSI2 mode
	MOVLW       2
	MOVWF       FARG_set_RSSI_mode_RSSI_mode+0 
	CALL        _set_RSSI_mode+0, 0
;sensor.c,779 :: 		enable_interrupt();  // Enables all interrupts
	CALL        _enable_interrupt+0, 0
;sensor.c,780 :: 		set_channel(11);     // Channel 11
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
	CALL        _set_channel+0, 0
;sensor.c,781 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;sensor.c,782 :: 		}
	RETURN      0
; end of _init_ZIGBEE_nonbeacon

_Debounce_INT:
	CLRF        Debounce_INT_intn_d_L0+0 
	CLRF        Debounce_INT_j_L0+0 
	CLRF        Debounce_INT_i_L0+0 
;sensor.c,784 :: 		char Debounce_INT() {
;sensor.c,786 :: 		for(i = 0; i < 5; i++) {
	CLRF        Debounce_INT_i_L0+0 
L_Debounce_INT59:
	MOVLW       5
	SUBWF       Debounce_INT_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT60
;sensor.c,787 :: 		intn_d = INT;
	MOVLW       0
	BTFSC       RC6_bit+0, 6 
	MOVLW       1
	MOVWF       Debounce_INT_intn_d_L0+0 
;sensor.c,788 :: 		if (intn_d == 1)
	MOVF        Debounce_INT_intn_d_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Debounce_INT62
;sensor.c,789 :: 		j++;
	INCF        Debounce_INT_j_L0+0, 1 
L_Debounce_INT62:
;sensor.c,786 :: 		for(i = 0; i < 5; i++) {
	INCF        Debounce_INT_i_L0+0, 1 
;sensor.c,790 :: 		}
	GOTO        L_Debounce_INT59
L_Debounce_INT60:
;sensor.c,791 :: 		if (j > 2)
	MOVF        Debounce_INT_j_L0+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT63
;sensor.c,792 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_Debounce_INT63:
;sensor.c,794 :: 		return 0;
	CLRF        R0 
;sensor.c,795 :: 		}
	RETURN      0
; end of _Debounce_INT

_Decoder_therm:
;sensor.c,800 :: 		char Decoder_therm (short int digit, short int code_d){
;sensor.c,802 :: 		switch(code_d){
	GOTO        L_Decoder_therm65
;sensor.c,803 :: 		case 0b00000111: {
L_Decoder_therm67:
;sensor.c,804 :: 		if (digit == 1){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm68
;sensor.c,805 :: 		return ' ';
	MOVLW       32
	MOVWF       R0 
	RETURN      0
;sensor.c,806 :: 		}
L_Decoder_therm68:
;sensor.c,808 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,809 :: 		case 0b00000101:{
L_Decoder_therm69:
;sensor.c,810 :: 		if (digit == 1){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm70
;sensor.c,811 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	RETURN      0
;sensor.c,812 :: 		}
L_Decoder_therm70:
;sensor.c,814 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,815 :: 		case 0b00000100:{
L_Decoder_therm71:
;sensor.c,816 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm199
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm199
	GOTO        L_Decoder_therm74
L__Decoder_therm199:
;sensor.c,817 :: 		return '0';
	MOVLW       48
	MOVWF       R0 
	RETURN      0
;sensor.c,818 :: 		}
L_Decoder_therm74:
;sensor.c,820 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,821 :: 		case 0b01101101:{
L_Decoder_therm75:
;sensor.c,822 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm198
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm198
	GOTO        L_Decoder_therm78
L__Decoder_therm198:
;sensor.c,823 :: 		return '1';
	MOVLW       49
	MOVWF       R0 
	RETURN      0
;sensor.c,824 :: 		}
L_Decoder_therm78:
;sensor.c,826 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,827 :: 		case 0b01000010:{
L_Decoder_therm79:
;sensor.c,828 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm197
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm197
	GOTO        L_Decoder_therm82
L__Decoder_therm197:
;sensor.c,829 :: 		return '2';
	MOVLW       50
	MOVWF       R0 
	RETURN      0
;sensor.c,830 :: 		}
L_Decoder_therm82:
;sensor.c,832 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,833 :: 		case 0b01001000:{
L_Decoder_therm83:
;sensor.c,834 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm196
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm196
	GOTO        L_Decoder_therm86
L__Decoder_therm196:
;sensor.c,835 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	RETURN      0
;sensor.c,836 :: 		}
L_Decoder_therm86:
;sensor.c,838 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,839 :: 		case 0b00101001:{
L_Decoder_therm87:
;sensor.c,840 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm195
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm195
	GOTO        L_Decoder_therm90
L__Decoder_therm195:
;sensor.c,841 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	RETURN      0
;sensor.c,842 :: 		}
L_Decoder_therm90:
;sensor.c,844 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,845 :: 		case 0b00011000:{
L_Decoder_therm91:
;sensor.c,846 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm194
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm194
	GOTO        L_Decoder_therm94
L__Decoder_therm194:
;sensor.c,847 :: 		return '5';
	MOVLW       53
	MOVWF       R0 
	RETURN      0
;sensor.c,848 :: 		}
L_Decoder_therm94:
;sensor.c,850 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,851 :: 		case 0b00010000:{
L_Decoder_therm95:
;sensor.c,852 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm193
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm193
	GOTO        L_Decoder_therm98
L__Decoder_therm193:
;sensor.c,853 :: 		return '6';
	MOVLW       54
	MOVWF       R0 
	RETURN      0
;sensor.c,854 :: 		}
L_Decoder_therm98:
;sensor.c,856 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,857 :: 		case 0b01001101:{
L_Decoder_therm99:
;sensor.c,858 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm192
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm192
	GOTO        L_Decoder_therm102
L__Decoder_therm192:
;sensor.c,859 :: 		return '7';
	MOVLW       55
	MOVWF       R0 
	RETURN      0
;sensor.c,860 :: 		}
L_Decoder_therm102:
;sensor.c,862 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,863 :: 		case 0b000000000:{
L_Decoder_therm103:
;sensor.c,864 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm191
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm191
	GOTO        L_Decoder_therm106
L__Decoder_therm191:
;sensor.c,865 :: 		return '8';
	MOVLW       56
	MOVWF       R0 
	RETURN      0
;sensor.c,866 :: 		}
L_Decoder_therm106:
;sensor.c,867 :: 		else if (digit == 1){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm108
;sensor.c,868 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	RETURN      0
;sensor.c,869 :: 		}
L_Decoder_therm108:
;sensor.c,871 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,872 :: 		case 0b00001000:{
L_Decoder_therm109:
;sensor.c,873 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm190
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm190
	GOTO        L_Decoder_therm112
L__Decoder_therm190:
;sensor.c,874 :: 		return '9';
	MOVLW       57
	MOVWF       R0 
	RETURN      0
;sensor.c,875 :: 		}
L_Decoder_therm112:
;sensor.c,877 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,878 :: 		case 0b00100001:{
L_Decoder_therm113:
;sensor.c,879 :: 		if (digit == 2){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm114
;sensor.c,880 :: 		return 'H';
	MOVLW       72
	MOVWF       R0 
	RETURN      0
;sensor.c,881 :: 		}
L_Decoder_therm114:
;sensor.c,883 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,884 :: 		case 0b00110110:{
L_Decoder_therm115:
;sensor.c,885 :: 		if (digit == 2){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm116
;sensor.c,886 :: 		return 'L';
	MOVLW       76
	MOVWF       R0 
	RETURN      0
;sensor.c,887 :: 		}
L_Decoder_therm116:
;sensor.c,889 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,890 :: 		case 0b01110111:{
L_Decoder_therm117:
;sensor.c,891 :: 		if (digit == 3){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm118
;sensor.c,892 :: 		return 'i';
	MOVLW       105
	MOVWF       R0 
	RETURN      0
;sensor.c,893 :: 		}
L_Decoder_therm118:
;sensor.c,895 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,896 :: 		case 0b01110000:{
L_Decoder_therm119:
;sensor.c,897 :: 		if (digit == 3){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm120
;sensor.c,898 :: 		return 'o';
	MOVLW       111
	MOVWF       R0 
	RETURN      0
;sensor.c,899 :: 		}
L_Decoder_therm120:
;sensor.c,901 :: 		break;
	GOTO        L_Decoder_therm66
;sensor.c,902 :: 		default:
L_Decoder_therm121:
;sensor.c,903 :: 		return 'E';
	MOVLW       69
	MOVWF       R0 
	RETURN      0
;sensor.c,905 :: 		}
L_Decoder_therm65:
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm67
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm69
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm71
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       109
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm75
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm79
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       72
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm83
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       41
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm87
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       24
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm91
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm95
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       77
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm99
	MOVLW       0
	BTFSC       FARG_Decoder_therm_code_d+0, 7 
	MOVLW       255
	MOVWF       R0 
	MOVLW       0
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Decoder_therm217
	MOVLW       0
	XORWF       FARG_Decoder_therm_code_d+0, 0 
L__Decoder_therm217:
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm103
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm109
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       33
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm113
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       54
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm115
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       119
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm117
	MOVF        FARG_Decoder_therm_code_d+0, 0 
	XORLW       112
	BTFSC       STATUS+0, 2 
	GOTO        L_Decoder_therm119
	GOTO        L_Decoder_therm121
L_Decoder_therm66:
;sensor.c,906 :: 		return 'E';
	MOVLW       69
	MOVWF       R0 
;sensor.c,907 :: 		}
	RETURN      0
; end of _Decoder_therm

_Read_therm_serial:
;sensor.c,910 :: 		void Read_therm_serial(){
;sensor.c,912 :: 		dig1=0;
	CLRF        _dig1+0 
	CLRF        _dig1+1 
;sensor.c,913 :: 		dig2=0;
	CLRF        _dig2+0 
	CLRF        _dig2+1 
;sensor.c,914 :: 		dig3=0;
	CLRF        _dig3+0 
	CLRF        _dig3+1 
;sensor.c,915 :: 		degrees=0;
	CLRF        _degrees+0 
	CLRF        _degrees+1 
;sensor.c,916 :: 		battery=0;
	CLRF        _battery+0 
	CLRF        _battery+1 
;sensor.c,918 :: 		while (H1 == 0) {} // Wait H1 to be 1
L_Read_therm_serial122:
	BTFSC       RB4_bit+0, 4 
	GOTO        L_Read_therm_serial123
	GOTO        L_Read_therm_serial122
L_Read_therm_serial123:
;sensor.c,919 :: 		LD = 1;             // Set LD = 1
	BSF         RB3_bit+0, 3 
;sensor.c,920 :: 		for (loop = 0; loop < 8; loop++){
	CLRF        Read_therm_serial_loop_L0+0 
L_Read_therm_serial124:
	MOVLW       8
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_therm_serial125
;sensor.c,921 :: 		if (loop == 0){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial127
;sensor.c,922 :: 		dig1 <<= 1;
	RLCF        _dig1+0, 1 
	BCF         _dig1+0, 0 
	RLCF        _dig1+1, 1 
;sensor.c,923 :: 		dig1 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig1+0, 1 
	MOVLW       0
	ADDWFC      _dig1+1, 1 
;sensor.c,924 :: 		}
	GOTO        L_Read_therm_serial128
L_Read_therm_serial127:
;sensor.c,925 :: 		else if ((loop >= 1) && (loop <= 3)){
	MOVLW       1
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial131
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial131
L__Read_therm_serial204:
;sensor.c,926 :: 		dig2 <<= 1;
	RLCF        _dig2+0, 1 
	BCF         _dig2+0, 0 
	RLCF        _dig2+1, 1 
;sensor.c,927 :: 		dig2 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig2+0, 1 
	MOVLW       0
	ADDWFC      _dig2+1, 1 
;sensor.c,928 :: 		}
	GOTO        L_Read_therm_serial132
L_Read_therm_serial131:
;sensor.c,929 :: 		else if ((loop >= 4) && (loop <= 6)){
	MOVLW       4
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial135
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       6
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial135
L__Read_therm_serial203:
;sensor.c,930 :: 		dig3 <<= 1;
	RLCF        _dig3+0, 1 
	BCF         _dig3+0, 0 
	RLCF        _dig3+1, 1 
;sensor.c,931 :: 		dig3 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig3+0, 1 
	MOVLW       0
	ADDWFC      _dig3+1, 1 
;sensor.c,932 :: 		}
	GOTO        L_Read_therm_serial136
L_Read_therm_serial135:
;sensor.c,934 :: 		degrees <<= 1;
	RLCF        _degrees+0, 1 
	BCF         _degrees+0, 0 
	RLCF        _degrees+1, 1 
;sensor.c,935 :: 		degrees += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _degrees+0, 1 
	MOVLW       0
	ADDWFC      _degrees+1, 1 
;sensor.c,936 :: 		}
L_Read_therm_serial136:
L_Read_therm_serial132:
L_Read_therm_serial128:
;sensor.c,937 :: 		CLK_therm = 1;   // Generate a pulse of clock
	BSF         RB1_bit+0, 1 
;sensor.c,938 :: 		delay_us(500);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       158
	MOVWF       R13, 0
L_Read_therm_serial137:
	DECFSZ      R13, 1, 0
	BRA         L_Read_therm_serial137
	DECFSZ      R12, 1, 0
	BRA         L_Read_therm_serial137
	NOP
;sensor.c,939 :: 		CLK_therm = 0;
	BCF         RB1_bit+0, 1 
;sensor.c,920 :: 		for (loop = 0; loop < 8; loop++){
	INCF        Read_therm_serial_loop_L0+0, 1 
;sensor.c,940 :: 		}
	GOTO        L_Read_therm_serial124
L_Read_therm_serial125:
;sensor.c,941 :: 		LD = 0; // Set LD = 0
	BCF         RB3_bit+0, 3 
;sensor.c,943 :: 		while (H2 == 0) {}    // Wait H2 to be 1
L_Read_therm_serial138:
	BTFSC       RB2_bit+0, 2 
	GOTO        L_Read_therm_serial139
	GOTO        L_Read_therm_serial138
L_Read_therm_serial139:
;sensor.c,944 :: 		LD = 1;              // Set LD = 1
	BSF         RB3_bit+0, 3 
;sensor.c,945 :: 		for (loop = 0; loop < 8; loop++){
	CLRF        Read_therm_serial_loop_L0+0 
L_Read_therm_serial140:
	MOVLW       8
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_therm_serial141
;sensor.c,946 :: 		if (loop == 0){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial143
;sensor.c,947 :: 		dig1 <<= 1;
	RLCF        _dig1+0, 1 
	BCF         _dig1+0, 0 
	RLCF        _dig1+1, 1 
;sensor.c,948 :: 		dig1 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig1+0, 1 
	MOVLW       0
	ADDWFC      _dig1+1, 1 
;sensor.c,949 :: 		}
	GOTO        L_Read_therm_serial144
L_Read_therm_serial143:
;sensor.c,950 :: 		else if ((loop >= 1) && (loop <= 3)){
	MOVLW       1
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial147
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial147
L__Read_therm_serial202:
;sensor.c,951 :: 		dig2 <<= 1;
	RLCF        _dig2+0, 1 
	BCF         _dig2+0, 0 
	RLCF        _dig2+1, 1 
;sensor.c,952 :: 		dig2 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig2+0, 1 
	MOVLW       0
	ADDWFC      _dig2+1, 1 
;sensor.c,953 :: 		}
	GOTO        L_Read_therm_serial148
L_Read_therm_serial147:
;sensor.c,954 :: 		else if ((loop >= 4) && (loop <= 6)){
	MOVLW       4
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial151
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       6
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial151
L__Read_therm_serial201:
;sensor.c,955 :: 		dig3 <<= 1;
	RLCF        _dig3+0, 1 
	BCF         _dig3+0, 0 
	RLCF        _dig3+1, 1 
;sensor.c,956 :: 		dig3 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig3+0, 1 
	MOVLW       0
	ADDWFC      _dig3+1, 1 
;sensor.c,957 :: 		}
	GOTO        L_Read_therm_serial152
L_Read_therm_serial151:
;sensor.c,959 :: 		degrees <<= 1;
	RLCF        _degrees+0, 1 
	BCF         _degrees+0, 0 
	RLCF        _degrees+1, 1 
;sensor.c,960 :: 		degrees += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _degrees+0, 1 
	MOVLW       0
	ADDWFC      _degrees+1, 1 
;sensor.c,961 :: 		}
L_Read_therm_serial152:
L_Read_therm_serial148:
L_Read_therm_serial144:
;sensor.c,962 :: 		CLK_therm = 1;   // Generate a pulse of clock
	BSF         RB1_bit+0, 1 
;sensor.c,963 :: 		delay_us(500);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       158
	MOVWF       R13, 0
L_Read_therm_serial153:
	DECFSZ      R13, 1, 0
	BRA         L_Read_therm_serial153
	DECFSZ      R12, 1, 0
	BRA         L_Read_therm_serial153
	NOP
;sensor.c,964 :: 		CLK_therm = 0;
	BCF         RB1_bit+0, 1 
;sensor.c,945 :: 		for (loop = 0; loop < 8; loop++){
	INCF        Read_therm_serial_loop_L0+0, 1 
;sensor.c,965 :: 		}
	GOTO        L_Read_therm_serial140
L_Read_therm_serial141:
;sensor.c,966 :: 		LD = 0; // Set LD = 0
	BCF         RB3_bit+0, 3 
;sensor.c,968 :: 		while (H3 == 0) {}          // Wait H3 to be 1
L_Read_therm_serial154:
	BTFSC       RB0_bit+0, 0 
	GOTO        L_Read_therm_serial155
	GOTO        L_Read_therm_serial154
L_Read_therm_serial155:
;sensor.c,969 :: 		LD = 1;                    // Set LD = 1
	BSF         RB3_bit+0, 3 
;sensor.c,970 :: 		for (loop = 0; loop < 8; loop++){
	CLRF        Read_therm_serial_loop_L0+0 
L_Read_therm_serial156:
	MOVLW       8
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_therm_serial157
;sensor.c,971 :: 		if (loop == 0){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial159
;sensor.c,972 :: 		dig1 <<= 1;
	RLCF        _dig1+0, 1 
	BCF         _dig1+0, 0 
	RLCF        _dig1+1, 1 
;sensor.c,973 :: 		dig1 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig1+0, 1 
	MOVLW       0
	ADDWFC      _dig1+1, 1 
;sensor.c,974 :: 		}
	GOTO        L_Read_therm_serial160
L_Read_therm_serial159:
;sensor.c,975 :: 		else if (loop == 2){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial161
;sensor.c,976 :: 		dig2 <<= 1;
	RLCF        _dig2+0, 1 
	BCF         _dig2+0, 0 
	RLCF        _dig2+1, 1 
;sensor.c,977 :: 		dig2 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig2+0, 1 
	MOVLW       0
	ADDWFC      _dig2+1, 1 
;sensor.c,978 :: 		}
	GOTO        L_Read_therm_serial162
L_Read_therm_serial161:
;sensor.c,979 :: 		else if (loop == 5){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial163
;sensor.c,980 :: 		dig3 <<= 1;
	RLCF        _dig3+0, 1 
	BCF         _dig3+0, 0 
	RLCF        _dig3+1, 1 
;sensor.c,981 :: 		dig3 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig3+0, 1 
	MOVLW       0
	ADDWFC      _dig3+1, 1 
;sensor.c,982 :: 		}
	GOTO        L_Read_therm_serial164
L_Read_therm_serial163:
;sensor.c,983 :: 		else if (loop == 6){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial165
;sensor.c,984 :: 		battery = Serial_in;
	MOVLW       0
	BTFSC       LATB7_bit+0, 7 
	MOVLW       1
	MOVWF       _battery+0 
	CLRF        _battery+1 
;sensor.c,985 :: 		}
	GOTO        L_Read_therm_serial166
L_Read_therm_serial165:
;sensor.c,986 :: 		else if (loop == 7){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial167
;sensor.c,987 :: 		degrees <<= 1;
	RLCF        _degrees+0, 1 
	BCF         _degrees+0, 0 
	RLCF        _degrees+1, 1 
;sensor.c,988 :: 		degrees += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _degrees+0, 1 
	MOVLW       0
	ADDWFC      _degrees+1, 1 
;sensor.c,989 :: 		}
L_Read_therm_serial167:
L_Read_therm_serial166:
L_Read_therm_serial164:
L_Read_therm_serial162:
L_Read_therm_serial160:
;sensor.c,990 :: 		CLK_therm = 1;    // Generate a pulse of clock
	BSF         RB1_bit+0, 1 
;sensor.c,991 :: 		delay_us(500);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       158
	MOVWF       R13, 0
L_Read_therm_serial168:
	DECFSZ      R13, 1, 0
	BRA         L_Read_therm_serial168
	DECFSZ      R12, 1, 0
	BRA         L_Read_therm_serial168
	NOP
;sensor.c,992 :: 		CLK_therm = 0;
	BCF         RB1_bit+0, 1 
;sensor.c,970 :: 		for (loop = 0; loop < 8; loop++){
	INCF        Read_therm_serial_loop_L0+0, 1 
;sensor.c,993 :: 		}
	GOTO        L_Read_therm_serial156
L_Read_therm_serial157:
;sensor.c,994 :: 		LD = 0;   // Set LD = 0
	BCF         RB3_bit+0, 3 
;sensor.c,996 :: 		dig1 = Decoder_therm(1, dig1);
	MOVLW       1
	MOVWF       FARG_Decoder_therm_digit+0 
	MOVF        _dig1+0, 0 
	MOVWF       FARG_Decoder_therm_code_d+0 
	CALL        _Decoder_therm+0, 0
	MOVF        R0, 0 
	MOVWF       _dig1+0 
	MOVLW       0
	MOVWF       _dig1+1 
;sensor.c,997 :: 		dig2 = Decoder_therm(2, dig2);
	MOVLW       2
	MOVWF       FARG_Decoder_therm_digit+0 
	MOVF        _dig2+0, 0 
	MOVWF       FARG_Decoder_therm_code_d+0 
	CALL        _Decoder_therm+0, 0
	MOVF        R0, 0 
	MOVWF       _dig2+0 
	MOVLW       0
	MOVWF       _dig2+1 
;sensor.c,998 :: 		dig3 = Decoder_therm(3, dig3);
	MOVLW       3
	MOVWF       FARG_Decoder_therm_digit+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Decoder_therm_code_d+0 
	CALL        _Decoder_therm+0, 0
	MOVF        R0, 0 
	MOVWF       _dig3+0 
	MOVLW       0
	MOVWF       _dig3+1 
;sensor.c,1000 :: 		Lcd_Chr(1, 1, dig1);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig1+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1001 :: 		Lcd_Chr(1, 2, dig2);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig2+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1002 :: 		if ((dig3 == 'i')||(dig3 == 'o')){
	MOVLW       0
	XORWF       _dig3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Read_therm_serial218
	MOVLW       105
	XORWF       _dig3+0, 0 
L__Read_therm_serial218:
	BTFSC       STATUS+0, 2 
	GOTO        L__Read_therm_serial200
	MOVLW       0
	XORWF       _dig3+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Read_therm_serial219
	MOVLW       111
	XORWF       _dig3+0, 0 
L__Read_therm_serial219:
	BTFSC       STATUS+0, 2 
	GOTO        L__Read_therm_serial200
	GOTO        L_Read_therm_serial171
L__Read_therm_serial200:
;sensor.c,1003 :: 		Lcd_Chr(1, 3, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1004 :: 		Lcd_Chr(1, 4, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1005 :: 		}else{
	GOTO        L_Read_therm_serial172
L_Read_therm_serial171:
;sensor.c,1006 :: 		Lcd_Chr(1, 3, '.');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1007 :: 		Lcd_Chr(1, 4, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1008 :: 		}
L_Read_therm_serial172:
;sensor.c,1010 :: 		if (battery == 1){
	MOVLW       0
	XORWF       _battery+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Read_therm_serial220
	MOVLW       1
	XORWF       _battery+0, 0 
L__Read_therm_serial220:
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial173
;sensor.c,1011 :: 		battery = 'b';
	MOVLW       98
	MOVWF       _battery+0 
	MOVLW       0
	MOVWF       _battery+1 
;sensor.c,1012 :: 		Lcd_Out(2, 0, "           ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_sensor+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_sensor+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;sensor.c,1013 :: 		}
	GOTO        L_Read_therm_serial174
L_Read_therm_serial173:
;sensor.c,1015 :: 		battery = 'B';
	MOVLW       66
	MOVWF       _battery+0 
	MOVLW       0
	MOVWF       _battery+1 
;sensor.c,1016 :: 		Lcd_Out(2, 0, "low battery");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_sensor+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_sensor+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;sensor.c,1017 :: 		}
L_Read_therm_serial174:
;sensor.c,1019 :: 		if (degrees == 2){
	MOVLW       0
	XORWF       _degrees+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Read_therm_serial221
	MOVLW       2
	XORWF       _degrees+0, 0 
L__Read_therm_serial221:
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial175
;sensor.c,1020 :: 		degrees = 'C';
	MOVLW       67
	MOVWF       _degrees+0 
	MOVLW       0
	MOVWF       _degrees+1 
;sensor.c,1021 :: 		Lcd_Chr(1, 5, 'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1022 :: 		}
	GOTO        L_Read_therm_serial176
L_Read_therm_serial175:
;sensor.c,1024 :: 		degrees = 'c';
	MOVLW       99
	MOVWF       _degrees+0 
	MOVLW       0
	MOVWF       _degrees+1 
;sensor.c,1025 :: 		Lcd_Chr(1, 5, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;sensor.c,1026 :: 		}
L_Read_therm_serial176:
;sensor.c,1027 :: 		}
	RETURN      0
; end of _Read_therm_serial

_Initialize:
	CLRF        Initialize_i_L0+0 
;sensor.c,1030 :: 		void Initialize() {
;sensor.c,1033 :: 		LQI = 0;
	CLRF        _LQI+0 
;sensor.c,1034 :: 		RSSI2 = 0;
	CLRF        _RSSI2+0 
;sensor.c,1035 :: 		SEQ_NUMBER = 0x23;
	MOVLW       35
	MOVWF       _SEQ_NUMBER+0 
;sensor.c,1036 :: 		lost_data = 0;
	CLRF        _lost_data+0 
;sensor.c,1037 :: 		address_RX_FIFO = 0x300;
	MOVLW       0
	MOVWF       _address_RX_FIFO+0 
	MOVLW       3
	MOVWF       _address_RX_FIFO+1 
;sensor.c,1038 :: 		address_TX_normal_FIFO = 0;
	CLRF        _address_TX_normal_FIFO+0 
	CLRF        _address_TX_normal_FIFO+1 
;sensor.c,1040 :: 		for (i = 0; i < 2; i++) {
	CLRF        Initialize_i_L0+0 
L_Initialize177:
	MOVLW       128
	XORWF       Initialize_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       2
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Initialize178
;sensor.c,1041 :: 		ADDRESS_short_1[i] = 1;
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
;sensor.c,1042 :: 		ADDRESS_short_2[i] = 2;
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
;sensor.c,1043 :: 		PAN_ID_1[i] = 3;
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
;sensor.c,1044 :: 		PAN_ID_2[i] = 3;
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
;sensor.c,1040 :: 		for (i = 0; i < 2; i++) {
	INCF        Initialize_i_L0+0, 1 
;sensor.c,1045 :: 		}
	GOTO        L_Initialize177
L_Initialize178:
;sensor.c,1047 :: 		for (i = 0; i < 8; i++) {
	CLRF        Initialize_i_L0+0 
L_Initialize180:
	MOVLW       128
	XORWF       Initialize_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       8
	SUBWF       R0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Initialize181
;sensor.c,1048 :: 		ADDRESS_long_1[i] = 1;
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
;sensor.c,1049 :: 		ADDRESS_long_2[i] = 2;
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
;sensor.c,1047 :: 		for (i = 0; i < 8; i++) {
	INCF        Initialize_i_L0+0, 1 
;sensor.c,1050 :: 		}
	GOTO        L_Initialize180
L_Initialize181:
;sensor.c,1052 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;sensor.c,1053 :: 		GIE_bit = 0;           // Disable interrupts
	BCF         GIE_bit+0, 7 
;sensor.c,1055 :: 		TRISA = 0x00;          // Set direction to be output
	CLRF        TRISA+0 
;sensor.c,1056 :: 		TRISB = 0x00;          // Set direction to be output
	CLRF        TRISB+0 
;sensor.c,1057 :: 		TRISC = 0x00;          // Set direction to be output
	CLRF        TRISC+0 
;sensor.c,1058 :: 		TRISD = 0x00;          // Set direction to be output
	CLRF        TRISD+0 
;sensor.c,1060 :: 		CS2_Direction = 0;      // Set direction to be output
	BCF         TRISC0_bit+0, 0 
;sensor.c,1061 :: 		RST_Direction  = 0;    // Set direction to be output
	BCF         TRISC1_bit+0, 1 
;sensor.c,1062 :: 		INT_Direction  = 1;    // Set direction to be input
	BSF         TRISC6_bit+0, 6 
;sensor.c,1063 :: 		WAKE_Direction = 0;    // Set direction to be output
	BCF         TRISC2_bit+0, 2 
;sensor.c,1066 :: 		H3_Direction = 1;      // Direcao pinos termometro
	BSF         TRISB0_bit+0, 0 
;sensor.c,1067 :: 		H2_Direction = 1;
	BSF         TRISB2_bit+0, 2 
;sensor.c,1068 :: 		H1_Direction = 1;
	BSF         TRISB4_bit+0, 4 
;sensor.c,1069 :: 		Serial_in_Direction = 1;
	BSF         TRISB7_bit+0, 7 
;sensor.c,1070 :: 		LD_Direction = 0;
	BCF         TRISB1_bit+0, 1 
;sensor.c,1071 :: 		CLK_therm_Direction = 0;
	BCF         TRISB3_bit+0, 3 
;sensor.c,1073 :: 		DATA_TX[0] = 0;        // Initialize first byte
	CLRF        _DATA_TX+0 
;sensor.c,1074 :: 		DATA_TX[1] = 0;        // Initialize first byte
	CLRF        _DATA_TX+1 
;sensor.c,1075 :: 		DATA_TX[2] = 0;        // Initialize first byte
	CLRF        _DATA_TX+2 
;sensor.c,1076 :: 		DATA_TX[3] = 0;        // Initialize first byte
	CLRF        _DATA_TX+3 
;sensor.c,1077 :: 		DATA_TX[4] = 0;        // Initialize first byte
	CLRF        _DATA_TX+4 
;sensor.c,1079 :: 		PORTD = 0;             // Clear PORTD register
	CLRF        PORTD+0 
;sensor.c,1080 :: 		LATD  = 0;             // Clear LATD register
	CLRF        LATD+0 
;sensor.c,1082 :: 		Delay_ms(15);
	MOVLW       49
	MOVWF       R12, 0
	MOVLW       178
	MOVWF       R13, 0
L_Initialize183:
	DECFSZ      R13, 1, 0
	BRA         L_Initialize183
	DECFSZ      R12, 1, 0
	BRA         L_Initialize183
	NOP
;sensor.c,1084 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;sensor.c,1085 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;sensor.c,1086 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;sensor.c,1089 :: 		SPI1_Init_AdvancEd(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;sensor.c,1090 :: 		pin_reset();                              // Activate reset from pin
	CALL        _pin_reset+0, 0
;sensor.c,1091 :: 		software_reset();                         // Activate software reset
	CALL        _software_reset+0, 0
;sensor.c,1092 :: 		RF_reset();                               // RF reset
	CALL        _RF_reset+0, 0
;sensor.c,1093 :: 		set_WAKE_from_pin();                      // Set wake from pin
	CALL        _set_wake_from_pin+0, 0
;sensor.c,1095 :: 		set_long_address(ADDRESS_long_1);         // Set long address
	MOVLW       _ADDRESS_long_1+0
	MOVWF       FARG_set_long_address_address+0 
	MOVLW       hi_addr(_ADDRESS_long_1+0
	MOVWF       FARG_set_long_address_address+1 
	CALL        _set_long_address+0, 0
;sensor.c,1096 :: 		set_short_address(ADDRESS_short_1);       // Set short address
	MOVLW       _ADDRESS_short_1+0
	MOVWF       FARG_set_short_address_address+0 
	MOVLW       hi_addr(_ADDRESS_short_1+0
	MOVWF       FARG_set_short_address_address+1 
	CALL        _set_short_address+0, 0
;sensor.c,1097 :: 		set_PAN_ID(PAN_ID_1);                     // Set PAN_ID
	MOVLW       _PAN_ID_1+0
	MOVWF       FARG_set_PAN_ID_address+0 
	MOVLW       hi_addr(_PAN_ID_1+0
	MOVWF       FARG_set_PAN_ID_address+1 
	CALL        _set_PAN_ID+0, 0
;sensor.c,1099 :: 		init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
	CALL        _init_ZIGBEE_nonbeacon+0, 0
;sensor.c,1100 :: 		nonbeacon_PAN_coordinator_device();
	CALL        _nonbeacon_PAN_coordinator_device+0, 0
;sensor.c,1101 :: 		set_TX_power(31);                         // Set max TX power
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
	CALL        _set_TX_power+0, 0
;sensor.c,1102 :: 		set_frame_format_filter(1);               // 1 all frames, 3 data frame only
	MOVLW       1
	MOVWF       FARG_set_frame_format_filter_fff_mode+0 
	CALL        _set_frame_format_filter+0, 0
;sensor.c,1103 :: 		set_reception_mode(1);                    // 1 normal mode
	MOVLW       1
	MOVWF       FARG_set_reception_mode_r_mode+0 
	CALL        _set_reception_mode+0, 0
;sensor.c,1105 :: 		pin_wake();                               // Wake from pin
	CALL        _pin_wake+0, 0
;sensor.c,1106 :: 		}
	RETURN      0
; end of _Initialize

_main:
;sensor.c,1110 :: 		void main() {
;sensor.c,1114 :: 		Initialize();                      // Initialize MCU and Bee click board
	CALL        _Initialize+0, 0
;sensor.c,1116 :: 		while(1) {
L_main184:
;sensor.c,1118 :: 		delay_ms(2000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main186:
	DECFSZ      R13, 1, 0
	BRA         L_main186
	DECFSZ      R12, 1, 0
	BRA         L_main186
	DECFSZ      R11, 1, 0
	BRA         L_main186
	NOP
;sensor.c,1120 :: 		DATA_TX[0]=dig1;
	MOVF        _dig1+0, 0 
	MOVWF       _DATA_TX+0 
;sensor.c,1121 :: 		DATA_TX[1]=dig2;
	MOVF        _dig2+0, 0 
	MOVWF       _DATA_TX+1 
;sensor.c,1122 :: 		DATA_TX[2]=dig3;
	MOVF        _dig3+0, 0 
	MOVWF       _DATA_TX+2 
;sensor.c,1123 :: 		DATA_TX[3]=degrees;
	MOVF        _degrees+0, 0 
	MOVWF       _DATA_TX+3 
;sensor.c,1124 :: 		DATA_TX[4]=battery;
	MOVF        _battery+0, 0 
	MOVWF       _DATA_TX+4 
;sensor.c,1125 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;sensor.c,1126 :: 		i = read_ZIGBEE_short(TXSTAT);
	MOVLW       36
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,1127 :: 		IntToStr(i, texto); //converte o valor em string
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_texto_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_texto_L0+0
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;sensor.c,1128 :: 		Lcd_Out(1,1,texto); //envia para o lcd o valor string
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;sensor.c,1130 :: 		delay_ms(2000);
	MOVLW       26
	MOVWF       R11, 0
	MOVLW       94
	MOVWF       R12, 0
	MOVLW       110
	MOVWF       R13, 0
L_main187:
	DECFSZ      R13, 1, 0
	BRA         L_main187
	DECFSZ      R12, 1, 0
	BRA         L_main187
	DECFSZ      R11, 1, 0
	BRA         L_main187
	NOP
;sensor.c,1132 :: 		DATA_TX[0]='3';
	MOVLW       51
	MOVWF       _DATA_TX+0 
;sensor.c,1133 :: 		DATA_TX[1]='4';
	MOVLW       52
	MOVWF       _DATA_TX+1 
;sensor.c,1134 :: 		DATA_TX[2]='5';
	MOVLW       53
	MOVWF       _DATA_TX+2 
;sensor.c,1135 :: 		DATA_TX[3]=degrees;
	MOVF        _degrees+0, 0 
	MOVWF       _DATA_TX+3 
;sensor.c,1136 :: 		DATA_TX[4]=battery;
	MOVF        _battery+0, 0 
	MOVWF       _DATA_TX+4 
;sensor.c,1137 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;sensor.c,1138 :: 		i = read_ZIGBEE_short(TXSTAT);
	MOVLW       36
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;sensor.c,1139 :: 		IntToStr(i, texto); //converte o valor em string
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       main_texto_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(main_texto_L0+0
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;sensor.c,1140 :: 		Lcd_Out(1,1,texto); //envia para o lcd o valor string
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       main_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(main_texto_L0+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;sensor.c,1142 :: 		}
	GOTO        L_main184
;sensor.c,1143 :: 		}
	GOTO        $+0
; end of _main
