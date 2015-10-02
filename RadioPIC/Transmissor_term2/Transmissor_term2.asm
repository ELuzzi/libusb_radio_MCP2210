
_write_ZIGBEE_short:
;Transmissor_term2.c,179 :: 		void write_ZIGBEE_short(short int address, short int data_r) {
;Transmissor_term2.c,180 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Transmissor_term2.c,182 :: 		address = ((address << 1) & 0b01111111) | 0x01; // calculating addressing mode
	MOVF        FARG_write_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       127
	ANDWF       R0, 1 
	BSF         R0, 0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_address+0 
;Transmissor_term2.c,183 :: 		SPI1_Write(address);       // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,184 :: 		SPI1_Write(data_r);        // write data in register
	MOVF        FARG_write_ZIGBEE_short_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,186 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Transmissor_term2.c,187 :: 		}
	RETURN      0
; end of _write_ZIGBEE_short

_read_ZIGBEE_short:
	CLRF        read_ZIGBEE_short_dummy_data_r_L0+0 
;Transmissor_term2.c,190 :: 		short int read_ZIGBEE_short(short int address) {
;Transmissor_term2.c,193 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Transmissor_term2.c,195 :: 		address = (address << 1) & 0b01111110;      // calculating addressing mode
	MOVF        FARG_read_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       126
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_read_ZIGBEE_short_address+0 
;Transmissor_term2.c,196 :: 		SPI1_Write(address);                        // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,197 :: 		data_r = SPI1_Read(dummy_data_r);           // read data from register
	MOVF        read_ZIGBEE_short_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;Transmissor_term2.c,199 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Transmissor_term2.c,200 :: 		return data_r;
;Transmissor_term2.c,201 :: 		}
	RETURN      0
; end of _read_ZIGBEE_short

_write_ZIGBEE_long:
	CLRF        write_ZIGBEE_long_address_low_L0+0 
;Transmissor_term2.c,207 :: 		void write_ZIGBEE_long(int address, short int data_r) {
;Transmissor_term2.c,210 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Transmissor_term2.c,212 :: 		address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;  // calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__write_ZIGBEE_long219:
	BZ          L__write_ZIGBEE_long220
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long219
L__write_ZIGBEE_long220:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;Transmissor_term2.c,213 :: 		address_low  = (((short int)(address << 5)) & 0b11100000) | 0x10;  // calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       write_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__write_ZIGBEE_long221:
	BZ          L__write_ZIGBEE_long222
	RLCF        write_ZIGBEE_long_address_low_L0+0, 1 
	BCF         write_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long221
L__write_ZIGBEE_long222:
	MOVLW       224
	ANDWF       write_ZIGBEE_long_address_low_L0+0, 1 
	BSF         write_ZIGBEE_long_address_low_L0+0, 4 
;Transmissor_term2.c,214 :: 		SPI1_Write(address_high);           // addressing register
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,215 :: 		SPI1_Write(address_low);            // addressing register
	MOVF        write_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,216 :: 		SPI1_Write(data_r);                 // write data in registerr
	MOVF        FARG_write_ZIGBEE_long_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,218 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Transmissor_term2.c,219 :: 		}
	RETURN      0
; end of _write_ZIGBEE_long

_read_ZIGBEE_long:
	CLRF        read_ZIGBEE_long_address_low_L0+0 
	CLRF        read_ZIGBEE_long_dummy_data_r_L0+0 
;Transmissor_term2.c,222 :: 		short int read_ZIGBEE_long(int address) {
;Transmissor_term2.c,226 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Transmissor_term2.c,228 :: 		address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;  //calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__read_ZIGBEE_long223:
	BZ          L__read_ZIGBEE_long224
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long223
L__read_ZIGBEE_long224:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;Transmissor_term2.c,229 :: 		address_low  = ((short int)(address << 5) & 0b11100000);         //calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       read_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__read_ZIGBEE_long225:
	BZ          L__read_ZIGBEE_long226
	RLCF        read_ZIGBEE_long_address_low_L0+0, 1 
	BCF         read_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long225
L__read_ZIGBEE_long226:
	MOVLW       224
	ANDWF       read_ZIGBEE_long_address_low_L0+0, 1 
;Transmissor_term2.c,230 :: 		SPI1_Write(address_high);            // addressing register
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,231 :: 		SPI1_Write(address_low);             // addressing register
	MOVF        read_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Transmissor_term2.c,232 :: 		data_r = SPI1_Read(dummy_data_r);    // read data from register
	MOVF        read_ZIGBEE_long_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;Transmissor_term2.c,234 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Transmissor_term2.c,235 :: 		return data_r;
;Transmissor_term2.c,236 :: 		}
	RETURN      0
; end of _read_ZIGBEE_long

_start_transmit:
;Transmissor_term2.c,241 :: 		void start_transmit() {
;Transmissor_term2.c,244 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,245 :: 		temp = temp | 0x01;                 // mask for start transmit
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,246 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,247 :: 		}
	RETURN      0
; end of _start_transmit

_read_RX_FIFO:
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
;Transmissor_term2.c,252 :: 		void read_RX_FIFO() {
;Transmissor_term2.c,256 :: 		temp = read_ZIGBEE_short(BBREG1);      // disable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,257 :: 		temp = temp | 0x04;                    // mask for disable receiving packets
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,258 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,260 :: 		for(i=0; i<128; i++) {
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
L_read_RX_FIFO0:
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO227
	MOVLW       128
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO227:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO1
;Transmissor_term2.c,261 :: 		if(i <  (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO228
	MOVLW       21
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO228:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO3
;Transmissor_term2.c,262 :: 		data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);  // reading valid data from RX FIFO
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
;Transmissor_term2.c,263 :: 		if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO229
	MOVLW       21
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO229:
	BTFSS       STATUS+0, 0 
	GOTO        L_read_RX_FIFO4
;Transmissor_term2.c,264 :: 		lost_data = read_ZIGBEE_long(address_RX_FIFO + i);        // reading invalid data from RX FIFO
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
;Transmissor_term2.c,260 :: 		for(i=0; i<128; i++) {
	INFSNZ      read_RX_FIFO_i_L0+0, 1 
	INCF        read_RX_FIFO_i_L0+1, 1 
;Transmissor_term2.c,265 :: 		}
	GOTO        L_read_RX_FIFO0
L_read_RX_FIFO1:
;Transmissor_term2.c,267 :: 		DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];               // coping valid data
	MOVF        _data_RX_FIFO+12, 0 
	MOVWF       _DATA_RX+0 
;Transmissor_term2.c,268 :: 		DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];               // coping valid data
	MOVF        _data_RX_FIFO+13, 0 
	MOVWF       _DATA_RX+1 
;Transmissor_term2.c,269 :: 		DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];               // coping valid data
	MOVF        _data_RX_FIFO+14, 0 
	MOVWF       _DATA_RX+2 
;Transmissor_term2.c,270 :: 		DATA_RX[3] = data_RX_FIFO[HEADER_LENGHT + 4];               // coping valid data
	MOVF        _data_RX_FIFO+15, 0 
	MOVWF       _DATA_RX+3 
;Transmissor_term2.c,271 :: 		DATA_RX[4] = data_RX_FIFO[HEADER_LENGHT + 5];               // coping valid data
	MOVF        _data_RX_FIFO+16, 0 
	MOVWF       _DATA_RX+4 
;Transmissor_term2.c,273 :: 		LQI   = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];  // coping valid data
	MOVF        _data_RX_FIFO+19, 0 
	MOVWF       _LQI+0 
;Transmissor_term2.c,274 :: 		RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];  // coping valid data
	MOVF        _data_RX_FIFO+20, 0 
	MOVWF       _RSSI2+0 
;Transmissor_term2.c,276 :: 		temp = read_ZIGBEE_short(BBREG1);      // enable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,277 :: 		temp = temp & (!0x04);                 // mask for enable receiving
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,278 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,279 :: 		}
	RETURN      0
; end of _read_RX_FIFO

_set_ACK:
;Transmissor_term2.c,284 :: 		void set_ACK(void){
;Transmissor_term2.c,287 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,288 :: 		temp = temp | 0x04;                   // 0x04 mask for set ACK
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,289 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,290 :: 		}
	RETURN      0
; end of _set_ACK

_set_not_ACK:
;Transmissor_term2.c,292 :: 		void set_not_ACK(void){
;Transmissor_term2.c,295 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,296 :: 		temp = temp & (!0x04);                // 0x04 mask for set not ACK
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,297 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,298 :: 		}
	RETURN      0
; end of _set_not_ACK

_set_encrypt:
;Transmissor_term2.c,303 :: 		void set_encrypt(void){
;Transmissor_term2.c,306 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,307 :: 		temp = temp | 0x02;                   // mask for set encrypt
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,308 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,309 :: 		}
	RETURN      0
; end of _set_encrypt

_set_not_encrypt:
;Transmissor_term2.c,311 :: 		void set_not_encrypt(void){
;Transmissor_term2.c,314 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,315 :: 		temp = temp & (!0x02);                // mask for set not encrypt
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,316 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,317 :: 		}
	RETURN      0
; end of _set_not_encrypt

_write_TX_normal_FIFO:
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
;Transmissor_term2.c,319 :: 		void write_TX_normal_FIFO() {
;Transmissor_term2.c,322 :: 		data_TX_normal_FIFO[0]  = HEADER_LENGHT;
	MOVLW       11
	MOVWF       _data_TX_normal_FIFO+0 
;Transmissor_term2.c,323 :: 		data_TX_normal_FIFO[1]  = HEADER_LENGHT + DATA_LENGHT;
	MOVLW       16
	MOVWF       _data_TX_normal_FIFO+1 
;Transmissor_term2.c,324 :: 		data_TX_normal_FIFO[2]  = 0x01;                        // control frame
	MOVLW       1
	MOVWF       _data_TX_normal_FIFO+2 
;Transmissor_term2.c,325 :: 		data_TX_normal_FIFO[3]  = 0x88;
	MOVLW       136
	MOVWF       _data_TX_normal_FIFO+3 
;Transmissor_term2.c,326 :: 		data_TX_normal_FIFO[4]  = SEQ_NUMBER;                  // sequence number
	MOVF        _SEQ_NUMBER+0, 0 
	MOVWF       _data_TX_normal_FIFO+4 
;Transmissor_term2.c,327 :: 		data_TX_normal_FIFO[5]  = PAN_ID_2[1];                 // destinatoin pan
	MOVF        _PAN_ID_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+5 
;Transmissor_term2.c,328 :: 		data_TX_normal_FIFO[6]  = PAN_ID_2[0];
	MOVF        _PAN_ID_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+6 
;Transmissor_term2.c,329 :: 		data_TX_normal_FIFO[7]  = ADDRESS_short_2[0];          // destination address
	MOVF        _ADDRESS_short_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+7 
;Transmissor_term2.c,330 :: 		data_TX_normal_FIFO[8]  = ADDRESS_short_2[1];
	MOVF        _ADDRESS_short_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+8 
;Transmissor_term2.c,331 :: 		data_TX_normal_FIFO[9]  = PAN_ID_1[0];                 // source pan
	MOVF        _PAN_ID_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+9 
;Transmissor_term2.c,332 :: 		data_TX_normal_FIFO[10] = PAN_ID_1[1];
	MOVF        _PAN_ID_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+10 
;Transmissor_term2.c,333 :: 		data_TX_normal_FIFO[11] = ADDRESS_short_1[0];          // source address
	MOVF        _ADDRESS_short_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+11 
;Transmissor_term2.c,334 :: 		data_TX_normal_FIFO[12] = ADDRESS_short_1[1];
	MOVF        _ADDRESS_short_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+12 
;Transmissor_term2.c,336 :: 		data_TX_normal_FIFO[13] = DATA_TX[0];                  // data
	MOVF        _DATA_TX+0, 0 
	MOVWF       _data_TX_normal_FIFO+13 
;Transmissor_term2.c,337 :: 		data_TX_normal_FIFO[14] = DATA_TX[1];                  // data
	MOVF        _DATA_TX+1, 0 
	MOVWF       _data_TX_normal_FIFO+14 
;Transmissor_term2.c,338 :: 		data_TX_normal_FIFO[15] = DATA_TX[2];                  // data
	MOVF        _DATA_TX+2, 0 
	MOVWF       _data_TX_normal_FIFO+15 
;Transmissor_term2.c,339 :: 		data_TX_normal_FIFO[16] = DATA_TX[3];                  // data
	MOVF        _DATA_TX+3, 0 
	MOVWF       _data_TX_normal_FIFO+16 
;Transmissor_term2.c,340 :: 		data_TX_normal_FIFO[17] = DATA_TX[4];                  // data
	MOVF        _DATA_TX+4, 0 
	MOVWF       _data_TX_normal_FIFO+17 
;Transmissor_term2.c,342 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
L_write_TX_normal_FIFO5:
	MOVLW       128
	XORWF       write_TX_normal_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_TX_normal_FIFO230
	MOVLW       18
	SUBWF       write_TX_normal_FIFO_i_L0+0, 0 
L__write_TX_normal_FIFO230:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_TX_normal_FIFO6
;Transmissor_term2.c,343 :: 		write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]); // write frame into normal FIFO
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
;Transmissor_term2.c,342 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	INFSNZ      write_TX_normal_FIFO_i_L0+0, 1 
	INCF        write_TX_normal_FIFO_i_L0+1, 1 
;Transmissor_term2.c,344 :: 		}
	GOTO        L_write_TX_normal_FIFO5
L_write_TX_normal_FIFO6:
;Transmissor_term2.c,346 :: 		set_ACK();
	CALL        _set_ACK+0, 0
;Transmissor_term2.c,347 :: 		set_not_encrypt();
	CALL        _set_not_encrypt+0, 0
;Transmissor_term2.c,348 :: 		start_transmit();
	CALL        _start_transmit+0, 0
;Transmissor_term2.c,349 :: 		}
	RETURN      0
; end of _write_TX_normal_FIFO

_pin_reset:
;Transmissor_term2.c,357 :: 		void pin_reset() {
;Transmissor_term2.c,358 :: 		RST = 0;  // activate reset
	BCF         LATC1_bit+0, 1 
;Transmissor_term2.c,359 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_pin_reset8:
	DECFSZ      R13, 1, 0
	BRA         L_pin_reset8
	DECFSZ      R12, 1, 0
	BRA         L_pin_reset8
	NOP
	NOP
;Transmissor_term2.c,360 :: 		RST = 1;  // deactivate reset
	BSF         LATC1_bit+0, 1 
;Transmissor_term2.c,361 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_pin_reset9:
	DECFSZ      R13, 1, 0
	BRA         L_pin_reset9
	DECFSZ      R12, 1, 0
	BRA         L_pin_reset9
	NOP
	NOP
;Transmissor_term2.c,362 :: 		}
	RETURN      0
; end of _pin_reset

_PWR_reset:
;Transmissor_term2.c,364 :: 		void PWR_reset() {
;Transmissor_term2.c,365 :: 		write_ZIGBEE_short(SOFTRST, 0x04);   // 0x04  mask for RSTPWR bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       4
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,366 :: 		}
	RETURN      0
; end of _PWR_reset

_BB_reset:
;Transmissor_term2.c,368 :: 		void BB_reset() {
;Transmissor_term2.c,369 :: 		write_ZIGBEE_short(SOFTRST, 0x02);   // 0x02 mask for RSTBB bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,370 :: 		}
	RETURN      0
; end of _BB_reset

_MAC_reset:
;Transmissor_term2.c,372 :: 		void MAC_reset() {
;Transmissor_term2.c,373 :: 		write_ZIGBEE_short(SOFTRST, 0x01);   // 0x01 mask for RSTMAC bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,374 :: 		}
	RETURN      0
; end of _MAC_reset

_software_reset:
;Transmissor_term2.c,376 :: 		void software_reset() {                // PWR_reset,BB_reset and MAC_reset at once
;Transmissor_term2.c,377 :: 		write_ZIGBEE_short(SOFTRST, 0x07);
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,378 :: 		}
	RETURN      0
; end of _software_reset

_RF_reset:
	CLRF        RF_reset_temp_L0+0 
;Transmissor_term2.c,380 :: 		void RF_reset() {
;Transmissor_term2.c,382 :: 		temp = read_ZIGBEE_short(RFCTL);
	MOVLW       54
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;Transmissor_term2.c,383 :: 		temp = temp | 0x04;                  // mask for RFRST bit
	BSF         R0, 2 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;Transmissor_term2.c,384 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,385 :: 		temp = temp & (!0x04);               // mask for RFRST bit
	MOVLW       0
	ANDWF       RF_reset_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;Transmissor_term2.c,386 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,387 :: 		Delay_ms(1);
	MOVLW       3
	MOVWF       R12, 0
	MOVLW       151
	MOVWF       R13, 0
L_RF_reset10:
	DECFSZ      R13, 1, 0
	BRA         L_RF_reset10
	DECFSZ      R12, 1, 0
	BRA         L_RF_reset10
	NOP
	NOP
;Transmissor_term2.c,388 :: 		}
	RETURN      0
; end of _RF_reset

_enable_interrupt:
;Transmissor_term2.c,393 :: 		void enable_interrupt() {
;Transmissor_term2.c,394 :: 		write_ZIGBEE_short(INTCON_M, 0x00);   // 0x00  all interrupts are enable
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CLRF        FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,395 :: 		}
	RETURN      0
; end of _enable_interrupt

_set_channel:
;Transmissor_term2.c,400 :: 		void set_channel(short int channel_number) {               // 11-26 possible channels
;Transmissor_term2.c,401 :: 		if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
	MOVLW       128
	XORLW       26
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel201
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       11
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel201
	GOTO        L_set_channel13
L__set_channel201:
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
L_set_channel13:
;Transmissor_term2.c,402 :: 		switch(channel_number) {
	GOTO        L_set_channel14
;Transmissor_term2.c,403 :: 		case 11:
L_set_channel16:
;Transmissor_term2.c,404 :: 		write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,405 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,406 :: 		case 12:
L_set_channel17:
;Transmissor_term2.c,407 :: 		write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       18
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,408 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,409 :: 		case 13:
L_set_channel18:
;Transmissor_term2.c,410 :: 		write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,411 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,412 :: 		case 14:
L_set_channel19:
;Transmissor_term2.c,413 :: 		write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,414 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,415 :: 		case 15:
L_set_channel20:
;Transmissor_term2.c,416 :: 		write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       66
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,417 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,418 :: 		case 16:
L_set_channel21:
;Transmissor_term2.c,419 :: 		write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       82
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,420 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,421 :: 		case 17:
L_set_channel22:
;Transmissor_term2.c,422 :: 		write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       98
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,423 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,424 :: 		case 18:
L_set_channel23:
;Transmissor_term2.c,425 :: 		write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       114
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,426 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,427 :: 		case 19:
L_set_channel24:
;Transmissor_term2.c,428 :: 		write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       130
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,429 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,430 :: 		case 20:
L_set_channel25:
;Transmissor_term2.c,431 :: 		write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       146
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,432 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,433 :: 		case 21:
L_set_channel26:
;Transmissor_term2.c,434 :: 		write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       162
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,435 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,436 :: 		case 22:
L_set_channel27:
;Transmissor_term2.c,437 :: 		write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       178
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,438 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,439 :: 		case 23:
L_set_channel28:
;Transmissor_term2.c,440 :: 		write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       194
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,441 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,442 :: 		case 24:
L_set_channel29:
;Transmissor_term2.c,443 :: 		write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       210
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,444 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,445 :: 		case 25:
L_set_channel30:
;Transmissor_term2.c,446 :: 		write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       226
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,447 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,448 :: 		case 26:
L_set_channel31:
;Transmissor_term2.c,449 :: 		write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       242
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,450 :: 		break;
	GOTO        L_set_channel15
;Transmissor_term2.c,451 :: 		}
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
;Transmissor_term2.c,452 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;Transmissor_term2.c,453 :: 		}
	RETURN      0
; end of _set_channel

_set_CCA_mode:
;Transmissor_term2.c,458 :: 		void set_CCA_mode(short int CCA_mode) {
;Transmissor_term2.c,460 :: 		switch(CCA_mode) {
	GOTO        L_set_CCA_mode32
;Transmissor_term2.c,461 :: 		case 1: {                               // ENERGY ABOVE THRESHOLD
L_set_CCA_mode34:
;Transmissor_term2.c,462 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,463 :: 		temp = temp | 0x80;                   // 0x80 mask
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,464 :: 		temp = temp & 0xDF;                   // 0xDF mask
	MOVLW       223
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Transmissor_term2.c,465 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,466 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,468 :: 		break;
	GOTO        L_set_CCA_mode33
;Transmissor_term2.c,470 :: 		case 2: {                               // CARRIER SENSE ONLY
L_set_CCA_mode35:
;Transmissor_term2.c,471 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,472 :: 		temp = temp | 0x40;                   // 0x40 mask
	MOVLW       64
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,473 :: 		temp = temp & 0x7F;                   // 0x7F mask
	MOVLW       127
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Transmissor_term2.c,474 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,476 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,477 :: 		temp = temp | 0x38;
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,478 :: 		temp = temp & 0xFB;
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Transmissor_term2.c,479 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,481 :: 		break;
	GOTO        L_set_CCA_mode33
;Transmissor_term2.c,483 :: 		case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
L_set_CCA_mode36:
;Transmissor_term2.c,484 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,485 :: 		temp = temp | 0xC0;                   // 0xC0 mask
	MOVLW       192
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,486 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,488 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,489 :: 		temp = temp | 0x38;                   // 0x38 mask
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,490 :: 		temp = temp & 0xFB;                   // 0xFB mask
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Transmissor_term2.c,491 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,493 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,495 :: 		break;
	GOTO        L_set_CCA_mode33
;Transmissor_term2.c,496 :: 		}
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
;Transmissor_term2.c,497 :: 		}
	RETURN      0
; end of _set_CCA_mode

_set_RSSI_mode:
;Transmissor_term2.c,502 :: 		void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
;Transmissor_term2.c,505 :: 		switch(RSSI_mode) {
	GOTO        L_set_RSSI_mode37
;Transmissor_term2.c,506 :: 		case 1: {
L_set_RSSI_mode39:
;Transmissor_term2.c,507 :: 		temp = read_ZIGBEE_short(BBREG6);
	MOVLW       62
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,508 :: 		temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,509 :: 		write_ZIGBEE_short(BBREG6, temp);
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,511 :: 		break;
	GOTO        L_set_RSSI_mode38
;Transmissor_term2.c,513 :: 		case 2:
L_set_RSSI_mode40:
;Transmissor_term2.c,514 :: 		write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       64
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,515 :: 		break;
	GOTO        L_set_RSSI_mode38
;Transmissor_term2.c,516 :: 		}
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
;Transmissor_term2.c,517 :: 		}
	RETURN      0
; end of _set_RSSI_mode

_nonbeacon_PAN_coordinator_device:
;Transmissor_term2.c,522 :: 		void nonbeacon_PAN_coordinator_device() {
;Transmissor_term2.c,525 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,526 :: 		temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,527 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,529 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,530 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,531 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,533 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,534 :: 		}
	RETURN      0
; end of _nonbeacon_PAN_coordinator_device

_nonbeacon_coordinator_device:
;Transmissor_term2.c,536 :: 		void nonbeacon_coordinator_device() {
;Transmissor_term2.c,539 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,540 :: 		temp = temp | 0x04;                 // 0x04 mask for coordinator
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,541 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,543 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,544 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,545 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,547 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,548 :: 		}
	RETURN      0
; end of _nonbeacon_coordinator_device

_nonbeacon_device:
;Transmissor_term2.c,550 :: 		void nonbeacon_device() {
;Transmissor_term2.c,553 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,554 :: 		temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
	MOVLW       243
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,555 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,557 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,558 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,559 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,560 :: 		}
	RETURN      0
; end of _nonbeacon_device

_set_IFS_recomended:
;Transmissor_term2.c,569 :: 		void set_IFS_recomended() {
;Transmissor_term2.c,572 :: 		write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       147
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,574 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,575 :: 		temp = temp | 0x7C;                 // MinLIFSPeriod
	MOVLW       124
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,576 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,578 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,579 :: 		temp = temp | 0x90;                 // MinLIFSPeriod
	MOVLW       144
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,580 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,582 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,583 :: 		temp = temp | 0x31;                 // TurnaroundTime
	MOVLW       49
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,584 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,585 :: 		}
	RETURN      0
; end of _set_IFS_recomended

_set_IFS_default:
;Transmissor_term2.c,587 :: 		void set_IFS_default() {
;Transmissor_term2.c,590 :: 		write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       117
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,592 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,593 :: 		temp = temp | 0x84;                 // Min LIFS Period
	MOVLW       132
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,594 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,596 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,597 :: 		temp = temp | 0x50;                 // Min LIFS Period
	MOVLW       80
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,598 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,600 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,601 :: 		temp = temp | 0x41;                 // Turnaround Time
	MOVLW       65
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,602 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,603 :: 		}
	RETURN      0
; end of _set_IFS_default

_set_reception_mode:
;Transmissor_term2.c,608 :: 		void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
;Transmissor_term2.c,611 :: 		switch(r_mode) {
	GOTO        L_set_reception_mode41
;Transmissor_term2.c,612 :: 		case 1: {
L_set_reception_mode43:
;Transmissor_term2.c,613 :: 		temp = read_ZIGBEE_short(RXMCR);      // normal mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,614 :: 		temp = temp & (!0x03);                // mask for normal mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,615 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,617 :: 		break;
	GOTO        L_set_reception_mode42
;Transmissor_term2.c,619 :: 		case 2: {
L_set_reception_mode44:
;Transmissor_term2.c,620 :: 		temp = read_ZIGBEE_short(RXMCR);      // error mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,621 :: 		temp = temp & (!0x01);                // mask for error mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,622 :: 		temp = temp | 0x02;                   // mask for error mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;Transmissor_term2.c,623 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,625 :: 		break;
	GOTO        L_set_reception_mode42
;Transmissor_term2.c,627 :: 		case 3: {
L_set_reception_mode45:
;Transmissor_term2.c,628 :: 		temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,629 :: 		temp = temp & (!0x02);                // mask for promiscuous mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,630 :: 		temp = temp | 0x01;                   // mask for promiscuous mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 0 
;Transmissor_term2.c,631 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,633 :: 		break;
	GOTO        L_set_reception_mode42
;Transmissor_term2.c,634 :: 		}
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
;Transmissor_term2.c,635 :: 		}
	RETURN      0
; end of _set_reception_mode

_set_frame_format_filter:
;Transmissor_term2.c,640 :: 		void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
;Transmissor_term2.c,643 :: 		switch(fff_mode) {
	GOTO        L_set_frame_format_filter46
;Transmissor_term2.c,644 :: 		case 1: {
L_set_frame_format_filter48:
;Transmissor_term2.c,645 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // all frames
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,646 :: 		temp = temp & (!0x0E);                  // mask for all frames
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,647 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,649 :: 		break;
	GOTO        L_set_frame_format_filter47
;Transmissor_term2.c,651 :: 		case 2: {
L_set_frame_format_filter49:
;Transmissor_term2.c,652 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // command only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,653 :: 		temp = temp & (!0x06);                  // mask for command only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,654 :: 		temp = temp | 0x08;                     // mask for command only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 3 
;Transmissor_term2.c,655 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,657 :: 		break;
	GOTO        L_set_frame_format_filter47
;Transmissor_term2.c,659 :: 		case 3: {
L_set_frame_format_filter50:
;Transmissor_term2.c,660 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // data only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,661 :: 		temp = temp & (!0x0A);                  // mask for data only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,662 :: 		temp = temp | 0x04;                     // mask for data only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 2 
;Transmissor_term2.c,663 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,665 :: 		break;
	GOTO        L_set_frame_format_filter47
;Transmissor_term2.c,667 :: 		case 4: {
L_set_frame_format_filter51:
;Transmissor_term2.c,668 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,669 :: 		temp = temp & (!0x0C);                  // mask for beacon only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,670 :: 		temp = temp | 0x02;                     // mask for beacon only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;Transmissor_term2.c,671 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,673 :: 		break;
	GOTO        L_set_frame_format_filter47
;Transmissor_term2.c,674 :: 		}
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
;Transmissor_term2.c,675 :: 		}
	RETURN      0
; end of _set_frame_format_filter

_flush_RX_FIFO_pointer:
;Transmissor_term2.c,680 :: 		void flush_RX_FIFO_pointer() {
;Transmissor_term2.c,683 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,684 :: 		temp = temp | 0x01;                        // mask for flush RX FIFO
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,685 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,686 :: 		}
	RETURN      0
; end of _flush_RX_FIFO_pointer

_set_short_address:
;Transmissor_term2.c,691 :: 		void set_short_address(short int * address) {
;Transmissor_term2.c,692 :: 		write_ZIGBEE_short(SADRL, address[0]);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_short_address_address+0, FSR0L
	MOVFF       FARG_set_short_address_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,693 :: 		write_ZIGBEE_short(SADRH, address[1]);
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
;Transmissor_term2.c,694 :: 		}
	RETURN      0
; end of _set_short_address

_set_long_address:
	CLRF        set_long_address_i_L0+0 
;Transmissor_term2.c,696 :: 		void set_long_address(short int * address) {
;Transmissor_term2.c,699 :: 		for(i = 0; i < 8; i++) {
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
;Transmissor_term2.c,700 :: 		write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
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
;Transmissor_term2.c,699 :: 		for(i = 0; i < 8; i++) {
	INCF        set_long_address_i_L0+0, 1 
;Transmissor_term2.c,701 :: 		}
	GOTO        L_set_long_address52
L_set_long_address53:
;Transmissor_term2.c,702 :: 		}
	RETURN      0
; end of _set_long_address

_set_PAN_ID:
;Transmissor_term2.c,704 :: 		void set_PAN_ID(short int * address) {
;Transmissor_term2.c,705 :: 		write_ZIGBEE_short(PANIDL, address[0]);
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_PAN_ID_address+0, FSR0L
	MOVFF       FARG_set_PAN_ID_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,706 :: 		write_ZIGBEE_short(PANIDH, address[1]);
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
;Transmissor_term2.c,707 :: 		}
	RETURN      0
; end of _set_PAN_ID

_set_wake_from_pin:
;Transmissor_term2.c,712 :: 		void set_wake_from_pin() {
;Transmissor_term2.c,715 :: 		WAKE = 0;
	BCF         LATC2_bit+0, 2 
;Transmissor_term2.c,716 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,717 :: 		temp = temp | 0x60;                     // mask
	MOVLW       96
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,718 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,720 :: 		temp = read_ZIGBEE_short(WAKECON);
	MOVLW       34
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Transmissor_term2.c,721 :: 		temp = temp | 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Transmissor_term2.c,722 :: 		write_ZIGBEE_short(WAKECON, temp);
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,723 :: 		}
	RETURN      0
; end of _set_wake_from_pin

_pin_wake:
;Transmissor_term2.c,725 :: 		void pin_wake() {
;Transmissor_term2.c,726 :: 		WAKE = 1;
	BSF         LATC2_bit+0, 2 
;Transmissor_term2.c,727 :: 		Delay_ms(5);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_pin_wake55:
	DECFSZ      R13, 1, 0
	BRA         L_pin_wake55
	DECFSZ      R12, 1, 0
	BRA         L_pin_wake55
	NOP
	NOP
;Transmissor_term2.c,728 :: 		}
	RETURN      0
; end of _pin_wake

_enable_PLL:
;Transmissor_term2.c,733 :: 		void enable_PLL() {
;Transmissor_term2.c,734 :: 		write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,735 :: 		}
	RETURN      0
; end of _enable_PLL

_disable_PLL:
;Transmissor_term2.c,737 :: 		void disable_PLL() {
;Transmissor_term2.c,738 :: 		write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	CLRF        FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,739 :: 		}
	RETURN      0
; end of _disable_PLL

_set_TX_power:
;Transmissor_term2.c,744 :: 		void set_TX_power(unsigned short int power) {             // 0-31 possible variants
;Transmissor_term2.c,745 :: 		if((power < 0) || (power > 31))
	MOVLW       0
	SUBWF       FARG_set_TX_power_power+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power202
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power202
	GOTO        L_set_TX_power58
L__set_TX_power202:
;Transmissor_term2.c,746 :: 		power = 31;
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
L_set_TX_power58:
;Transmissor_term2.c,747 :: 		power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_set_TX_power_power+0 
;Transmissor_term2.c,748 :: 		power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
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
;Transmissor_term2.c,749 :: 		write_ZIGBEE_long(RFCON3, power);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,750 :: 		}
	RETURN      0
; end of _set_TX_power

_init_ZIGBEE_basic:
;Transmissor_term2.c,755 :: 		void init_ZIGBEE_basic() {
;Transmissor_term2.c,756 :: 		write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
	MOVLW       24
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       152
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,757 :: 		write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       149
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Transmissor_term2.c,758 :: 		write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,759 :: 		enable_PLL();                       // Enable PLL (PLLEN = 1)
	CALL        _enable_PLL+0, 0
;Transmissor_term2.c,760 :: 		write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
	MOVLW       6
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       144
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,761 :: 		write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,762 :: 		write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
	MOVLW       8
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,763 :: 		write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
	MOVLW       32
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Transmissor_term2.c,764 :: 		}
	RETURN      0
; end of _init_ZIGBEE_basic

_init_ZIGBEE_nonbeacon:
;Transmissor_term2.c,766 :: 		void init_ZIGBEE_nonbeacon() {
;Transmissor_term2.c,767 :: 		init_ZIGBEE_basic();
	CALL        _init_ZIGBEE_basic+0, 0
;Transmissor_term2.c,768 :: 		set_CCA_mode(1);     // Set CCA mode to ED and set threshold
	MOVLW       1
	MOVWF       FARG_set_CCA_mode_CCA_mode+0 
	CALL        _set_CCA_mode+0, 0
;Transmissor_term2.c,769 :: 		set_RSSI_mode(2);    // RSSI2 mode
	MOVLW       2
	MOVWF       FARG_set_RSSI_mode_RSSI_mode+0 
	CALL        _set_RSSI_mode+0, 0
;Transmissor_term2.c,770 :: 		enable_interrupt();  // Enables all interrupts
	CALL        _enable_interrupt+0, 0
;Transmissor_term2.c,771 :: 		set_channel(11);     // Channel 11
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
	CALL        _set_channel+0, 0
;Transmissor_term2.c,772 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;Transmissor_term2.c,773 :: 		}
	RETURN      0
; end of _init_ZIGBEE_nonbeacon

_Debounce_INT:
	CLRF        Debounce_INT_intn_d_L0+0 
	CLRF        Debounce_INT_j_L0+0 
	CLRF        Debounce_INT_i_L0+0 
;Transmissor_term2.c,775 :: 		char Debounce_INT() {
;Transmissor_term2.c,777 :: 		for(i = 0; i < 5; i++) {
	CLRF        Debounce_INT_i_L0+0 
L_Debounce_INT59:
	MOVLW       5
	SUBWF       Debounce_INT_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT60
;Transmissor_term2.c,778 :: 		intn_d = INT;
	MOVLW       0
	BTFSC       RC6_bit+0, 6 
	MOVLW       1
	MOVWF       Debounce_INT_intn_d_L0+0 
;Transmissor_term2.c,779 :: 		if (intn_d == 1)
	MOVF        Debounce_INT_intn_d_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Debounce_INT62
;Transmissor_term2.c,780 :: 		j++;
	INCF        Debounce_INT_j_L0+0, 1 
L_Debounce_INT62:
;Transmissor_term2.c,777 :: 		for(i = 0; i < 5; i++) {
	INCF        Debounce_INT_i_L0+0, 1 
;Transmissor_term2.c,781 :: 		}
	GOTO        L_Debounce_INT59
L_Debounce_INT60:
;Transmissor_term2.c,782 :: 		if (j > 2)
	MOVF        Debounce_INT_j_L0+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT63
;Transmissor_term2.c,783 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_Debounce_INT63:
;Transmissor_term2.c,785 :: 		return 0;
	CLRF        R0 
;Transmissor_term2.c,786 :: 		}
	RETURN      0
; end of _Debounce_INT

_Decoder_therm:
;Transmissor_term2.c,791 :: 		char Decoder_therm (short int digit, short int code_d){
;Transmissor_term2.c,793 :: 		switch(code_d){
	GOTO        L_Decoder_therm65
;Transmissor_term2.c,794 :: 		case 0b00000111: {
L_Decoder_therm67:
;Transmissor_term2.c,795 :: 		if (digit == 1){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm68
;Transmissor_term2.c,796 :: 		return ' ';
	MOVLW       32
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,797 :: 		}
L_Decoder_therm68:
;Transmissor_term2.c,799 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,800 :: 		case 0b00000101:{
L_Decoder_therm69:
;Transmissor_term2.c,801 :: 		if (digit == 1){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm70
;Transmissor_term2.c,802 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,803 :: 		}
L_Decoder_therm70:
;Transmissor_term2.c,805 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,806 :: 		case 0b00000100:{
L_Decoder_therm71:
;Transmissor_term2.c,807 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm212
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm212
	GOTO        L_Decoder_therm74
L__Decoder_therm212:
;Transmissor_term2.c,808 :: 		return '0';
	MOVLW       48
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,809 :: 		}
L_Decoder_therm74:
;Transmissor_term2.c,811 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,812 :: 		case 0b01101101:{
L_Decoder_therm75:
;Transmissor_term2.c,813 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm211
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm211
	GOTO        L_Decoder_therm78
L__Decoder_therm211:
;Transmissor_term2.c,814 :: 		return '1';
	MOVLW       49
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,815 :: 		}
L_Decoder_therm78:
;Transmissor_term2.c,817 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,818 :: 		case 0b01000010:{
L_Decoder_therm79:
;Transmissor_term2.c,819 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm210
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm210
	GOTO        L_Decoder_therm82
L__Decoder_therm210:
;Transmissor_term2.c,820 :: 		return '2';
	MOVLW       50
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,821 :: 		}
L_Decoder_therm82:
;Transmissor_term2.c,823 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,824 :: 		case 0b01001000:{
L_Decoder_therm83:
;Transmissor_term2.c,825 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm209
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm209
	GOTO        L_Decoder_therm86
L__Decoder_therm209:
;Transmissor_term2.c,826 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,827 :: 		}
L_Decoder_therm86:
;Transmissor_term2.c,829 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,830 :: 		case 0b00101001:{
L_Decoder_therm87:
;Transmissor_term2.c,831 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm208
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm208
	GOTO        L_Decoder_therm90
L__Decoder_therm208:
;Transmissor_term2.c,832 :: 		return '4';
	MOVLW       52
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,833 :: 		}
L_Decoder_therm90:
;Transmissor_term2.c,835 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,836 :: 		case 0b00011000:{
L_Decoder_therm91:
;Transmissor_term2.c,837 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm207
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm207
	GOTO        L_Decoder_therm94
L__Decoder_therm207:
;Transmissor_term2.c,838 :: 		return '5';
	MOVLW       53
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,839 :: 		}
L_Decoder_therm94:
;Transmissor_term2.c,841 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,842 :: 		case 0b00010000:{
L_Decoder_therm95:
;Transmissor_term2.c,843 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm206
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm206
	GOTO        L_Decoder_therm98
L__Decoder_therm206:
;Transmissor_term2.c,844 :: 		return '6';
	MOVLW       54
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,845 :: 		}
L_Decoder_therm98:
;Transmissor_term2.c,847 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,848 :: 		case 0b01001101:{
L_Decoder_therm99:
;Transmissor_term2.c,849 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm205
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm205
	GOTO        L_Decoder_therm102
L__Decoder_therm205:
;Transmissor_term2.c,850 :: 		return '7';
	MOVLW       55
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,851 :: 		}
L_Decoder_therm102:
;Transmissor_term2.c,853 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,854 :: 		case 0b000000000:{
L_Decoder_therm103:
;Transmissor_term2.c,855 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm204
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm204
	GOTO        L_Decoder_therm106
L__Decoder_therm204:
;Transmissor_term2.c,856 :: 		return '8';
	MOVLW       56
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,857 :: 		}
L_Decoder_therm106:
;Transmissor_term2.c,858 :: 		else if (digit == 1){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm108
;Transmissor_term2.c,859 :: 		return '3';
	MOVLW       51
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,860 :: 		}
L_Decoder_therm108:
;Transmissor_term2.c,862 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,863 :: 		case 0b00001000:{
L_Decoder_therm109:
;Transmissor_term2.c,864 :: 		if ((digit == 2) || (digit == 3)){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm203
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__Decoder_therm203
	GOTO        L_Decoder_therm112
L__Decoder_therm203:
;Transmissor_term2.c,865 :: 		return '9';
	MOVLW       57
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,866 :: 		}
L_Decoder_therm112:
;Transmissor_term2.c,868 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,869 :: 		case 0b00100001:{
L_Decoder_therm113:
;Transmissor_term2.c,870 :: 		if (digit == 2){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm114
;Transmissor_term2.c,871 :: 		return 'H';
	MOVLW       72
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,872 :: 		}
L_Decoder_therm114:
;Transmissor_term2.c,874 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,875 :: 		case 0b00110110:{
L_Decoder_therm115:
;Transmissor_term2.c,876 :: 		if (digit == 2){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm116
;Transmissor_term2.c,877 :: 		return 'L';
	MOVLW       76
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,878 :: 		}
L_Decoder_therm116:
;Transmissor_term2.c,880 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,881 :: 		case 0b01110111:{
L_Decoder_therm117:
;Transmissor_term2.c,882 :: 		if (digit == 3){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm118
;Transmissor_term2.c,883 :: 		return 'i';
	MOVLW       105
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,884 :: 		}
L_Decoder_therm118:
;Transmissor_term2.c,886 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,887 :: 		case 0b01110000:{
L_Decoder_therm119:
;Transmissor_term2.c,888 :: 		if (digit == 3){
	MOVF        FARG_Decoder_therm_digit+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Decoder_therm120
;Transmissor_term2.c,889 :: 		return 'o';
	MOVLW       111
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,890 :: 		}
L_Decoder_therm120:
;Transmissor_term2.c,892 :: 		break;
	GOTO        L_Decoder_therm66
;Transmissor_term2.c,893 :: 		default:
L_Decoder_therm121:
;Transmissor_term2.c,894 :: 		return 'E';
	MOVLW       69
	MOVWF       R0 
	RETURN      0
;Transmissor_term2.c,896 :: 		}
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
	GOTO        L__Decoder_therm231
	MOVLW       0
	XORWF       FARG_Decoder_therm_code_d+0, 0 
L__Decoder_therm231:
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
;Transmissor_term2.c,897 :: 		return 'E';
	MOVLW       69
	MOVWF       R0 
;Transmissor_term2.c,898 :: 		}
	RETURN      0
; end of _Decoder_therm

_Read_therm_serial:
;Transmissor_term2.c,901 :: 		void Read_therm_serial(){
;Transmissor_term2.c,903 :: 		dig1=0;
	CLRF        _dig1+0 
;Transmissor_term2.c,904 :: 		dig2=0;
	CLRF        _dig2+0 
;Transmissor_term2.c,905 :: 		dig3=0;
	CLRF        _dig3+0 
;Transmissor_term2.c,906 :: 		degrees=0;
	CLRF        _degrees+0 
;Transmissor_term2.c,907 :: 		battery=0;
	CLRF        _battery+0 
;Transmissor_term2.c,909 :: 		while (H1 == 0) {} // Wait H1 to be 1
L_Read_therm_serial122:
	BTFSC       RB4_bit+0, 4 
	GOTO        L_Read_therm_serial123
	GOTO        L_Read_therm_serial122
L_Read_therm_serial123:
;Transmissor_term2.c,910 :: 		LD = 1;             // Set LD = 1
	BSF         RB3_bit+0, 3 
;Transmissor_term2.c,911 :: 		for (loop = 0; loop < 8; loop++){
	CLRF        Read_therm_serial_loop_L0+0 
L_Read_therm_serial124:
	MOVLW       8
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_therm_serial125
;Transmissor_term2.c,912 :: 		if (loop == 0){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial127
;Transmissor_term2.c,913 :: 		dig1 <<= 1;
	RLCF        _dig1+0, 1 
	BCF         _dig1+0, 0 
;Transmissor_term2.c,914 :: 		dig1 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig1+0, 1 
;Transmissor_term2.c,915 :: 		}
	GOTO        L_Read_therm_serial128
L_Read_therm_serial127:
;Transmissor_term2.c,916 :: 		else if ((loop >= 1) && (loop <= 3)){
	MOVLW       1
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial131
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial131
L__Read_therm_serial217:
;Transmissor_term2.c,917 :: 		dig2 <<= 1;
	RLCF        _dig2+0, 1 
	BCF         _dig2+0, 0 
;Transmissor_term2.c,918 :: 		dig2 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig2+0, 1 
;Transmissor_term2.c,919 :: 		}
	GOTO        L_Read_therm_serial132
L_Read_therm_serial131:
;Transmissor_term2.c,920 :: 		else if ((loop >= 4) && (loop <= 6)){
	MOVLW       4
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial135
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       6
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial135
L__Read_therm_serial216:
;Transmissor_term2.c,921 :: 		dig3 <<= 1;
	RLCF        _dig3+0, 1 
	BCF         _dig3+0, 0 
;Transmissor_term2.c,922 :: 		dig3 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig3+0, 1 
;Transmissor_term2.c,923 :: 		}
	GOTO        L_Read_therm_serial136
L_Read_therm_serial135:
;Transmissor_term2.c,925 :: 		degrees <<= 1;
	RLCF        _degrees+0, 1 
	BCF         _degrees+0, 0 
;Transmissor_term2.c,926 :: 		degrees += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _degrees+0, 1 
;Transmissor_term2.c,927 :: 		}
L_Read_therm_serial136:
L_Read_therm_serial132:
L_Read_therm_serial128:
;Transmissor_term2.c,928 :: 		CLK_therm = 1;   // Generate a pulse of clock
	BSF         RB1_bit+0, 1 
;Transmissor_term2.c,929 :: 		delay_us(500);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_Read_therm_serial137:
	DECFSZ      R13, 1, 0
	BRA         L_Read_therm_serial137
	DECFSZ      R12, 1, 0
	BRA         L_Read_therm_serial137
;Transmissor_term2.c,930 :: 		CLK_therm = 0;
	BCF         RB1_bit+0, 1 
;Transmissor_term2.c,911 :: 		for (loop = 0; loop < 8; loop++){
	INCF        Read_therm_serial_loop_L0+0, 1 
;Transmissor_term2.c,931 :: 		}
	GOTO        L_Read_therm_serial124
L_Read_therm_serial125:
;Transmissor_term2.c,932 :: 		LD = 0; // Set LD = 0
	BCF         RB3_bit+0, 3 
;Transmissor_term2.c,934 :: 		while (H2 == 0) {}    // Wait H2 to be 1
L_Read_therm_serial138:
	BTFSC       RB2_bit+0, 2 
	GOTO        L_Read_therm_serial139
	GOTO        L_Read_therm_serial138
L_Read_therm_serial139:
;Transmissor_term2.c,935 :: 		LD = 1;              // Set LD = 1
	BSF         RB3_bit+0, 3 
;Transmissor_term2.c,936 :: 		for (loop = 0; loop < 8; loop++){
	CLRF        Read_therm_serial_loop_L0+0 
L_Read_therm_serial140:
	MOVLW       8
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_therm_serial141
;Transmissor_term2.c,937 :: 		if (loop == 0){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial143
;Transmissor_term2.c,938 :: 		dig1 <<= 1;
	RLCF        _dig1+0, 1 
	BCF         _dig1+0, 0 
;Transmissor_term2.c,939 :: 		dig1 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig1+0, 1 
;Transmissor_term2.c,940 :: 		}
	GOTO        L_Read_therm_serial144
L_Read_therm_serial143:
;Transmissor_term2.c,941 :: 		else if ((loop >= 1) && (loop <= 3)){
	MOVLW       1
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial147
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       3
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial147
L__Read_therm_serial215:
;Transmissor_term2.c,942 :: 		dig2 <<= 1;
	RLCF        _dig2+0, 1 
	BCF         _dig2+0, 0 
;Transmissor_term2.c,943 :: 		dig2 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig2+0, 1 
;Transmissor_term2.c,944 :: 		}
	GOTO        L_Read_therm_serial148
L_Read_therm_serial147:
;Transmissor_term2.c,945 :: 		else if ((loop >= 4) && (loop <= 6)){
	MOVLW       4
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial151
	MOVF        Read_therm_serial_loop_L0+0, 0 
	SUBLW       6
	BTFSS       STATUS+0, 0 
	GOTO        L_Read_therm_serial151
L__Read_therm_serial214:
;Transmissor_term2.c,946 :: 		dig3 <<= 1;
	RLCF        _dig3+0, 1 
	BCF         _dig3+0, 0 
;Transmissor_term2.c,947 :: 		dig3 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig3+0, 1 
;Transmissor_term2.c,948 :: 		}
	GOTO        L_Read_therm_serial152
L_Read_therm_serial151:
;Transmissor_term2.c,950 :: 		degrees <<= 1;
	RLCF        _degrees+0, 1 
	BCF         _degrees+0, 0 
;Transmissor_term2.c,951 :: 		degrees += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _degrees+0, 1 
;Transmissor_term2.c,952 :: 		}
L_Read_therm_serial152:
L_Read_therm_serial148:
L_Read_therm_serial144:
;Transmissor_term2.c,953 :: 		CLK_therm = 1;   // Generate a pulse of clock
	BSF         RB1_bit+0, 1 
;Transmissor_term2.c,954 :: 		delay_us(500);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_Read_therm_serial153:
	DECFSZ      R13, 1, 0
	BRA         L_Read_therm_serial153
	DECFSZ      R12, 1, 0
	BRA         L_Read_therm_serial153
;Transmissor_term2.c,955 :: 		CLK_therm = 0;
	BCF         RB1_bit+0, 1 
;Transmissor_term2.c,936 :: 		for (loop = 0; loop < 8; loop++){
	INCF        Read_therm_serial_loop_L0+0, 1 
;Transmissor_term2.c,956 :: 		}
	GOTO        L_Read_therm_serial140
L_Read_therm_serial141:
;Transmissor_term2.c,957 :: 		LD = 0; // Set LD = 0
	BCF         RB3_bit+0, 3 
;Transmissor_term2.c,959 :: 		while (H3 == 0) {}          // Wait H3 to be 1
L_Read_therm_serial154:
	BTFSC       RB0_bit+0, 0 
	GOTO        L_Read_therm_serial155
	GOTO        L_Read_therm_serial154
L_Read_therm_serial155:
;Transmissor_term2.c,960 :: 		LD = 1;                    // Set LD = 1
	BSF         RB3_bit+0, 3 
;Transmissor_term2.c,961 :: 		for (loop = 0; loop < 8; loop++){
	CLRF        Read_therm_serial_loop_L0+0 
L_Read_therm_serial156:
	MOVLW       8
	SUBWF       Read_therm_serial_loop_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Read_therm_serial157
;Transmissor_term2.c,962 :: 		if (loop == 0){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial159
;Transmissor_term2.c,963 :: 		dig1 <<= 1;
	RLCF        _dig1+0, 1 
	BCF         _dig1+0, 0 
;Transmissor_term2.c,964 :: 		dig1 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig1+0, 1 
;Transmissor_term2.c,965 :: 		}
	GOTO        L_Read_therm_serial160
L_Read_therm_serial159:
;Transmissor_term2.c,966 :: 		else if (loop == 2){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial161
;Transmissor_term2.c,967 :: 		dig2 <<= 1;
	RLCF        _dig2+0, 1 
	BCF         _dig2+0, 0 
;Transmissor_term2.c,968 :: 		dig2 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig2+0, 1 
;Transmissor_term2.c,969 :: 		}
	GOTO        L_Read_therm_serial162
L_Read_therm_serial161:
;Transmissor_term2.c,970 :: 		else if (loop == 5){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial163
;Transmissor_term2.c,971 :: 		dig3 <<= 1;
	RLCF        _dig3+0, 1 
	BCF         _dig3+0, 0 
;Transmissor_term2.c,972 :: 		dig3 += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _dig3+0, 1 
;Transmissor_term2.c,973 :: 		}
	GOTO        L_Read_therm_serial164
L_Read_therm_serial163:
;Transmissor_term2.c,974 :: 		else if (loop == 6){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial165
;Transmissor_term2.c,975 :: 		battery = Serial_in;
	MOVLW       0
	BTFSC       LATB7_bit+0, 7 
	MOVLW       1
	MOVWF       _battery+0 
;Transmissor_term2.c,976 :: 		}
	GOTO        L_Read_therm_serial166
L_Read_therm_serial165:
;Transmissor_term2.c,977 :: 		else if (loop == 7){
	MOVF        Read_therm_serial_loop_L0+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial167
;Transmissor_term2.c,978 :: 		degrees <<= 1;
	RLCF        _degrees+0, 1 
	BCF         _degrees+0, 0 
;Transmissor_term2.c,979 :: 		degrees += Serial_in;
	CLRF        R0 
	BTFSC       LATB7_bit+0, 7 
	INCF        R0, 1 
	MOVF        R0, 0 
	ADDWF       _degrees+0, 1 
;Transmissor_term2.c,980 :: 		}
L_Read_therm_serial167:
L_Read_therm_serial166:
L_Read_therm_serial164:
L_Read_therm_serial162:
L_Read_therm_serial160:
;Transmissor_term2.c,981 :: 		CLK_therm = 1;    // Generate a pulse of clock
	BSF         RB1_bit+0, 1 
;Transmissor_term2.c,982 :: 		delay_us(500);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_Read_therm_serial168:
	DECFSZ      R13, 1, 0
	BRA         L_Read_therm_serial168
	DECFSZ      R12, 1, 0
	BRA         L_Read_therm_serial168
;Transmissor_term2.c,983 :: 		CLK_therm = 0;
	BCF         RB1_bit+0, 1 
;Transmissor_term2.c,961 :: 		for (loop = 0; loop < 8; loop++){
	INCF        Read_therm_serial_loop_L0+0, 1 
;Transmissor_term2.c,984 :: 		}
	GOTO        L_Read_therm_serial156
L_Read_therm_serial157:
;Transmissor_term2.c,985 :: 		LD = 0;   // Set LD = 0
	BCF         RB3_bit+0, 3 
;Transmissor_term2.c,987 :: 		dig1 = Decoder_therm(1, dig1);
	MOVLW       1
	MOVWF       FARG_Decoder_therm_digit+0 
	MOVF        _dig1+0, 0 
	MOVWF       FARG_Decoder_therm_code_d+0 
	CALL        _Decoder_therm+0, 0
	MOVF        R0, 0 
	MOVWF       _dig1+0 
;Transmissor_term2.c,988 :: 		dig2 = Decoder_therm(2, dig2);
	MOVLW       2
	MOVWF       FARG_Decoder_therm_digit+0 
	MOVF        _dig2+0, 0 
	MOVWF       FARG_Decoder_therm_code_d+0 
	CALL        _Decoder_therm+0, 0
	MOVF        R0, 0 
	MOVWF       _dig2+0 
;Transmissor_term2.c,989 :: 		dig3 = Decoder_therm(3, dig3);
	MOVLW       3
	MOVWF       FARG_Decoder_therm_digit+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Decoder_therm_code_d+0 
	CALL        _Decoder_therm+0, 0
	MOVF        R0, 0 
	MOVWF       _dig3+0 
;Transmissor_term2.c,991 :: 		Lcd_Chr(1, 1, dig1);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig1+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,992 :: 		Lcd_Chr(1, 2, dig2);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig2+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,993 :: 		if ((dig3 == 'i')||(dig3 == 'o')){
	MOVF        _dig3+0, 0 
	XORLW       105
	BTFSC       STATUS+0, 2 
	GOTO        L__Read_therm_serial213
	MOVF        _dig3+0, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L__Read_therm_serial213
	GOTO        L_Read_therm_serial171
L__Read_therm_serial213:
;Transmissor_term2.c,994 :: 		Lcd_Chr(1, 3, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,995 :: 		Lcd_Chr(1, 4, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,996 :: 		}else{
	GOTO        L_Read_therm_serial172
L_Read_therm_serial171:
;Transmissor_term2.c,997 :: 		Lcd_Chr(1, 3, '.');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,998 :: 		Lcd_Chr(1, 4, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,999 :: 		}
L_Read_therm_serial172:
;Transmissor_term2.c,1001 :: 		if (battery == 1){
	MOVF        _battery+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial173
;Transmissor_term2.c,1002 :: 		battery = 'b';
	MOVLW       98
	MOVWF       _battery+0 
;Transmissor_term2.c,1003 :: 		Lcd_Out(2, 0, "           ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Transmissor_term2.c,1004 :: 		}
	GOTO        L_Read_therm_serial174
L_Read_therm_serial173:
;Transmissor_term2.c,1006 :: 		battery = 'B';
	MOVLW       66
	MOVWF       _battery+0 
;Transmissor_term2.c,1007 :: 		Lcd_Out(2, 0, "low battery");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Transmissor_term2.c,1008 :: 		}
L_Read_therm_serial174:
;Transmissor_term2.c,1010 :: 		if (degrees == 2){
	MOVF        _degrees+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Read_therm_serial175
;Transmissor_term2.c,1011 :: 		degrees = 'C';
	MOVLW       67
	MOVWF       _degrees+0 
;Transmissor_term2.c,1012 :: 		Lcd_Chr(1, 5, 'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1013 :: 		}
	GOTO        L_Read_therm_serial176
L_Read_therm_serial175:
;Transmissor_term2.c,1015 :: 		degrees = 'c';
	MOVLW       99
	MOVWF       _degrees+0 
;Transmissor_term2.c,1016 :: 		Lcd_Chr(1, 5, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1017 :: 		}
L_Read_therm_serial176:
;Transmissor_term2.c,1018 :: 		}
	RETURN      0
; end of _Read_therm_serial

_Initialize:
	CLRF        Initialize_i_L0+0 
;Transmissor_term2.c,1021 :: 		void Initialize() {
;Transmissor_term2.c,1024 :: 		LQI = 0;
	CLRF        _LQI+0 
;Transmissor_term2.c,1025 :: 		RSSI2 = 0;
	CLRF        _RSSI2+0 
;Transmissor_term2.c,1026 :: 		SEQ_NUMBER = 0x23;
	MOVLW       35
	MOVWF       _SEQ_NUMBER+0 
;Transmissor_term2.c,1027 :: 		lost_data = 0;
	CLRF        _lost_data+0 
;Transmissor_term2.c,1028 :: 		address_RX_FIFO = 0x300;
	MOVLW       0
	MOVWF       _address_RX_FIFO+0 
	MOVLW       3
	MOVWF       _address_RX_FIFO+1 
;Transmissor_term2.c,1029 :: 		address_TX_normal_FIFO = 0;
	CLRF        _address_TX_normal_FIFO+0 
	CLRF        _address_TX_normal_FIFO+1 
;Transmissor_term2.c,1031 :: 		for (i = 0; i < 2; i++) {
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
;Transmissor_term2.c,1032 :: 		ADDRESS_short_1[i] = 1;
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
;Transmissor_term2.c,1033 :: 		ADDRESS_short_2[i] = 2;
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
;Transmissor_term2.c,1034 :: 		PAN_ID_1[i] = 3;
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
;Transmissor_term2.c,1035 :: 		PAN_ID_2[i] = 3;
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
;Transmissor_term2.c,1031 :: 		for (i = 0; i < 2; i++) {
	INCF        Initialize_i_L0+0, 1 
;Transmissor_term2.c,1036 :: 		}
	GOTO        L_Initialize177
L_Initialize178:
;Transmissor_term2.c,1038 :: 		for (i = 0; i < 8; i++) {
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
;Transmissor_term2.c,1039 :: 		ADDRESS_long_1[i] = 1;
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
;Transmissor_term2.c,1040 :: 		ADDRESS_long_2[i] = 2;
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
;Transmissor_term2.c,1038 :: 		for (i = 0; i < 8; i++) {
	INCF        Initialize_i_L0+0, 1 
;Transmissor_term2.c,1041 :: 		}
	GOTO        L_Initialize180
L_Initialize181:
;Transmissor_term2.c,1043 :: 		ADCON1 = 0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;Transmissor_term2.c,1044 :: 		GIE_bit = 0;           // Disable interrupts
	BCF         GIE_bit+0, 7 
;Transmissor_term2.c,1046 :: 		TRISA = 0x00;          // Set direction to be output
	CLRF        TRISA+0 
;Transmissor_term2.c,1047 :: 		TRISB = 0x00;          // Set direction to be output
	CLRF        TRISB+0 
;Transmissor_term2.c,1048 :: 		TRISC = 0x00;          // Set direction to be output
	CLRF        TRISC+0 
;Transmissor_term2.c,1049 :: 		TRISD = 0x00;          // Set direction to be output
	CLRF        TRISD+0 
;Transmissor_term2.c,1051 :: 		CS2_Direction = 0;      // Set direction to be output
	BCF         TRISC0_bit+0, 0 
;Transmissor_term2.c,1052 :: 		RST_Direction  = 0;    // Set direction to be output
	BCF         TRISC1_bit+0, 1 
;Transmissor_term2.c,1053 :: 		INT_Direction  = 1;    // Set direction to be input
	BSF         TRISC6_bit+0, 6 
;Transmissor_term2.c,1054 :: 		WAKE_Direction = 0;    // Set direction to be output
	BCF         TRISC2_bit+0, 2 
;Transmissor_term2.c,1057 :: 		H3_Direction = 1;      // Direcao pinos termometro
	BSF         TRISB0_bit+0, 0 
;Transmissor_term2.c,1058 :: 		H2_Direction = 1;
	BSF         TRISB2_bit+0, 2 
;Transmissor_term2.c,1059 :: 		H1_Direction = 1;
	BSF         TRISB4_bit+0, 4 
;Transmissor_term2.c,1060 :: 		Serial_in_Direction = 1;
	BSF         TRISB7_bit+0, 7 
;Transmissor_term2.c,1061 :: 		LD_Direction = 0;
	BCF         TRISB1_bit+0, 1 
;Transmissor_term2.c,1062 :: 		CLK_therm_Direction = 0;
	BCF         TRISB3_bit+0, 3 
;Transmissor_term2.c,1064 :: 		DATA_TX[0] = 0;        // Initialize first byte
	CLRF        _DATA_TX+0 
;Transmissor_term2.c,1065 :: 		DATA_TX[1] = 0;        // Initialize first byte
	CLRF        _DATA_TX+1 
;Transmissor_term2.c,1066 :: 		DATA_TX[2] = 0;        // Initialize first byte
	CLRF        _DATA_TX+2 
;Transmissor_term2.c,1067 :: 		DATA_TX[3] = 0;        // Initialize first byte
	CLRF        _DATA_TX+3 
;Transmissor_term2.c,1068 :: 		DATA_TX[4] = 0;        // Initialize first byte
	CLRF        _DATA_TX+4 
;Transmissor_term2.c,1070 :: 		PORTD = 0;             // Clear PORTD register
	CLRF        PORTD+0 
;Transmissor_term2.c,1071 :: 		LATD  = 0;             // Clear LATD register
	CLRF        LATD+0 
;Transmissor_term2.c,1073 :: 		Delay_ms(15);
	MOVLW       39
	MOVWF       R12, 0
	MOVLW       245
	MOVWF       R13, 0
L_Initialize183:
	DECFSZ      R13, 1, 0
	BRA         L_Initialize183
	DECFSZ      R12, 1, 0
	BRA         L_Initialize183
;Transmissor_term2.c,1075 :: 		Lcd_Init();                        // Initialize LCD
	CALL        _Lcd_Init+0, 0
;Transmissor_term2.c,1076 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Transmissor_term2.c,1077 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;Transmissor_term2.c,1080 :: 		SPI1_Init_AdvancEd(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;Transmissor_term2.c,1081 :: 		pin_reset();                              // Activate reset from pin
	CALL        _pin_reset+0, 0
;Transmissor_term2.c,1082 :: 		software_reset();                         // Activate software reset
	CALL        _software_reset+0, 0
;Transmissor_term2.c,1083 :: 		RF_reset();                               // RF reset
	CALL        _RF_reset+0, 0
;Transmissor_term2.c,1084 :: 		set_WAKE_from_pin();                      // Set wake from pin
	CALL        _set_wake_from_pin+0, 0
;Transmissor_term2.c,1086 :: 		set_long_address(ADDRESS_long_1);         // Set long address
	MOVLW       _ADDRESS_long_1+0
	MOVWF       FARG_set_long_address_address+0 
	MOVLW       hi_addr(_ADDRESS_long_1+0
	MOVWF       FARG_set_long_address_address+1 
	CALL        _set_long_address+0, 0
;Transmissor_term2.c,1087 :: 		set_short_address(ADDRESS_short_1);       // Set short address
	MOVLW       _ADDRESS_short_1+0
	MOVWF       FARG_set_short_address_address+0 
	MOVLW       hi_addr(_ADDRESS_short_1+0
	MOVWF       FARG_set_short_address_address+1 
	CALL        _set_short_address+0, 0
;Transmissor_term2.c,1088 :: 		set_PAN_ID(PAN_ID_1);                     // Set PAN_ID
	MOVLW       _PAN_ID_1+0
	MOVWF       FARG_set_PAN_ID_address+0 
	MOVLW       hi_addr(_PAN_ID_1+0
	MOVWF       FARG_set_PAN_ID_address+1 
	CALL        _set_PAN_ID+0, 0
;Transmissor_term2.c,1090 :: 		init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
	CALL        _init_ZIGBEE_nonbeacon+0, 0
;Transmissor_term2.c,1091 :: 		nonbeacon_PAN_coordinator_device();
	CALL        _nonbeacon_PAN_coordinator_device+0, 0
;Transmissor_term2.c,1092 :: 		set_TX_power(31);                         // Set max TX power
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
	CALL        _set_TX_power+0, 0
;Transmissor_term2.c,1093 :: 		set_frame_format_filter(1);               // 1 all frames, 3 data frame only
	MOVLW       1
	MOVWF       FARG_set_frame_format_filter_fff_mode+0 
	CALL        _set_frame_format_filter+0, 0
;Transmissor_term2.c,1094 :: 		set_reception_mode(1);                    // 1 normal mode
	MOVLW       1
	MOVWF       FARG_set_reception_mode_r_mode+0 
	CALL        _set_reception_mode+0, 0
;Transmissor_term2.c,1096 :: 		pin_wake();                               // Wake from pin
	CALL        _pin_wake+0, 0
;Transmissor_term2.c,1097 :: 		}
	RETURN      0
; end of _Initialize

_main:
	CLRF        main_trans_L0+0 
	CLRF        main_trans_L0+1 
;Transmissor_term2.c,1101 :: 		void main() {
;Transmissor_term2.c,1106 :: 		Initialize();                      // Initialize MCU and Bee click board
	CALL        _Initialize+0, 0
;Transmissor_term2.c,1107 :: 		Lcd_Out(2, 0, "Iniciando");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Transmissor_term2.c,1109 :: 		while(1) {
L_main184:
;Transmissor_term2.c,1111 :: 		if(trans == 0){
	MOVLW       0
	XORWF       main_trans_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main232
	MOVLW       0
	XORWF       main_trans_L0+0, 0 
L__main232:
	BTFSS       STATUS+0, 2 
	GOTO        L_main186
;Transmissor_term2.c,1112 :: 		if(Debounce_INT() == 0 ){
	CALL        _Debounce_INT+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main187
;Transmissor_term2.c,1113 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
	MOVLW       49
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       _temp1+0 
;Transmissor_term2.c,1114 :: 		read_RX_FIFO();                     // Read receive data
	CALL        _read_RX_FIFO+0, 0
;Transmissor_term2.c,1115 :: 		dig1=DATA_RX[0];
	MOVF        _DATA_RX+0, 0 
	MOVWF       _dig1+0 
;Transmissor_term2.c,1116 :: 		dig2=DATA_RX[1];
	MOVF        _DATA_RX+1, 0 
	MOVWF       _dig2+0 
;Transmissor_term2.c,1117 :: 		dig3=DATA_RX[2];
	MOVF        _DATA_RX+2, 0 
	MOVWF       _dig3+0 
;Transmissor_term2.c,1118 :: 		degrees=DATA_RX[3];
	MOVF        _DATA_RX+3, 0 
	MOVWF       _degrees+0 
;Transmissor_term2.c,1119 :: 		battery=DATA_RX[4];
	MOVF        _DATA_RX+4, 0 
	MOVWF       _battery+0 
;Transmissor_term2.c,1121 :: 		Lcd_Chr(1, 1, dig1);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _DATA_RX+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1122 :: 		Lcd_Chr(1, 2, dig2);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig2+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1123 :: 		if ((dig3 == 'i')||(dig3 == 'o')){
	MOVF        _dig3+0, 0 
	XORLW       105
	BTFSC       STATUS+0, 2 
	GOTO        L__main218
	MOVF        _dig3+0, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L__main218
	GOTO        L_main190
L__main218:
;Transmissor_term2.c,1124 :: 		Lcd_Chr(1, 3, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1125 :: 		Lcd_Chr(1, 4, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1126 :: 		}
	GOTO        L_main191
L_main190:
;Transmissor_term2.c,1128 :: 		Lcd_Chr(1, 3, '.');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1129 :: 		Lcd_Chr(1, 4, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _dig3+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1130 :: 		}
L_main191:
;Transmissor_term2.c,1132 :: 		if (battery == 'b'){
	MOVF        _battery+0, 0 
	XORLW       98
	BTFSS       STATUS+0, 2 
	GOTO        L_main192
;Transmissor_term2.c,1133 :: 		Lcd_Out(2, 0, "           ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Transmissor_term2.c,1134 :: 		}
	GOTO        L_main193
L_main192:
;Transmissor_term2.c,1136 :: 		Lcd_Out(2, 0, "low battery");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Transmissor_term2.c,1137 :: 		}
L_main193:
;Transmissor_term2.c,1139 :: 		if (degrees == 'C'){
	MOVF        _degrees+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main194
;Transmissor_term2.c,1140 :: 		Lcd_Chr(1, 5, 'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1141 :: 		}
	GOTO        L_main195
L_main194:
;Transmissor_term2.c,1143 :: 		Lcd_Chr(1, 5, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Transmissor_term2.c,1144 :: 		}
L_main195:
;Transmissor_term2.c,1145 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main196:
	DECFSZ      R13, 1, 0
	BRA         L_main196
	DECFSZ      R12, 1, 0
	BRA         L_main196
	DECFSZ      R11, 1, 0
	BRA         L_main196
	NOP
;Transmissor_term2.c,1146 :: 		trans=1;
	MOVLW       1
	MOVWF       main_trans_L0+0 
	MOVLW       0
	MOVWF       main_trans_L0+1 
;Transmissor_term2.c,1147 :: 		}
L_main187:
;Transmissor_term2.c,1148 :: 		}
L_main186:
;Transmissor_term2.c,1149 :: 		if(trans == 1){
	MOVLW       0
	XORWF       main_trans_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main233
	MOVLW       1
	XORWF       main_trans_L0+0, 0 
L__main233:
	BTFSS       STATUS+0, 2 
	GOTO        L_main197
;Transmissor_term2.c,1150 :: 		Lcd_Out(2, 0, "Modo TX");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_Transmissor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Transmissor_term2.c,1151 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main198:
	DECFSZ      R13, 1, 0
	BRA         L_main198
	DECFSZ      R12, 1, 0
	BRA         L_main198
	DECFSZ      R11, 1, 0
	BRA         L_main198
	NOP
;Transmissor_term2.c,1153 :: 		DATA_TX[0]=1;
	MOVLW       1
	MOVWF       _DATA_TX+0 
;Transmissor_term2.c,1154 :: 		DATA_TX[1]=2;
	MOVLW       2
	MOVWF       _DATA_TX+1 
;Transmissor_term2.c,1155 :: 		DATA_TX[2]=3;
	MOVLW       3
	MOVWF       _DATA_TX+2 
;Transmissor_term2.c,1156 :: 		DATA_TX[3]=4;
	MOVLW       4
	MOVWF       _DATA_TX+3 
;Transmissor_term2.c,1157 :: 		DATA_TX[4]=5;
	MOVLW       5
	MOVWF       _DATA_TX+4 
;Transmissor_term2.c,1158 :: 		write_TX_normal_FIFO();
	CALL        _write_TX_normal_FIFO+0, 0
;Transmissor_term2.c,1160 :: 		temp1 = read_ZIGBEE_short(TXSTAT);
	MOVLW       36
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       _temp1+0 
;Transmissor_term2.c,1161 :: 		temp1 = temp1 & 0x01;
	MOVLW       1
	ANDWF       R0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       _temp1+0 
;Transmissor_term2.c,1163 :: 		if(temp1 == 0x00){
	MOVLW       0
	BTFSC       R1, 7 
	MOVLW       255
	MOVWF       R0 
	MOVLW       0
	XORWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main234
	MOVLW       0
	XORWF       R1, 0 
L__main234:
	BTFSS       STATUS+0, 2 
	GOTO        L_main199
;Transmissor_term2.c,1164 :: 		delay_ms(100);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main200:
	DECFSZ      R13, 1, 0
	BRA         L_main200
	DECFSZ      R12, 1, 0
	BRA         L_main200
	DECFSZ      R11, 1, 0
	BRA         L_main200
	NOP
;Transmissor_term2.c,1165 :: 		trans = 0;
	CLRF        main_trans_L0+0 
	CLRF        main_trans_L0+1 
;Transmissor_term2.c,1166 :: 		}
L_main199:
;Transmissor_term2.c,1167 :: 		}
L_main197:
;Transmissor_term2.c,1169 :: 		}
	GOTO        L_main184
;Transmissor_term2.c,1170 :: 		}
	GOTO        $+0
; end of _main
