
void setup() {
    Serial.begin(9600);
}
int i=i;
void loop() 
{
  
 //go straight
  for(int i=0;i<5;i++)
  {
      Serial.println("0000001008");
      delay(750);
  }  
      
  for(int i=0;i<5;i++)
  {
      Serial.println("1200001008");
      delay(750);
  }  
      
  for(int i=0;i<5;i++)
  {
      Serial.println("1800001008");
      delay(750);
  }  
  
  for(int i=0;i<5;i++)
  {
      Serial.println("0200001008");
      delay(750);
  }  
 
}
