
_write_ZIGBEE_short:
;Receptor_term2.c,161 :: 		void write_ZIGBEE_short(short int address, short int data_r) {
;Receptor_term2.c,162 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Receptor_term2.c,164 :: 		address = ((address << 1) & 0b01111111) | 0x01; // calculating addressing mode
	MOVF        FARG_write_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       127
	ANDWF       R0, 1 
	BSF         R0, 0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_address+0 
;Receptor_term2.c,165 :: 		SPI1_Write(address);       // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,166 :: 		SPI1_Write(data_r);        // write data in register
	MOVF        FARG_write_ZIGBEE_short_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,168 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Receptor_term2.c,169 :: 		}
	RETURN      0
; end of _write_ZIGBEE_short

_read_ZIGBEE_short:
	CLRF        read_ZIGBEE_short_dummy_data_r_L0+0 
;Receptor_term2.c,172 :: 		short int read_ZIGBEE_short(short int address) {
;Receptor_term2.c,175 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Receptor_term2.c,177 :: 		address = (address << 1) & 0b01111110;      // calculating addressing mode
	MOVF        FARG_read_ZIGBEE_short_address+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       126
	ANDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       FARG_read_ZIGBEE_short_address+0 
;Receptor_term2.c,178 :: 		SPI1_Write(address);                        // addressing register
	MOVF        R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,179 :: 		data_r = SPI1_Read(dummy_data_r);           // read data from register
	MOVF        read_ZIGBEE_short_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;Receptor_term2.c,181 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Receptor_term2.c,182 :: 		return data_r;
;Receptor_term2.c,183 :: 		}
	RETURN      0
; end of _read_ZIGBEE_short

_write_ZIGBEE_long:
	CLRF        write_ZIGBEE_long_address_low_L0+0 
;Receptor_term2.c,189 :: 		void write_ZIGBEE_long(int address, short int data_r) {
;Receptor_term2.c,192 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Receptor_term2.c,194 :: 		address_high = (((short int)(address >> 3)) & 0b01111111) | 0x80;  // calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__write_ZIGBEE_long85:
	BZ          L__write_ZIGBEE_long86
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long85
L__write_ZIGBEE_long86:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;Receptor_term2.c,195 :: 		address_low  = (((short int)(address << 5)) & 0b11100000) | 0x10;  // calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_write_ZIGBEE_long_address+0, 0 
	MOVWF       write_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__write_ZIGBEE_long87:
	BZ          L__write_ZIGBEE_long88
	RLCF        write_ZIGBEE_long_address_low_L0+0, 1 
	BCF         write_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__write_ZIGBEE_long87
L__write_ZIGBEE_long88:
	MOVLW       224
	ANDWF       write_ZIGBEE_long_address_low_L0+0, 1 
	BSF         write_ZIGBEE_long_address_low_L0+0, 4 
;Receptor_term2.c,196 :: 		SPI1_Write(address_high);           // addressing register
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,197 :: 		SPI1_Write(address_low);            // addressing register
	MOVF        write_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,198 :: 		SPI1_Write(data_r);                 // write data in registerr
	MOVF        FARG_write_ZIGBEE_long_data_r+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,200 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Receptor_term2.c,201 :: 		}
	RETURN      0
; end of _write_ZIGBEE_long

_read_ZIGBEE_long:
	CLRF        read_ZIGBEE_long_address_low_L0+0 
	CLRF        read_ZIGBEE_long_dummy_data_r_L0+0 
;Receptor_term2.c,204 :: 		short int read_ZIGBEE_long(int address) {
;Receptor_term2.c,208 :: 		CS2 = 0;
	BCF         LATC0_bit+0, 0 
;Receptor_term2.c,210 :: 		address_high = ((short int)(address >> 3) & 0b01111111) | 0x80;  //calculating addressing mode
	MOVLW       3
	MOVWF       R2 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+1, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__read_ZIGBEE_long89:
	BZ          L__read_ZIGBEE_long90
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long89
L__read_ZIGBEE_long90:
	MOVLW       127
	ANDWF       R0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	BSF         FARG_SPI1_Write_data_+0, 7 
;Receptor_term2.c,211 :: 		address_low  = ((short int)(address << 5) & 0b11100000);         //calculating addressing mode
	MOVLW       5
	MOVWF       R0 
	MOVF        FARG_read_ZIGBEE_long_address+0, 0 
	MOVWF       read_ZIGBEE_long_address_low_L0+0 
	MOVF        R0, 0 
L__read_ZIGBEE_long91:
	BZ          L__read_ZIGBEE_long92
	RLCF        read_ZIGBEE_long_address_low_L0+0, 1 
	BCF         read_ZIGBEE_long_address_low_L0+0, 0 
	ADDLW       255
	GOTO        L__read_ZIGBEE_long91
L__read_ZIGBEE_long92:
	MOVLW       224
	ANDWF       read_ZIGBEE_long_address_low_L0+0, 1 
;Receptor_term2.c,212 :: 		SPI1_Write(address_high);            // addressing register
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,213 :: 		SPI1_Write(address_low);             // addressing register
	MOVF        read_ZIGBEE_long_address_low_L0+0, 0 
	MOVWF       FARG_SPI1_Write_data_+0 
	CALL        _SPI1_Write+0, 0
;Receptor_term2.c,214 :: 		data_r = SPI1_Read(dummy_data_r);    // read data from register
	MOVF        read_ZIGBEE_long_dummy_data_r_L0+0, 0 
	MOVWF       FARG_SPI1_Read_buffer+0 
	CALL        _SPI1_Read+0, 0
;Receptor_term2.c,216 :: 		CS2 = 1;
	BSF         LATC0_bit+0, 0 
;Receptor_term2.c,217 :: 		return data_r;
;Receptor_term2.c,218 :: 		}
	RETURN      0
; end of _read_ZIGBEE_long

_start_transmit:
;Receptor_term2.c,223 :: 		void start_transmit() {
;Receptor_term2.c,226 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,227 :: 		temp = temp | 0x01;                 // mask for start transmit
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,228 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,229 :: 		}
	RETURN      0
; end of _start_transmit

_read_RX_FIFO:
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
;Receptor_term2.c,234 :: 		void read_RX_FIFO() {
;Receptor_term2.c,238 :: 		temp = read_ZIGBEE_short(BBREG1);      // disable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,239 :: 		temp = temp | 0x04;                    // mask for disable receiving packets
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,240 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,242 :: 		for(i=0; i<128; i++) {
	CLRF        read_RX_FIFO_i_L0+0 
	CLRF        read_RX_FIFO_i_L0+1 
L_read_RX_FIFO0:
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO93
	MOVLW       128
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO93:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO1
;Receptor_term2.c,243 :: 		if(i <  (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO94
	MOVLW       21
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO94:
	BTFSC       STATUS+0, 0 
	GOTO        L_read_RX_FIFO3
;Receptor_term2.c,244 :: 		data_RX_FIFO[i] = read_ZIGBEE_long(address_RX_FIFO + i);  // reading valid data from RX FIFO
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
;Receptor_term2.c,245 :: 		if(i >= (1 + DATA_LENGHT + HEADER_LENGHT + 2 + 1 + 1))
	MOVLW       128
	XORWF       read_RX_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__read_RX_FIFO95
	MOVLW       21
	SUBWF       read_RX_FIFO_i_L0+0, 0 
L__read_RX_FIFO95:
	BTFSS       STATUS+0, 0 
	GOTO        L_read_RX_FIFO4
;Receptor_term2.c,246 :: 		lost_data = read_ZIGBEE_long(address_RX_FIFO + i);        // reading invalid data from RX FIFO
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
;Receptor_term2.c,242 :: 		for(i=0; i<128; i++) {
	INFSNZ      read_RX_FIFO_i_L0+0, 1 
	INCF        read_RX_FIFO_i_L0+1, 1 
;Receptor_term2.c,247 :: 		}
	GOTO        L_read_RX_FIFO0
L_read_RX_FIFO1:
;Receptor_term2.c,249 :: 		DATA_RX[0] = data_RX_FIFO[HEADER_LENGHT + 1];               // coping valid data
	MOVF        _data_RX_FIFO+12, 0 
	MOVWF       _DATA_RX+0 
;Receptor_term2.c,250 :: 		DATA_RX[1] = data_RX_FIFO[HEADER_LENGHT + 2];               // coping valid data
	MOVF        _data_RX_FIFO+13, 0 
	MOVWF       _DATA_RX+1 
;Receptor_term2.c,251 :: 		DATA_RX[2] = data_RX_FIFO[HEADER_LENGHT + 3];               // coping valid data
	MOVF        _data_RX_FIFO+14, 0 
	MOVWF       _DATA_RX+2 
;Receptor_term2.c,252 :: 		DATA_RX[3] = data_RX_FIFO[HEADER_LENGHT + 4];               // coping valid data
	MOVF        _data_RX_FIFO+15, 0 
	MOVWF       _DATA_RX+3 
;Receptor_term2.c,253 :: 		DATA_RX[4] = data_RX_FIFO[HEADER_LENGHT + 5];               // coping valid data
	MOVF        _data_RX_FIFO+16, 0 
	MOVWF       _DATA_RX+4 
;Receptor_term2.c,255 :: 		LQI   = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 2];  // coping valid data
	MOVF        _data_RX_FIFO+19, 0 
	MOVWF       _LQI+0 
;Receptor_term2.c,256 :: 		RSSI2 = data_RX_FIFO[1 + HEADER_LENGHT + DATA_LENGHT + 3];  // coping valid data
	MOVF        _data_RX_FIFO+20, 0 
	MOVWF       _RSSI2+0 
;Receptor_term2.c,258 :: 		temp = read_ZIGBEE_short(BBREG1);      // enable receiving packets off air.
	MOVLW       57
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,259 :: 		temp = temp & (!0x04);                 // mask for enable receiving
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,260 :: 		write_ZIGBEE_short(BBREG1, temp);
	MOVLW       57
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,261 :: 		}
	RETURN      0
; end of _read_RX_FIFO

_set_ACK:
;Receptor_term2.c,266 :: 		void set_ACK(void){
;Receptor_term2.c,269 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,270 :: 		temp = temp | 0x04;                   // 0x04 mask for set ACK
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,271 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,272 :: 		}
	RETURN      0
; end of _set_ACK

_set_not_ACK:
;Receptor_term2.c,274 :: 		void set_not_ACK(void){
;Receptor_term2.c,277 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,278 :: 		temp = temp & (!0x04);                // 0x04 mask for set not ACK
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,279 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,280 :: 		}
	RETURN      0
; end of _set_not_ACK

_set_encrypt:
;Receptor_term2.c,285 :: 		void set_encrypt(void){
;Receptor_term2.c,288 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,289 :: 		temp = temp | 0x02;                   // mask for set encrypt
	MOVLW       2
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,290 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,291 :: 		}
	RETURN      0
; end of _set_encrypt

_set_not_encrypt:
;Receptor_term2.c,293 :: 		void set_not_encrypt(void){
;Receptor_term2.c,296 :: 		temp = read_ZIGBEE_short(TXNCON);
	MOVLW       27
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,297 :: 		temp = temp & (!0x02);                // mask for set not encrypt
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,298 :: 		write_ZIGBEE_short(TXNCON, temp);
	MOVLW       27
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,299 :: 		}
	RETURN      0
; end of _set_not_encrypt

_write_TX_normal_FIFO:
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
;Receptor_term2.c,301 :: 		void write_TX_normal_FIFO() {
;Receptor_term2.c,304 :: 		data_TX_normal_FIFO[0]  = HEADER_LENGHT;
	MOVLW       11
	MOVWF       _data_TX_normal_FIFO+0 
;Receptor_term2.c,305 :: 		data_TX_normal_FIFO[1]  = HEADER_LENGHT + DATA_LENGHT;
	MOVLW       16
	MOVWF       _data_TX_normal_FIFO+1 
;Receptor_term2.c,306 :: 		data_TX_normal_FIFO[2]  = 0x01;                        // control frame
	MOVLW       1
	MOVWF       _data_TX_normal_FIFO+2 
;Receptor_term2.c,307 :: 		data_TX_normal_FIFO[3]  = 0x88;
	MOVLW       136
	MOVWF       _data_TX_normal_FIFO+3 
;Receptor_term2.c,308 :: 		data_TX_normal_FIFO[4]  = SEQ_NUMBER;                  // sequence number
	MOVF        _SEQ_NUMBER+0, 0 
	MOVWF       _data_TX_normal_FIFO+4 
;Receptor_term2.c,309 :: 		data_TX_normal_FIFO[5]  = PAN_ID_2[1];                 // destinatoin pan
	MOVF        _PAN_ID_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+5 
;Receptor_term2.c,310 :: 		data_TX_normal_FIFO[6]  = PAN_ID_2[0];
	MOVF        _PAN_ID_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+6 
;Receptor_term2.c,311 :: 		data_TX_normal_FIFO[7]  = ADDRESS_short_2[0];          // destination address
	MOVF        _ADDRESS_short_2+0, 0 
	MOVWF       _data_TX_normal_FIFO+7 
;Receptor_term2.c,312 :: 		data_TX_normal_FIFO[8]  = ADDRESS_short_2[1];
	MOVF        _ADDRESS_short_2+1, 0 
	MOVWF       _data_TX_normal_FIFO+8 
;Receptor_term2.c,313 :: 		data_TX_normal_FIFO[9]  = PAN_ID_1[0];                 // source pan
	MOVF        _PAN_ID_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+9 
;Receptor_term2.c,314 :: 		data_TX_normal_FIFO[10] = PAN_ID_1[1];
	MOVF        _PAN_ID_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+10 
;Receptor_term2.c,315 :: 		data_TX_normal_FIFO[11] = ADDRESS_short_1[0];          // source address
	MOVF        _ADDRESS_short_1+0, 0 
	MOVWF       _data_TX_normal_FIFO+11 
;Receptor_term2.c,316 :: 		data_TX_normal_FIFO[12] = ADDRESS_short_1[1];
	MOVF        _ADDRESS_short_1+1, 0 
	MOVWF       _data_TX_normal_FIFO+12 
;Receptor_term2.c,318 :: 		data_TX_normal_FIFO[13] = DATA_TX[0];                  // data
	MOVF        _DATA_TX+0, 0 
	MOVWF       _data_TX_normal_FIFO+13 
;Receptor_term2.c,319 :: 		data_TX_normal_FIFO[14] = DATA_TX[1];                  // data
	MOVF        _DATA_TX+1, 0 
	MOVWF       _data_TX_normal_FIFO+14 
;Receptor_term2.c,320 :: 		data_TX_normal_FIFO[15] = DATA_TX[2];                  // data
	MOVF        _DATA_TX+2, 0 
	MOVWF       _data_TX_normal_FIFO+15 
;Receptor_term2.c,321 :: 		data_TX_normal_FIFO[16] = DATA_TX[3];                  // data
	MOVF        _DATA_TX+3, 0 
	MOVWF       _data_TX_normal_FIFO+16 
;Receptor_term2.c,322 :: 		data_TX_normal_FIFO[17] = DATA_TX[4];                  // data
	MOVF        _DATA_TX+4, 0 
	MOVWF       _data_TX_normal_FIFO+17 
;Receptor_term2.c,324 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	CLRF        write_TX_normal_FIFO_i_L0+0 
	CLRF        write_TX_normal_FIFO_i_L0+1 
L_write_TX_normal_FIFO5:
	MOVLW       128
	XORWF       write_TX_normal_FIFO_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__write_TX_normal_FIFO96
	MOVLW       18
	SUBWF       write_TX_normal_FIFO_i_L0+0, 0 
L__write_TX_normal_FIFO96:
	BTFSC       STATUS+0, 0 
	GOTO        L_write_TX_normal_FIFO6
;Receptor_term2.c,325 :: 		write_ZIGBEE_long(address_TX_normal_FIFO + i, data_TX_normal_FIFO[i]); // write frame into normal FIFO
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
;Receptor_term2.c,324 :: 		for(i = 0; i < (HEADER_LENGHT + DATA_LENGHT + 2); i++) {
	INFSNZ      write_TX_normal_FIFO_i_L0+0, 1 
	INCF        write_TX_normal_FIFO_i_L0+1, 1 
;Receptor_term2.c,326 :: 		}
	GOTO        L_write_TX_normal_FIFO5
L_write_TX_normal_FIFO6:
;Receptor_term2.c,328 :: 		set_not_ACK();
	CALL        _set_not_ACK+0, 0
;Receptor_term2.c,329 :: 		set_not_encrypt();
	CALL        _set_not_encrypt+0, 0
;Receptor_term2.c,330 :: 		start_transmit();
	CALL        _start_transmit+0, 0
;Receptor_term2.c,331 :: 		}
	RETURN      0
; end of _write_TX_normal_FIFO

_pin_reset:
;Receptor_term2.c,339 :: 		void pin_reset() {
;Receptor_term2.c,340 :: 		RST = 0;  // activate reset
	BCF         LATC1_bit+0, 1 
;Receptor_term2.c,341 :: 		Delay_ms(5);
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
;Receptor_term2.c,342 :: 		RST = 1;  // deactivate reset
	BSF         LATC1_bit+0, 1 
;Receptor_term2.c,343 :: 		Delay_ms(5);
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
;Receptor_term2.c,344 :: 		}
	RETURN      0
; end of _pin_reset

_PWR_reset:
;Receptor_term2.c,346 :: 		void PWR_reset() {
;Receptor_term2.c,347 :: 		write_ZIGBEE_short(SOFTRST, 0x04);   // 0x04  mask for RSTPWR bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       4
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,348 :: 		}
	RETURN      0
; end of _PWR_reset

_BB_reset:
;Receptor_term2.c,350 :: 		void BB_reset() {
;Receptor_term2.c,351 :: 		write_ZIGBEE_short(SOFTRST, 0x02);   // 0x02 mask for RSTBB bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,352 :: 		}
	RETURN      0
; end of _BB_reset

_MAC_reset:
;Receptor_term2.c,354 :: 		void MAC_reset() {
;Receptor_term2.c,355 :: 		write_ZIGBEE_short(SOFTRST, 0x01);   // 0x01 mask for RSTMAC bit
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,356 :: 		}
	RETURN      0
; end of _MAC_reset

_software_reset:
;Receptor_term2.c,358 :: 		void software_reset() {                // PWR_reset,BB_reset and MAC_reset at once
;Receptor_term2.c,359 :: 		write_ZIGBEE_short(SOFTRST, 0x07);
	MOVLW       42
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,360 :: 		}
	RETURN      0
; end of _software_reset

_RF_reset:
	CLRF        RF_reset_temp_L0+0 
;Receptor_term2.c,362 :: 		void RF_reset() {
;Receptor_term2.c,364 :: 		temp = read_ZIGBEE_short(RFCTL);
	MOVLW       54
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;Receptor_term2.c,365 :: 		temp = temp | 0x04;                  // mask for RFRST bit
	BSF         R0, 2 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;Receptor_term2.c,366 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,367 :: 		temp = temp & (!0x04);               // mask for RFRST bit
	MOVLW       0
	ANDWF       RF_reset_temp_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       RF_reset_temp_L0+0 
;Receptor_term2.c,368 :: 		write_ZIGBEE_short(RFCTL, temp);
	MOVLW       54
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,369 :: 		Delay_ms(1);
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
;Receptor_term2.c,370 :: 		}
	RETURN      0
; end of _RF_reset

_enable_interrupt:
;Receptor_term2.c,375 :: 		void enable_interrupt() {
;Receptor_term2.c,376 :: 		write_ZIGBEE_short(INTCON_M, 0x00);   // 0x00  all interrupts are enable
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CLRF        FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,377 :: 		}
	RETURN      0
; end of _enable_interrupt

_set_channel:
;Receptor_term2.c,382 :: 		void set_channel(short int channel_number) {               // 11-26 possible channels
;Receptor_term2.c,383 :: 		if((channel_number > 26) || (channel_number < 11)) channel_number = 11;
	MOVLW       128
	XORLW       26
	MOVWF       R0 
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel82
	MOVLW       128
	XORWF       FARG_set_channel_channel_number+0, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       11
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_channel82
	GOTO        L_set_channel13
L__set_channel82:
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
L_set_channel13:
;Receptor_term2.c,384 :: 		switch(channel_number) {
	GOTO        L_set_channel14
;Receptor_term2.c,385 :: 		case 11:
L_set_channel16:
;Receptor_term2.c,386 :: 		write_ZIGBEE_long(RFCON0, 0x02);  // 0x02 for 11. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,387 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,388 :: 		case 12:
L_set_channel17:
;Receptor_term2.c,389 :: 		write_ZIGBEE_long(RFCON0, 0x12);  // 0x12 for 12. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       18
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,390 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,391 :: 		case 13:
L_set_channel18:
;Receptor_term2.c,392 :: 		write_ZIGBEE_long(RFCON0, 0x22);  // 0x22 for 13. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,393 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,394 :: 		case 14:
L_set_channel19:
;Receptor_term2.c,395 :: 		write_ZIGBEE_long(RFCON0, 0x32);  // 0x32 for 14. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       50
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,396 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,397 :: 		case 15:
L_set_channel20:
;Receptor_term2.c,398 :: 		write_ZIGBEE_long(RFCON0, 0x42);  // 0x42 for 15. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       66
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,399 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,400 :: 		case 16:
L_set_channel21:
;Receptor_term2.c,401 :: 		write_ZIGBEE_long(RFCON0, 0x52);  // 0x52 for 16. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       82
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,402 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,403 :: 		case 17:
L_set_channel22:
;Receptor_term2.c,404 :: 		write_ZIGBEE_long(RFCON0, 0x62);  // 0x62 for 17. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       98
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,405 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,406 :: 		case 18:
L_set_channel23:
;Receptor_term2.c,407 :: 		write_ZIGBEE_long(RFCON0, 0x72);  // 0x72 for 18. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       114
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,408 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,409 :: 		case 19:
L_set_channel24:
;Receptor_term2.c,410 :: 		write_ZIGBEE_long(RFCON0, 0x82);  // 0x82 for 19. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       130
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,411 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,412 :: 		case 20:
L_set_channel25:
;Receptor_term2.c,413 :: 		write_ZIGBEE_long(RFCON0, 0x92);  // 0x92 for 20. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       146
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,414 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,415 :: 		case 21:
L_set_channel26:
;Receptor_term2.c,416 :: 		write_ZIGBEE_long(RFCON0, 0xA2);  // 0xA2 for 21. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       162
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,417 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,418 :: 		case 22:
L_set_channel27:
;Receptor_term2.c,419 :: 		write_ZIGBEE_long(RFCON0, 0xB2);  // 0xB2 for 22. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       178
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,420 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,421 :: 		case 23:
L_set_channel28:
;Receptor_term2.c,422 :: 		write_ZIGBEE_long(RFCON0, 0xC2);  // 0xC2 for 23. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       194
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,423 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,424 :: 		case 24:
L_set_channel29:
;Receptor_term2.c,425 :: 		write_ZIGBEE_long(RFCON0, 0xD2);  // 0xD2 for 24. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       210
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,426 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,427 :: 		case 25:
L_set_channel30:
;Receptor_term2.c,428 :: 		write_ZIGBEE_long(RFCON0, 0xE2);  // 0xE2 for 25. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       226
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,429 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,430 :: 		case 26:
L_set_channel31:
;Receptor_term2.c,431 :: 		write_ZIGBEE_long(RFCON0, 0xF2);  // 0xF2 for 26. channel
	MOVLW       0
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       242
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,432 :: 		break;
	GOTO        L_set_channel15
;Receptor_term2.c,433 :: 		}
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
;Receptor_term2.c,434 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;Receptor_term2.c,435 :: 		}
	RETURN      0
; end of _set_channel

_set_CCA_mode:
;Receptor_term2.c,440 :: 		void set_CCA_mode(short int CCA_mode) {
;Receptor_term2.c,442 :: 		switch(CCA_mode) {
	GOTO        L_set_CCA_mode32
;Receptor_term2.c,443 :: 		case 1: {                               // ENERGY ABOVE THRESHOLD
L_set_CCA_mode34:
;Receptor_term2.c,444 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,445 :: 		temp = temp | 0x80;                   // 0x80 mask
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,446 :: 		temp = temp & 0xDF;                   // 0xDF mask
	MOVLW       223
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Receptor_term2.c,447 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,448 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,450 :: 		break;
	GOTO        L_set_CCA_mode33
;Receptor_term2.c,452 :: 		case 2: {                               // CARRIER SENSE ONLY
L_set_CCA_mode35:
;Receptor_term2.c,453 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,454 :: 		temp = temp | 0x40;                   // 0x40 mask
	MOVLW       64
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,455 :: 		temp = temp & 0x7F;                   // 0x7F mask
	MOVLW       127
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Receptor_term2.c,456 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,458 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,459 :: 		temp = temp | 0x38;
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,460 :: 		temp = temp & 0xFB;
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Receptor_term2.c,461 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,463 :: 		break;
	GOTO        L_set_CCA_mode33
;Receptor_term2.c,465 :: 		case 3: {                               // CARRIER SENSE AND ENERGY ABOVE THRESHOLD
L_set_CCA_mode36:
;Receptor_term2.c,466 :: 		temp = read_ZIGBEE_short(BBREG2);
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,467 :: 		temp = temp | 0xC0;                   // 0xC0 mask
	MOVLW       192
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,468 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,470 :: 		temp = read_ZIGBEE_short(BBREG2);     // carrier sense threshold
	MOVLW       58
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,471 :: 		temp = temp | 0x38;                   // 0x38 mask
	MOVLW       56
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,472 :: 		temp = temp & 0xFB;                   // 0xFB mask
	MOVLW       251
	ANDWF       FARG_write_ZIGBEE_short_data_r+0, 1 
;Receptor_term2.c,473 :: 		write_ZIGBEE_short(BBREG2, temp);
	MOVLW       58
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,475 :: 		write_ZIGBEE_short(CCAEDTH, 0x60);    // Set CCA ED threshold to -69 dBm
	MOVLW       63
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       96
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,477 :: 		break;
	GOTO        L_set_CCA_mode33
;Receptor_term2.c,478 :: 		}
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
;Receptor_term2.c,479 :: 		}
	RETURN      0
; end of _set_CCA_mode

_set_RSSI_mode:
;Receptor_term2.c,484 :: 		void set_RSSI_mode(short int RSSI_mode) {       // 1 for RSSI1, 2 for RSSI2 mode
;Receptor_term2.c,487 :: 		switch(RSSI_mode) {
	GOTO        L_set_RSSI_mode37
;Receptor_term2.c,488 :: 		case 1: {
L_set_RSSI_mode39:
;Receptor_term2.c,489 :: 		temp = read_ZIGBEE_short(BBREG6);
	MOVLW       62
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,490 :: 		temp = temp | 0x80;                       // 0x80 mask for RSSI1 mode
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,491 :: 		write_ZIGBEE_short(BBREG6, temp);
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,493 :: 		break;
	GOTO        L_set_RSSI_mode38
;Receptor_term2.c,495 :: 		case 2:
L_set_RSSI_mode40:
;Receptor_term2.c,496 :: 		write_ZIGBEE_short(BBREG6, 0x40);         // 0x40 data for RSSI2 mode
	MOVLW       62
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       64
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,497 :: 		break;
	GOTO        L_set_RSSI_mode38
;Receptor_term2.c,498 :: 		}
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
;Receptor_term2.c,499 :: 		}
	RETURN      0
; end of _set_RSSI_mode

_nonbeacon_PAN_coordinator_device:
;Receptor_term2.c,504 :: 		void nonbeacon_PAN_coordinator_device() {
;Receptor_term2.c,507 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,508 :: 		temp = temp | 0x08;                 // 0x08 mask for PAN coordinator
	MOVLW       8
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,509 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,511 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,512 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,513 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,515 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,516 :: 		}
	RETURN      0
; end of _nonbeacon_PAN_coordinator_device

_nonbeacon_coordinator_device:
;Receptor_term2.c,518 :: 		void nonbeacon_coordinator_device() {
;Receptor_term2.c,521 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,522 :: 		temp = temp | 0x04;                 // 0x04 mask for coordinator
	MOVLW       4
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,523 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,525 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,526 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,527 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,529 :: 		write_ZIGBEE_short(ORDER, 0xFF);    // BO, SO  are 15
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       255
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,530 :: 		}
	RETURN      0
; end of _nonbeacon_coordinator_device

_nonbeacon_device:
;Receptor_term2.c,532 :: 		void nonbeacon_device() {
;Receptor_term2.c,535 :: 		temp = read_ZIGBEE_short(RXMCR);
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,536 :: 		temp = temp & 0xF3;                 // 0xF3 mask for PAN coordinator and coordinator
	MOVLW       243
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,537 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,539 :: 		temp = read_ZIGBEE_short(TXMCR);
	MOVLW       17
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,540 :: 		temp = temp & 0xDF;                 // 0xDF mask for CSMA-CA mode
	MOVLW       223
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,541 :: 		write_ZIGBEE_short(TXMCR, temp);
	MOVLW       17
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,542 :: 		}
	RETURN      0
; end of _nonbeacon_device

_set_IFS_recomended:
;Receptor_term2.c,551 :: 		void set_IFS_recomended() {
;Receptor_term2.c,554 :: 		write_ZIGBEE_short(RXMCR, 0x93);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       147
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,556 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,557 :: 		temp = temp | 0x7C;                 // MinLIFSPeriod
	MOVLW       124
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,558 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,560 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,561 :: 		temp = temp | 0x90;                 // MinLIFSPeriod
	MOVLW       144
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,562 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,564 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,565 :: 		temp = temp | 0x31;                 // TurnaroundTime
	MOVLW       49
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,566 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,567 :: 		}
	RETURN      0
; end of _set_IFS_recomended

_set_IFS_default:
;Receptor_term2.c,569 :: 		void set_IFS_default() {
;Receptor_term2.c,572 :: 		write_ZIGBEE_short(RXMCR, 0x75);    // Min SIFS Period
	CLRF        FARG_write_ZIGBEE_short_address+0 
	MOVLW       117
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,574 :: 		temp = read_ZIGBEE_short(TXPEND);
	MOVLW       33
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,575 :: 		temp = temp | 0x84;                 // Min LIFS Period
	MOVLW       132
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,576 :: 		write_ZIGBEE_short(TXPEND, temp);
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,578 :: 		temp = read_ZIGBEE_short(TXSTBL);
	MOVLW       46
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,579 :: 		temp = temp | 0x50;                 // Min LIFS Period
	MOVLW       80
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,580 :: 		write_ZIGBEE_short(TXSTBL, temp);
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,582 :: 		temp = read_ZIGBEE_short(TXTIME);
	MOVLW       39
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,583 :: 		temp = temp | 0x41;                 // Turnaround Time
	MOVLW       65
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,584 :: 		write_ZIGBEE_short(TXTIME, temp);
	MOVLW       39
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,585 :: 		}
	RETURN      0
; end of _set_IFS_default

_set_reception_mode:
;Receptor_term2.c,590 :: 		void set_reception_mode(short int r_mode) { // 1 normal, 2 error, 3 promiscuous mode
;Receptor_term2.c,593 :: 		switch(r_mode) {
	GOTO        L_set_reception_mode41
;Receptor_term2.c,594 :: 		case 1: {
L_set_reception_mode43:
;Receptor_term2.c,595 :: 		temp = read_ZIGBEE_short(RXMCR);      // normal mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,596 :: 		temp = temp & (!0x03);                // mask for normal mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,597 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,599 :: 		break;
	GOTO        L_set_reception_mode42
;Receptor_term2.c,601 :: 		case 2: {
L_set_reception_mode44:
;Receptor_term2.c,602 :: 		temp = read_ZIGBEE_short(RXMCR);      // error mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,603 :: 		temp = temp & (!0x01);                // mask for error mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,604 :: 		temp = temp | 0x02;                   // mask for error mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;Receptor_term2.c,605 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,607 :: 		break;
	GOTO        L_set_reception_mode42
;Receptor_term2.c,609 :: 		case 3: {
L_set_reception_mode45:
;Receptor_term2.c,610 :: 		temp = read_ZIGBEE_short(RXMCR);      // promiscuous mode
	CLRF        FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,611 :: 		temp = temp & (!0x02);                // mask for promiscuous mode
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,612 :: 		temp = temp | 0x01;                   // mask for promiscuous mode
	BSF         FARG_write_ZIGBEE_short_data_r+0, 0 
;Receptor_term2.c,613 :: 		write_ZIGBEE_short(RXMCR, temp);
	CLRF        FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,615 :: 		break;
	GOTO        L_set_reception_mode42
;Receptor_term2.c,616 :: 		}
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
;Receptor_term2.c,617 :: 		}
	RETURN      0
; end of _set_reception_mode

_set_frame_format_filter:
;Receptor_term2.c,622 :: 		void set_frame_format_filter(short int fff_mode) {   // 1 all frames, 2 command only, 3 data only, 4 beacon only
;Receptor_term2.c,625 :: 		switch(fff_mode) {
	GOTO        L_set_frame_format_filter46
;Receptor_term2.c,626 :: 		case 1: {
L_set_frame_format_filter48:
;Receptor_term2.c,627 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // all frames
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,628 :: 		temp = temp & (!0x0E);                  // mask for all frames
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,629 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,631 :: 		break;
	GOTO        L_set_frame_format_filter47
;Receptor_term2.c,633 :: 		case 2: {
L_set_frame_format_filter49:
;Receptor_term2.c,634 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // command only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,635 :: 		temp = temp & (!0x06);                  // mask for command only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,636 :: 		temp = temp | 0x08;                     // mask for command only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 3 
;Receptor_term2.c,637 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,639 :: 		break;
	GOTO        L_set_frame_format_filter47
;Receptor_term2.c,641 :: 		case 3: {
L_set_frame_format_filter50:
;Receptor_term2.c,642 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // data only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,643 :: 		temp = temp & (!0x0A);                  // mask for data only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,644 :: 		temp = temp | 0x04;                     // mask for data only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 2 
;Receptor_term2.c,645 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,647 :: 		break;
	GOTO        L_set_frame_format_filter47
;Receptor_term2.c,649 :: 		case 4: {
L_set_frame_format_filter51:
;Receptor_term2.c,650 :: 		temp = read_ZIGBEE_short(RXFLUSH);      // beacon only
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,651 :: 		temp = temp & (!0x0C);                  // mask for beacon only
	MOVLW       0
	ANDWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,652 :: 		temp = temp | 0x02;                     // mask for beacon only
	BSF         FARG_write_ZIGBEE_short_data_r+0, 1 
;Receptor_term2.c,653 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,655 :: 		break;
	GOTO        L_set_frame_format_filter47
;Receptor_term2.c,656 :: 		}
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
;Receptor_term2.c,657 :: 		}
	RETURN      0
; end of _set_frame_format_filter

_flush_RX_FIFO_pointer:
;Receptor_term2.c,662 :: 		void flush_RX_FIFO_pointer() {
;Receptor_term2.c,665 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,666 :: 		temp = temp | 0x01;                        // mask for flush RX FIFO
	MOVLW       1
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,667 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,668 :: 		}
	RETURN      0
; end of _flush_RX_FIFO_pointer

_set_short_address:
;Receptor_term2.c,673 :: 		void set_short_address(short int * address) {
;Receptor_term2.c,674 :: 		write_ZIGBEE_short(SADRL, address[0]);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_short_address_address+0, FSR0L
	MOVFF       FARG_set_short_address_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,675 :: 		write_ZIGBEE_short(SADRH, address[1]);
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
;Receptor_term2.c,676 :: 		}
	RETURN      0
; end of _set_short_address

_set_long_address:
	CLRF        set_long_address_i_L0+0 
;Receptor_term2.c,678 :: 		void set_long_address(short int * address) {
;Receptor_term2.c,681 :: 		for(i = 0; i < 8; i++) {
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
;Receptor_term2.c,682 :: 		write_ZIGBEE_short(EADR0 + i, address[i]);   // 0x05 address of EADR0
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
;Receptor_term2.c,681 :: 		for(i = 0; i < 8; i++) {
	INCF        set_long_address_i_L0+0, 1 
;Receptor_term2.c,683 :: 		}
	GOTO        L_set_long_address52
L_set_long_address53:
;Receptor_term2.c,684 :: 		}
	RETURN      0
; end of _set_long_address

_set_PAN_ID:
;Receptor_term2.c,686 :: 		void set_PAN_ID(short int * address) {
;Receptor_term2.c,687 :: 		write_ZIGBEE_short(PANIDL, address[0]);
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVFF       FARG_set_PAN_ID_address+0, FSR0L
	MOVFF       FARG_set_PAN_ID_address+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,688 :: 		write_ZIGBEE_short(PANIDH, address[1]);
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
;Receptor_term2.c,689 :: 		}
	RETURN      0
; end of _set_PAN_ID

_set_wake_from_pin:
;Receptor_term2.c,694 :: 		void set_wake_from_pin() {
;Receptor_term2.c,697 :: 		WAKE = 0;
	BCF         LATC2_bit+0, 2 
;Receptor_term2.c,698 :: 		temp = read_ZIGBEE_short(RXFLUSH);
	MOVLW       13
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,699 :: 		temp = temp | 0x60;                     // mask
	MOVLW       96
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,700 :: 		write_ZIGBEE_short(RXFLUSH, temp);
	MOVLW       13
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,702 :: 		temp = read_ZIGBEE_short(WAKECON);
	MOVLW       34
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
;Receptor_term2.c,703 :: 		temp = temp | 0x80;
	MOVLW       128
	IORWF       R0, 0 
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
;Receptor_term2.c,704 :: 		write_ZIGBEE_short(WAKECON, temp);
	MOVLW       34
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,705 :: 		}
	RETURN      0
; end of _set_wake_from_pin

_pin_wake:
;Receptor_term2.c,707 :: 		void pin_wake() {
;Receptor_term2.c,708 :: 		WAKE = 1;
	BSF         LATC2_bit+0, 2 
;Receptor_term2.c,709 :: 		Delay_ms(5);
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
;Receptor_term2.c,710 :: 		}
	RETURN      0
; end of _pin_wake

_enable_PLL:
;Receptor_term2.c,715 :: 		void enable_PLL() {
;Receptor_term2.c,716 :: 		write_ZIGBEE_long(RFCON2, 0x80);       // mask for PLL enable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,717 :: 		}
	RETURN      0
; end of _enable_PLL

_disable_PLL:
;Receptor_term2.c,719 :: 		void disable_PLL() {
;Receptor_term2.c,720 :: 		write_ZIGBEE_long(RFCON2, 0x00);       // mask for PLL disable
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	CLRF        FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,721 :: 		}
	RETURN      0
; end of _disable_PLL

_set_TX_power:
;Receptor_term2.c,726 :: 		void set_TX_power(unsigned short int power) {             // 0-31 possible variants
;Receptor_term2.c,727 :: 		if((power < 0) || (power > 31))
	MOVLW       0
	SUBWF       FARG_set_TX_power_power+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power83
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	BTFSS       STATUS+0, 0 
	GOTO        L__set_TX_power83
	GOTO        L_set_TX_power58
L__set_TX_power83:
;Receptor_term2.c,728 :: 		power = 31;
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
L_set_TX_power58:
;Receptor_term2.c,729 :: 		power = 31 - power;                                     // 0 max, 31 min -> 31 max, 0 min
	MOVF        FARG_set_TX_power_power+0, 0 
	SUBLW       31
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       FARG_set_TX_power_power+0 
;Receptor_term2.c,730 :: 		power = ((power & 0b00011111) << 3) & 0b11111000;       // calculating power
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
;Receptor_term2.c,731 :: 		write_ZIGBEE_long(RFCON3, power);
	MOVLW       3
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVF        R0, 0 
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,732 :: 		}
	RETURN      0
; end of _set_TX_power

_init_ZIGBEE_basic:
;Receptor_term2.c,737 :: 		void init_ZIGBEE_basic() {
;Receptor_term2.c,738 :: 		write_ZIGBEE_short(PACON2, 0x98);   // Initialize FIFOEN = 1 and TXONTS = 0x6
	MOVLW       24
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       152
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,739 :: 		write_ZIGBEE_short(TXSTBL, 0x95);   // Initialize RFSTBL = 0x9
	MOVLW       46
	MOVWF       FARG_write_ZIGBEE_short_address+0 
	MOVLW       149
	MOVWF       FARG_write_ZIGBEE_short_data_r+0 
	CALL        _write_ZIGBEE_short+0, 0
;Receptor_term2.c,740 :: 		write_ZIGBEE_long(RFCON1, 0x01);    // Initialize VCOOPT = 0x01
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       1
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,741 :: 		enable_PLL();                       // Enable PLL (PLLEN = 1)
	CALL        _enable_PLL+0, 0
;Receptor_term2.c,742 :: 		write_ZIGBEE_long(RFCON6, 0x90);    // Initialize TXFIL = 1 and 20MRECVR = 1
	MOVLW       6
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       144
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,743 :: 		write_ZIGBEE_long(RFCON7, 0x80);    // Initialize SLPCLKSEL = 0x2 (100 kHz Internal oscillator)
	MOVLW       7
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       128
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,744 :: 		write_ZIGBEE_long(RFCON8, 0x10);    // Initialize RFVCO = 1
	MOVLW       8
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       16
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,745 :: 		write_ZIGBEE_long(SLPCON1, 0x21);   // Initialize CLKOUTEN = 1 and SLPCLKDIV = 0x01
	MOVLW       32
	MOVWF       FARG_write_ZIGBEE_long_address+0 
	MOVLW       2
	MOVWF       FARG_write_ZIGBEE_long_address+1 
	MOVLW       33
	MOVWF       FARG_write_ZIGBEE_long_data_r+0 
	CALL        _write_ZIGBEE_long+0, 0
;Receptor_term2.c,746 :: 		}
	RETURN      0
; end of _init_ZIGBEE_basic

_init_ZIGBEE_nonbeacon:
;Receptor_term2.c,748 :: 		void init_ZIGBEE_nonbeacon() {
;Receptor_term2.c,749 :: 		init_ZIGBEE_basic();
	CALL        _init_ZIGBEE_basic+0, 0
;Receptor_term2.c,750 :: 		set_CCA_mode(1);     // Set CCA mode to ED and set threshold
	MOVLW       1
	MOVWF       FARG_set_CCA_mode_CCA_mode+0 
	CALL        _set_CCA_mode+0, 0
;Receptor_term2.c,751 :: 		set_RSSI_mode(2);    // RSSI2 mode
	MOVLW       2
	MOVWF       FARG_set_RSSI_mode_RSSI_mode+0 
	CALL        _set_RSSI_mode+0, 0
;Receptor_term2.c,752 :: 		enable_interrupt();  // Enables all interrupts
	CALL        _enable_interrupt+0, 0
;Receptor_term2.c,753 :: 		set_channel(11);     // Channel 11
	MOVLW       11
	MOVWF       FARG_set_channel_channel_number+0 
	CALL        _set_channel+0, 0
;Receptor_term2.c,754 :: 		RF_reset();
	CALL        _RF_reset+0, 0
;Receptor_term2.c,755 :: 		}
	RETURN      0
; end of _init_ZIGBEE_nonbeacon

_Debounce_INT:
	CLRF        Debounce_INT_intn_d_L0+0 
	CLRF        Debounce_INT_j_L0+0 
	CLRF        Debounce_INT_i_L0+0 
;Receptor_term2.c,757 :: 		char Debounce_INT() {
;Receptor_term2.c,759 :: 		for(i = 0; i < 5; i++) {
	CLRF        Debounce_INT_i_L0+0 
L_Debounce_INT59:
	MOVLW       5
	SUBWF       Debounce_INT_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT60
;Receptor_term2.c,760 :: 		intn_d = INT;
	MOVLW       0
	BTFSC       RC6_bit+0, 6 
	MOVLW       1
	MOVWF       Debounce_INT_intn_d_L0+0 
;Receptor_term2.c,761 :: 		if (intn_d == 1)
	MOVF        Debounce_INT_intn_d_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Debounce_INT62
;Receptor_term2.c,762 :: 		j++;
	INCF        Debounce_INT_j_L0+0, 1 
L_Debounce_INT62:
;Receptor_term2.c,759 :: 		for(i = 0; i < 5; i++) {
	INCF        Debounce_INT_i_L0+0, 1 
;Receptor_term2.c,763 :: 		}
	GOTO        L_Debounce_INT59
L_Debounce_INT60:
;Receptor_term2.c,764 :: 		if (j > 2)
	MOVF        Debounce_INT_j_L0+0, 0 
	SUBLW       2
	BTFSC       STATUS+0, 0 
	GOTO        L_Debounce_INT63
;Receptor_term2.c,765 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_Debounce_INT63:
;Receptor_term2.c,767 :: 		return 0;
	CLRF        R0 
;Receptor_term2.c,768 :: 		}
	RETURN      0
; end of _Debounce_INT

_Initialize:
	CLRF        Initialize_i_L0+0 
;Receptor_term2.c,770 :: 		void Initialize() {
;Receptor_term2.c,773 :: 		LQI = 0;
	CLRF        _LQI+0 
;Receptor_term2.c,774 :: 		RSSI2 = 0;
	CLRF        _RSSI2+0 
;Receptor_term2.c,775 :: 		SEQ_NUMBER = 0x23;
	MOVLW       35
	MOVWF       _SEQ_NUMBER+0 
;Receptor_term2.c,776 :: 		lost_data = 0;
	CLRF        _lost_data+0 
;Receptor_term2.c,777 :: 		address_RX_FIFO = 0x300;
	MOVLW       0
	MOVWF       _address_RX_FIFO+0 
	MOVLW       3
	MOVWF       _address_RX_FIFO+1 
;Receptor_term2.c,778 :: 		address_TX_normal_FIFO = 0;
	CLRF        _address_TX_normal_FIFO+0 
	CLRF        _address_TX_normal_FIFO+1 
;Receptor_term2.c,780 :: 		for (i = 0; i < 2; i++) {
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
;Receptor_term2.c,781 :: 		ADDRESS_short_1[i] = 1;
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
;Receptor_term2.c,782 :: 		ADDRESS_short_2[i] = 2;
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
;Receptor_term2.c,783 :: 		PAN_ID_1[i] = 3;
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
;Receptor_term2.c,784 :: 		PAN_ID_2[i] = 3;
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
;Receptor_term2.c,780 :: 		for (i = 0; i < 2; i++) {
	INCF        Initialize_i_L0+0, 1 
;Receptor_term2.c,785 :: 		}
	GOTO        L_Initialize65
L_Initialize66:
;Receptor_term2.c,787 :: 		for (i = 0; i < 8; i++) {
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
;Receptor_term2.c,788 :: 		ADDRESS_long_1[i] = 1;
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
;Receptor_term2.c,789 :: 		ADDRESS_long_2[i] = 2;
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
;Receptor_term2.c,787 :: 		for (i = 0; i < 8; i++) {
	INCF        Initialize_i_L0+0, 1 
;Receptor_term2.c,790 :: 		}
	GOTO        L_Initialize68
L_Initialize69:
;Receptor_term2.c,793 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV4, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_LOW_2_HIGH);
	CLRF        FARG_SPI1_Init_Advanced_master+0 
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;Receptor_term2.c,794 :: 		pin_reset();                              // Activate reset from pin
	CALL        _pin_reset+0, 0
;Receptor_term2.c,795 :: 		software_reset();                         // Activate software reset
	CALL        _software_reset+0, 0
;Receptor_term2.c,796 :: 		RF_reset();                               // RF reset
	CALL        _RF_reset+0, 0
;Receptor_term2.c,797 :: 		set_WAKE_from_pin();                      // Set wake from pin
	CALL        _set_wake_from_pin+0, 0
;Receptor_term2.c,799 :: 		set_long_address(ADDRESS_long_2);         // Set long address
	MOVLW       _ADDRESS_long_2+0
	MOVWF       FARG_set_long_address_address+0 
	MOVLW       hi_addr(_ADDRESS_long_2+0
	MOVWF       FARG_set_long_address_address+1 
	CALL        _set_long_address+0, 0
;Receptor_term2.c,800 :: 		set_short_address(ADDRESS_short_2);       // Set short address
	MOVLW       _ADDRESS_short_2+0
	MOVWF       FARG_set_short_address_address+0 
	MOVLW       hi_addr(_ADDRESS_short_2+0
	MOVWF       FARG_set_short_address_address+1 
	CALL        _set_short_address+0, 0
;Receptor_term2.c,801 :: 		set_PAN_ID(PAN_ID_2);                     // Set PAN_ID
	MOVLW       _PAN_ID_2+0
	MOVWF       FARG_set_PAN_ID_address+0 
	MOVLW       hi_addr(_PAN_ID_2+0
	MOVWF       FARG_set_PAN_ID_address+1 
	CALL        _set_PAN_ID+0, 0
;Receptor_term2.c,803 :: 		init_ZIGBEE_nonbeacon();                  // Initialize ZigBee module
	CALL        _init_ZIGBEE_nonbeacon+0, 0
;Receptor_term2.c,804 :: 		nonbeacon_PAN_coordinator_device();
	CALL        _nonbeacon_PAN_coordinator_device+0, 0
;Receptor_term2.c,805 :: 		set_TX_power(31);                         // Set max TX power
	MOVLW       31
	MOVWF       FARG_set_TX_power_power+0 
	CALL        _set_TX_power+0, 0
;Receptor_term2.c,806 :: 		set_frame_format_filter(1);               // 1 all frames, 3 data frame only
	MOVLW       1
	MOVWF       FARG_set_frame_format_filter_fff_mode+0 
	CALL        _set_frame_format_filter+0, 0
;Receptor_term2.c,807 :: 		set_reception_mode(1);                    // 1 normal mode
	MOVLW       1
	MOVWF       FARG_set_reception_mode_r_mode+0 
	CALL        _set_reception_mode+0, 0
;Receptor_term2.c,809 :: 		pin_wake();                               // Wake from pin
	CALL        _pin_wake+0, 0
;Receptor_term2.c,810 :: 		}
	RETURN      0
; end of _Initialize

_main:
	CLRF        main_battery_L0+0 
	CLRF        main_degrees_L0+0 
	CLRF        main_dig3_L0+0 
	CLRF        main_dig2_L0+0 
;Receptor_term2.c,814 :: 		void main() {
;Receptor_term2.c,818 :: 		Initialize();                      // Initialize MCU and Bee click board
	CALL        _Initialize+0, 0
;Receptor_term2.c,820 :: 		while(1){
L_main71:
;Receptor_term2.c,821 :: 		if(Debounce_INT() == 0 ){
	CALL        _Debounce_INT+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_main73
;Receptor_term2.c,822 :: 		temp1 = read_ZIGBEE_short(INTSTAT); // Read and flush register INTSTAT
	MOVLW       49
	MOVWF       FARG_read_ZIGBEE_short_address+0 
	CALL        _read_ZIGBEE_short+0, 0
	MOVF        R0, 0 
	MOVWF       _temp1+0 
;Receptor_term2.c,823 :: 		read_RX_FIFO();                     // Read receive data
	CALL        _read_RX_FIFO+0, 0
;Receptor_term2.c,825 :: 		dig2=DATA_RX[1];
	MOVF        _DATA_RX+1, 0 
	MOVWF       main_dig2_L0+0 
;Receptor_term2.c,826 :: 		dig3=DATA_RX[2];
	MOVF        _DATA_RX+2, 0 
	MOVWF       main_dig3_L0+0 
;Receptor_term2.c,827 :: 		degrees=DATA_RX[3];
	MOVF        _DATA_RX+3, 0 
	MOVWF       main_degrees_L0+0 
;Receptor_term2.c,828 :: 		battery=DATA_RX[4];
	MOVF        _DATA_RX+4, 0 
	MOVWF       main_battery_L0+0 
;Receptor_term2.c,830 :: 		Lcd_Chr(1, 1, dig1);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _DATA_RX+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,831 :: 		Lcd_Chr(1, 2, dig2);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        main_dig2_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,832 :: 		if ((dig3 == 'i')||(dig3 == 'o')){
	MOVF        main_dig3_L0+0, 0 
	XORLW       105
	BTFSC       STATUS+0, 2 
	GOTO        L__main84
	MOVF        main_dig3_L0+0, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L__main84
	GOTO        L_main76
L__main84:
;Receptor_term2.c,833 :: 		Lcd_Chr(1, 3, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        main_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,834 :: 		Lcd_Chr(1, 4, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,835 :: 		}else{
	GOTO        L_main77
L_main76:
;Receptor_term2.c,836 :: 		Lcd_Chr(1, 3, '.');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,837 :: 		Lcd_Chr(1, 4, dig3);
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        main_dig3_L0+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,838 :: 		}
L_main77:
;Receptor_term2.c,840 :: 		if (battery == 'b'){
	MOVF        main_battery_L0+0, 0 
	XORLW       98
	BTFSS       STATUS+0, 2 
	GOTO        L_main78
;Receptor_term2.c,841 :: 		Lcd_Out(2, 0, "           ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_Receptor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_Receptor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Receptor_term2.c,842 :: 		}
	GOTO        L_main79
L_main78:
;Receptor_term2.c,844 :: 		Lcd_Out(2, 0, "low battery");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_Receptor_term2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_Receptor_term2+0
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;Receptor_term2.c,845 :: 		}
L_main79:
;Receptor_term2.c,847 :: 		if (degrees == 'C'){
	MOVF        main_degrees_L0+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main80
;Receptor_term2.c,848 :: 		Lcd_Chr(1, 5, 'C');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       67
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,849 :: 		}
	GOTO        L_main81
L_main80:
;Receptor_term2.c,851 :: 		Lcd_Chr(1, 5, ' ');
	MOVLW       1
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       5
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       32
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;Receptor_term2.c,852 :: 		}
L_main81:
;Receptor_term2.c,853 :: 		}
L_main73:
;Receptor_term2.c,854 :: 		}
	GOTO        L_main71
;Receptor_term2.c,856 :: 		}
	GOTO        $+0
; end of _main
