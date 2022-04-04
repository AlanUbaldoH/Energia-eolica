import controlP5.*;
import processing.serial.*;

ControlP5 cp5; 
ControlFont font;
Serial myPort;

float posDeseada, posReal;
int indiceSlider = 0;

Slider agregaSlider(String nombre, float min, float max, float inicial) {
  Slider slider;
  slider = cp5.addSlider(nombre).setRange(min, max).setSize(180, 25);
  slider.setPosition(30, 100 + 40 * indiceSlider);
  slider.getCaptionLabel().setFont(font);  // cambiar fuente de la etiqueta
  slider.getCaptionLabel().setColor(0); //
  slider.getValueLabel().setFont(font);    // cambiar fuente del valor mostrado
  slider.setValue(inicial);
  slider.setColorValue(color(255));
  slider.setColorActive(color(153, 51, 0)); 
  slider.setColorForeground(color(255, 153, 0));
  slider.setColorBackground(color(0));
  indiceSlider++;
  return slider;
}

void settings(){
  size(550,300);
}

void setup(){
  PFont pfont = createFont("Verdana", 12);
  font = new ControlFont(pfont, 12);
  cp5 = new ControlP5(this);
  agregaSlider("Posición deseada", 0, 90, 45);  //Inicio,final,Valor por default
  agregaSlider("Posición real", 0, 90, 45);
  

  println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
}

void draw(){
  background(255);
  
  noStroke();
  fill(255, 153, 0);
  rect(45, 200, 100, 50);
  
  // Títulos
  textSize(14);
  fill(0);
  text(" RPM ", 155, 230);
  float dato=cp5.getController("Posición deseada").getValue();
  println(dato);
  
  //RPM
  String inString = myPort.readStringUntil('\n');
  if(inString != null){
    fill(255);
    text(inString, 70, 230);
  }
}
