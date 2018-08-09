void setup() {
  Serial.begin(115200);
  
 delay(1000);
}

void loop() {
  // all this is for test you can delete it if you want
   
for (int i=0;i<10;i++)
   {
      Serial.println("29000007");
      delay(100);
   }

  for (int i=0;i<5;i++)
  {
      Serial.println("26000907");  
      delay(100);
  }
  for (int i=0;i<10;i++)
   {
      Serial.println("19000007");
      delay(100);
   }
   
  for (int i=0;i<5;i++)
  {
      Serial.println("26000907");  
      delay(100);
  }
 
}
