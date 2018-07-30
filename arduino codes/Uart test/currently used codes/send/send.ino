void setup() {
  Serial.begin(9600);
delay (5000);
}

void loop() {
  // all this is for test you can delete it if you want
   for (int i=0;i<5;i++)
   {
      Serial.println("20500001");
      delay(500);
   }

  for (int i=0;i<5;i++)
  {
      Serial.println("20500901");  
      delay(500);
  }
  
  for (int i=0;i<5;i++)
  {
      Serial.println("20501801");  
      delay(500);
  }
  
  for (int i=0;i<5;i++)
  {
      Serial.println("20502701");  
      delay(500);
  }
}
