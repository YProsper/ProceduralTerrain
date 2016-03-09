import peasy.*;

Terrain t1;

PeasyCam cam;
HeightMap map;
PShader ambiant;

float angle = 0.0;

void setup() {
  size(1024, 1024, P3D);
  smooth();
  //noFill();
  cam = new PeasyCam(this, 1024);
 
  t1 = newTerrain(0);
 
}

void draw(){
  background(255);
  rotateY(angle%360);
  
  t1.display();
   
  angle += 0.01;
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
  MidpointDisplacementHeightMap result = new MidpointDisplacementHeightMap(exponent, 0.5, 0.5);
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