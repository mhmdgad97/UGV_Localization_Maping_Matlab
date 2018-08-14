#include <SoftwareSerial.h>
SoftwareSerial mySerial(2,3);//Rx,Tx
String input;
long int mapdata;

void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
mySerial.begin(15000);
}

void loop() {
  // put your main code here, to run repeatedly:

  Serial.setTimeout(31);
if (Serial.available()>0)
{
  input=Serial.readString();
  mapdata=input.toInt();
  Serial.println(mapdata);
} 
}
