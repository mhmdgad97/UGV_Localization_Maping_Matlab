// in this code the robot should first go for 10 meters then turn right and then go for another 10 and so
// like make him rotate clock wise and return to origin

int counter=0;//used to terminate whlie loops
int angle=0;

void goahead()
{
  while (counter>=1000)//goes 10 metres ahead 
  {
  Serial.println("0000000100");
  counter+=10;
  }
}

void turnright()
{
  while (angle>=90)//make right angle to right 
  {
  Serial.println("0010000000");
  angle+=1;
  }
}


void setup()
{
 Serial.begin(9600);

}

void loop() 
{
goahead();
delay(1000);
turnright();
delay (1000);

}
