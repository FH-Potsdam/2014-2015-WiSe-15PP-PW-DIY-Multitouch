// Knock LED
// written by fabianmoronzirfas
// knock the table blink a led
// based on this http://arduino.cc/en/Tutorial/Knock

//Connect the piezo + to pin A0
//Connect the piezo - to GND 
//Connect parallel a 1kOHM resistor to pin A0
//Connect parallel the same 1kOHM resistor to GND

int sensorValue = 0; // here we store the current value from the pin
int ledpin = 13; // build in LED
int piezopin = A0; // the analog input pin
int threshold = 10; // the knock threshold

// setup executed once
void setup(){

  pinMode(ledpin, OUTPUT); // set the pin 13 as output
  digitalWrite(ledpin, LOW); // turn it off
  Serial.begin(9600); // this is for seeing what values come in
}

// loop executed all the time
void loop(){

  sensorValue = analogRead(piezopin);// read the pieso
  Serial.println(sensorValue); // write the result to the serial monitor
  // we check if the value is higher than our threshold
  // if so we turn on the LED
  if(sensorValue >= threshold){
    // yay it is higher
    digitalWrite(ledpin,HIGH);
  }
  else{
    // ney. Knock harder
    digitalWrite(ledpin,LOW);
  }
}

