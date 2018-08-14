
#include <SoftwareSerial.h>

SoftwareSerial USerial (2, 3); // RX, TX

void setup()  
{
  Serial.begin(9600);
  USerial.begin(9600);
  
}

void loop()                     // run over and over again
{
 if (USerial.available())
  {
      
      Serial.println(USerial.read()); 
   
  }
 
}
