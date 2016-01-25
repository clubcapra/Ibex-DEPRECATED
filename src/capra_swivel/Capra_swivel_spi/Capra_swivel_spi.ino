/*
  SPI_PIN_SS = 10
  SPI_PIN_MOSI = 11
  SPI_PIN_MISO = 12
  SPI_PIN_SCK = 13      
  
  ENCODER = 4        
  */
#include <SPI.h>
#include <Stepper.h>

const int BAUD_RATE = 9600;

const int STEPPER_NB_STEPS_PER_REVOLUTION = 4096;

const int SPI_PIN_SS = 10;
const int SPI_PIN_MOSI = 11;
const int SPI_PIN_MISO = 12;
const int SPI_PIN_SCK = 13;

const int ENCODER_PIN_5V = 4;

const int SPI_CMD_NO_OP = 0x00;
const int SPI_CMD_READ_POS = 0x10;
const int SPI_CMD_SET_ZERO = 0x70;
const int SPI_CMD_WAIT = 0x80;

void setup() {
  Serial.begin(BAUD_RATE);
  SPI.begin();
  
  pinMode(SPI_PIN_SS, OUTPUT);
  
  pinMode(ENCODER_PIN_5V, OUTPUT);
  
  digitalWrite(ENCODER_PIN_5V, HIGH);
  
  set_encoder_zero();
  
  delay(1000);
 
 Serial.println("Testing encoder"); 
}  

void loop(){
 
}

void set_encoder_zero(){
 
 SPI.transfer(SPI_CMD_SET_ZERO);
 Serial.println("Set zero point");
 
 unsigned int result = 0x00;

 while(result != 0x80){
   delay(20);
   result = SPI.transfer(SPI_CMD_NO_OP);
   Serial.println("NOP send");
   Serial.println(result);
 }
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
     
     if (read_error_count > 50){
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

byte _sendSPINoOpCMD(){
  byte result = 0xFF;
  
  digitalWrite(SPI_PIN_SS, LOW);
  delay(2);
  
  result = SPI.transfer(SPI_CMD_NO_OP);
  
  digitalWrite(SPI_PIN_SS, HIGH);
  delay(2);
  
  return result;
}

byte _sendSPIReadPosCMD(){
  byte result = 0xFF;
  
  digitalWrite(SPI_PIN_SS,LOW);
  delay(2);
  
  result = SPI.transfer(SPI_CMD_NO_OP);
  
  digitalWrite(SPI_PIN_SS, HIGH);
  delay(2);
  
  return result;
}

byte _sendSPISetZero() {
  byte result = 0xFF;
  
  digitalWrite(SPI_PIN_SS, LOW);
  delay(2);
  
  result = SPI.transfer(SPI_CMD_SET_ZERO);
 
  digitalWrite(SPI_PIN_SS, HIGH);
  delay(2); 
  
  return result;
}
