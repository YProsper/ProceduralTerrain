import peasy.*;
import controlP5.*;

Terrain t1;

PeasyCam cam;
ControlP5 cp5;

HeightMap map;

float angle = 0.0;

void setup() {
  size(1024, 1024, P3D);
  smooth();
  //noFill();
  cam = new PeasyCam(this, 1024);
  
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cp5.addButton("")
     .setSize(200, 50)
     .setPosition(width - 220, height - 70)
     .setCaptionLabel("Generate new terrain")
     .setId(0);
     
  t1 = newTerrain(0);
}

void draw(){
  background(255);
  rotateY(angle%360);
  
  t1.display();
   
  angle += 0.01;
  
  drawGui();
}

Terrain newTerrain(int method){
  HeightMap map = null;
  
  if (method == 0) {
    println("New terrain with midpoint displacement");
    map = generate(5);
  } else {
    println("New terrain with noise");
    map = generateNoisy(128, 128);
  }
  
  return generateTerrain(map, 500, 250);
}

void keyPressed(){
  t1 = newTerrain(0);
}

MidpointDisplacementHeightMap generate(int exponent){
  MidpointDisplacementHeightMap result = new MidpointDisplacementHeightMap(exponent, 0.3, 0.5);
  return result;
}
  
NoisyHeightMap generateNoisy(int w, int h){
  NoisyHeightMap result = new NoisyHeightMap(w, h);
  result.fill();
  return result;
}

Terrain generateTerrain(HeightMap map, int squareSize, int height){
  return new Terrain(map, squareSize, height);
}

void drawGui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void controlEvent(ControlEvent theEvent) {
  switch(theEvent.getController().getId()){
    case 0:
    {
      t1 = newTerrain(0);
      break;
    }
  }
}