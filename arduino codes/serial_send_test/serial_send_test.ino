/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.

  This example code is in the public domain.
 */

// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
// the setup routine runs once when you press reset:
void setup() {
  // initialize the digital pin as an output.
    Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
  Serial.println("0300000300");
  delay(50);
    Serial.println("0900000300");
  delay(2000);
  
   Serial.println("0900000101");
  delay(2000);
    Serial.println("0300000101");
  delay(2000); 
    Serial.println("0000000051");
  delay(2000); 
    Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
      Serial.println("0000000011");
  delay(20); 
  }
