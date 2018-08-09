 
#include <SoftwareSerial.h>

SoftwareSerial mySerial(2,3);
void setup() {
mySerial.begin(9600);
Serial.begin(115200);

}

void loop() 
{
  if (mySerial.available()) 
  Serial.println(mySerial.parseInt());
}
