class MidpointDisplacementHeightMap implements HeightMap {
  
  private int last;
  private int exponent;
  private int resolution;
  private float factor;
  private float[] values;
  private float variation;
 
  
  public MidpointDisplacementHeightMap(int exponent, float variation, float factor) {
    println("Creating map");
    this.variation = variation;
    this.exponent = exponent;
    this.factor = factor;
    this.last = (int)pow(2, this.exponent);
    this.resolution = this.last + 1;
    this.values = new float[this.resolution * this.resolution];
    
    this.initMap();
  }
  
  private void initMap(){
    for (int i=0; i<values.length; i++){
      this.values[i] = 0.0;
    }
    
    this.setValue(0, 0, random(1.0));
    this.setValue(0, this.last, random(1.0));
    this.setValue(this.last, 0, random(1.0));
    this.setValue(this.last, this.last, random(1.0));

    int iter = 0;
    
    while(iter < this.exponent) {
      int chunks = (int)pow(2, iter);
      int chunkWidth = this.last/chunks;
      
      for (int x=0; x<chunks;x++){
        for(int y=0; y<chunks;y++) {
          int lx = x*chunkWidth;
          int rx = lx + chunkWidth;
          int ty = y*chunkWidth;
          int by = ty + chunkWidth;
          
          this.displace(lx, rx, ty, by, this.variation);
        }
      }
      
      iter++;
      this.variation *= this.factor;
    }
    this.normalize();
  }
  
  public int getWidth(){
    return this.resolution;
  }
  
  public int getHeight(){
    return this.resolution;
  }
  
  public void setValue(int x, int y, float value){
    this.values[y*this.resolution + x] = value;
  }
  
  public float getValue(int x, int y){
    return this.values[y*this.resolution + x];
  }
  
  public void display(){
    /* todo */
  }
  
  private void displace(int leftX, int rightX, int topY, int botY, float variation){
    int midX = (rightX + leftX)/2;
    int midY = (topY + botY)/2;
    
    float topLeft = this.getValue(leftX, topY);
    float topRight = this.getValue(rightX, topY);
    float botLeft = this.getValue(leftX, botY);
    float botRight = this.getValue(rightX, botY);
    
    float top = this.average(topLeft, topRight);
    float bot = this.average(botLeft, botRight);
    float left = this.average(topLeft, botLeft);
    float right = this.average(topRight, botRight);
    
     this.setValue(midX, botY, bot + this.randomVariation(variation));
     this.setValue(midX, topY, top + this.randomVariation(variation));
     this.setValue(leftX, midY, left + this.randomVariation(variation));
     this.setValue(rightX, midY, right + this.randomVariation(variation));
     
     this.setValue(midX, midY, (top+bot+left+right)/4);
  }
 
  private void normalize(){
    float max = -1000.0;
    float min = 1000.0;

    for (int i=0; i<this.values.length; i++) {
      if (this.values[i] > max) {
        max = this.values[i];
      } else if (this.values[i] < min) {
        min = this.values[i];
      }
    }
    
    float span = (max - min);
    for (int i=0; i<this.values.length; i++) {
      this.values[i] = ((this.values[i] - min)/span);
    }
  }
  
  private float average(float a, float b){
    return (a+b)/2;
  }
  
  private  float randomVariation(float variation){
    return random(-variation, variation);
  }
}