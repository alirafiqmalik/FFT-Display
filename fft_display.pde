/**
 * Simple Read
 *
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port

void setup()
{
  size(1366, 720);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  background(255);             // Set background to white
}

void draw()
{

  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
    if (val != null)
    {
      if (val.equals("done\n") == true)
      {
        background(255);             // Set background to white
        textSize(18);
        for (int i = 0; i <= 1000; i += 50)
          text(str(int(i)), 10+1.2*i, height-100);
        for (float i = 0; i <= 600; i += 10)
          text(str(i), width-100, height-120-10*i);
        textSize(24);
        text("Frequency(Hz)", width/2-50, height-50);
        push();
        translate(width-20, height/2-50);
        rotate(radians(-90));
        // Draw the letter to the screen
        text("Magnitude", 0, 0);
        pop();
      } else if (val.indexOf(",") != -1)
      {
        String[] values = split(val, ',');
        print("Freq:"+values[0]+","+" Mag: "+values[1]);
        strokeWeight(4);  // Default
        line(10+1.2*float(values[0]), height-120, 10+ 1.2*float(values[0]), height-120-10*float(values[1]));
        fill(0);
      }
    }
  }
}
