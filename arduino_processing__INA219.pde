import processing.serial.*;

Serial myPort; // Serial Port

void setup(){
  size(600,600);
  frameRate(200);
  println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[0], 115200);
  myPort.bufferUntil('\n');
}

void draw(){
  String inString = myPort.readStringUntil('\n');
  if(inString != null){
    background(0);
    float[] value = float(split(inString,','));
    textSize(20);
    text("Bus Voltage:", 20, 100);
    text(value[0], 200, 100);
    text("Shunt Voltage:", 20, 200);
    text(value[1], 200, 200);
    text("Load Voltage:", 20, 300);
    text(value[2], 200, 300);
    text("Current:", 20, 400);
    text(value[3], 200, 400);
    text("Power:", 20, 500);
    text(value[4], 200, 500);
  }
}
