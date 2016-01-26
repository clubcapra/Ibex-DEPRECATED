
#include <SPI.h>

const int BAUD_RATE = 9600;

const int BUTTON_1 = 6;
const int ENCODER_PIN_5V = 13;

const int SPI_PIN_CSB = 10;
const int SPI_PIN_MOSI = 11;
const int SPI_PIN_MISO = 12;
const int SPI_PIN_SCK = 13;

const int SPI_CMD_NO_OP = 0x00;
const int SPI_CMD_READ_POS = 0x10;
const int SPI_CMD_SET_ZERO = 0x70;

int button_state = 0;

void setup() {
	Serial.begin(BAUD_RATE);
	SPI.begin();

        Serial.println("Capra 7 swivel boot up");
        Serial.println("Capra 7 OS boot up complete");

	pinMode(SPI_PIN_CSB, OUTPUT);
	pinMode(ENCODER_PIN_5V, OUTPUT);
	digitalWrite(ENCODER_PIN_5V, HIGH);
	delay(1000);

	Serial.println("Encoder ready");
}

void loop() {

	
 
	Serial.println(readEncoderPos(), DEC);

        button_state = digitalRead(BUTTON_1);
        
        if(button_state == HIGH){
        
          setEncoderZero();
          
        }
}


 /*

First the host will issue a command, then the encoder may respond with wait responses (0xA5) until ready.

Once ready the encoder will echo the original command received from the master, followed by the requested data.

It is recommended that the master leave a 20 μs delay between reads to avoid extending the read time by forcing wait sequences.

 */

void setEncoderZero() {

	// Send set_zero_point command
	SPI.transfer(SPI_CMD_SET_ZERO);
	Serial.println("set_zero_point command sent");

	// Send nop_a5 command while response is not 0x80
	unsigned int result = 0x00;
	while (result != 0x80) {
		delay(20);
		result = SPI.transfer(SPI_CMD_NO_OP);
		Serial.println("nop_a5 command sent");
		Serial.print("\tresult is ");
		Serial.println(result);
	}

	// A response of 0x80 means that the zero set was
	//   successful and the new position offset is stored in EEPROM.
	Serial.println("zero set was successful. new position offset is stored.");

	// The encoder must be power cycled. If the encoder is not power cycled,
	//   the position values will not be calculated off the latest zero position.
	//   When the encoder is powered on next the new offset will be used for the
	//   position calculation.
	digitalWrite(ENCODER_PIN_5V, LOW);
	delay(500);
	digitalWrite(ENCODER_PIN_5V, HIGH);
}


float readEncoderPos() {
	unsigned int result = 0x0000, MSB_pos = 0x0000, LSB_pos = 0x0000;
	byte read_error_count = 0;

	result = _sendSPIReadPosCMD();

	while (result == 0xA5) {
		result = _sendSPINoOpCMD();
		read_error_count++;

		if (read_error_count > 50) {
			read_error_count = 0;
			result = _sendSPIReadPosCMD();
		}
	}

	if (result == SPI_CMD_READ_POS) {
		MSB_pos = _sendSPINoOpCMD();
		LSB_pos = _sendSPINoOpCMD();
	}

	float deg = 360.0 * (0x0FFF & (MSB_pos << 8 | LSB_pos)) / 4096.0;

	return floor(deg * 100.0) / 100.0;
}

byte _sendSPINoOpCMD() {
	byte result = 0xFF;

	digitalWrite(SPI_PIN_CSB, LOW);
	delay(2);

	result = SPI.transfer(SPI_CMD_NO_OP);

	digitalWrite(SPI_PIN_CSB, HIGH);
	delay(2);

	return result;
}

byte _sendSPIReadPosCMD() {
	byte result = 0xFF;

	digitalWrite(SPI_PIN_CSB, LOW);
	delay(2);

	result = SPI.transfer(SPI_CMD_READ_POS);

	digitalWrite(SPI_PIN_CSB, HIGH);
	delay(2);

	return result;
}

byte _sendSPISetZero() {
	byte result = 0xFF;

	digitalWrite(SPI_PIN_CSB, LOW);
	delay(2);

	result = SPI.transfer(SPI_CMD_SET_ZERO);

	digitalWrite(SPI_PIN_CSB, HIGH);
	delay(2);

	return result;
}

