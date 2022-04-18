import controlP5.*;
import processing.serial.*;

ControlP5 cp5; 
ControlFont font;
Serial myPort;

float posDeseada, posReal;
int indiceSlider = 0;
int indiceKnob = 0;
int indiceButton = 0;

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

Knob agregaKnob(String nombre, float min, float max, float inicial, float radio){
  Knob knob;
  knob = cp5.addKnob(nombre).setRadius(radio).setRange(min,max).setValue(inicial);
  knob.setPosition(100 + 250 * indiceKnob, 450);
  knob.getCaptionLabel().setFont(font);  // cambiar fuente de la etiqueta
  knob.getCaptionLabel().setColor(0); //
  knob.getValueLabel().setFont(font);
  knob.setColorValue(color(255));
  knob.setColorActive(color(127, 255, 212));
  knob.setColorForeground(color(175, 238, 238));
  knob.setColorBackground(color(0));
  indiceKnob++;
  return knob;  
}

Button agregaButton(String nombre){
  Button button;
  button = cp5.addButton(nombre).setPosition(550 + 250 * indiceButton, 480).setSize(200, 50);
  button.getCaptionLabel().setFont(font);  // cambiar fuente de la etiqueta
  button.getCaptionLabel().setColor(255); //
  button.getValueLabel().setFont(font);
  button.setColorValue(color(255));
  button.setColorForeground(color(114, 158, 161));
  button.setColorBackground(color(0));
  indiceButton++;
  return button;
}
void settings(){
  size(displayWidth,displayHeight-50);
}

void setup(){
  PFont pfont = createFont("Verdana", 12);
  font = new ControlFont(pfont, 12);
  cp5 = new ControlP5(this);
  //agregaSlider("Posición deseada", 0, 90, 45);  //Inicio,final,Valor por default
  //agregaSlider("Posición real", 0, 90, 45);
  agregaKnob("ángulo de compuerta deseado", 0, 90, 45, 40);
  agregaKnob("ángulo de compuerta real", 0, 90, 45, 40);
  agregaButton("Iniciar Prueba");
  agregaButton("Paro de emergencia");
  
  /*println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');*/
}

void draw(){
  background(0);
  
  //CUADRO 1
  noStroke();
  fill(76,87,96);
  rect(20, 20, 480, 380, 20);
  
  //CUADRO 2
  rect(20, 420, 480, 160, 20);
  
  //CUADRO 3
  rect(525, 420, 500, 160, 20);
  
  //CUADRO 4
  rect(525, 340, 500, 60, 20);
  
  // CUADRO RPM
  noStroke();
  fill(114,158,161);
  rect(670, 350, 100, 40);
  
  // Títulos
  textSize(14);
  fill(0);
  text(" RPM ", 800, 380);
  
  //RPM
  /*String inString = myPort.readStringUntil('\n');
  if(inString != null){
    fill(0);
    text(inString, 715, 375);
    //println(inString);
  }*/
}
