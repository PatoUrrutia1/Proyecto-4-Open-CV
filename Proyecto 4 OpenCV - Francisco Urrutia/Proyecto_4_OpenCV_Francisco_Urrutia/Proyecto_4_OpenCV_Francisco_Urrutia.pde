import gab.opencv.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

int gameScreen;

Capture video;
OpenCV opencv;


PImage Pantalla1;
PImage Pantalla2;

void setup() {
 
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
   
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
   

  video.start();
}

void draw() {
  
  
  switch (gameScreen) {
    case 0:
      iniScreen();
    break;
    case 1:
      camScreen();
    break;
  }
}

void iniScreen(){
  
  // Código de pantalla de inicio.
  background(0);
  textAlign(CENTER, CENTER);
  text("Mueva la cabeza ARRIBA, ABAJO, IZQUIERDA O DERECHA para activar y desactivar el filtro",320,240);
  text("Haz click para iniciar", 320, 300);
  
  Pantalla1 = loadImage("02 rotación arriba-abajo.png");
  Pantalla1.resize(0, 150);
  image(Pantalla1, 100, 50);
  
  Pantalla2 = loadImage("01 rotación horizontal.png");
  Pantalla2.resize(0, 150);
  image(Pantalla2, 300, 50);
  
  if (mousePressed) {
    gameScreen = 1;
  }
}
  
  void camScreen(){
  
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  
  Rectangle[] face = opencv.detect();
  println(face.length);
  
   
  

  for (int i = 0; i < face.length; i++) {
    
    opencv.findCannyEdges(20,60);
    image(opencv.getOutput(),0,0);
    println(face[i].x + "," + face[i].y);
    noStroke();
    rect(face[i].x, face[i].y, face[i].width, face[i].height);
  }
     
  
}

void captureEvent(Capture c) {
  c.read();
}