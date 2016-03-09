class NoisyHeightMap implements HeightMap{
  private int w, h;
  private float[] values;
  
  public NoisyHeightMap(int w, int h){
    this.w = w;
    this.h = h;
    this.values = new float[w*h];
  }
  
  public int getWidth(){
    return this.w;
  }
  
  public int getHeight() {
    return this.h;
  }
  
  public float getValue(int x, int y){
    return this.values[y*w + x];
  }
  
  private void fill(){
    long seed = millis();
    float wNoise = 0.012;
    float hNoise = 0.02;
    
    noiseSeed(seed);
    
    for(int i=0; i< w; i++) {
      for(int j=0; j<h; j++) {
        values[j*w+i] = map(noise(i*wNoise, j*hNoise), 0, 1, -1, 1);
      }
    }
  }
  
  public void display(){
    loadPixels();
    for(int i=0; i<width-1; i++){
      for(int j=0; j<height-1; j++){
        pixels[i + j*width] = color(map(this.values[j*w+i], -1, 1, 0, 255));
      }
    }
    updatePixels();
  }
}