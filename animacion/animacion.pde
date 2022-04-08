int maxImages=3;//numero maximo de imagenes
int indexImg=0;
PImage [] imagenes=new PImage[maxImages];
PImage turbina;
PImage [] aire=new PImage[maxImages];

void setup(){
  size(1500,1000);
  for(int i=0; i<imagenes.length;i++){
  imagenes[i]=loadImage("G"+i+".png");
  aire[i]=loadImage("AIRE"+i+".png");
  }
  turbina=loadImage("B0.png");
  frameRate(15);
  imageMode(CENTER);
}

void draw(){
background(0);
image(turbina,width/2,height/2);
image(imagenes[indexImg],width/2+230,height/2);
image(aire[indexImg],width/2+100,height/2+40);
indexImg=(indexImg+1)%imagenes.length;
}
