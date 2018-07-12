/*
  Blink
  Turns on an LED on for one second, then off for one second, repeatedly.

  This example code is in the public domain.
 */

// Pin 13 has an LED connected on most Arduino boards.
// give it a name:
int led = 13;

// the setup routine runs once when you press reset:
void setup() {
  // initialize the digital pin as an output.
    Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
  Serial.println("0000000100");
  delay(1000);
  Serial.println("0000000100");
  delay(1000);
  Serial.println("0000000100");
  delay(1000);
  Serial.println("0000000100");
  delay(1000);
  Serial.println("0000000100");
  delay(1000);
  Serial.println("0000000100");
  delay(10000);

}
