public class Terrain {
  
  private HeightMap heightMap;
  
  private PShape rendered;
  private PVector[] vertices;
  private float size;  
  private int maxHeight;
  
  public Terrain(HeightMap heightMap, int size, int maxHeight){
    this.heightMap = heightMap;
    this.size = size;
    this.maxHeight = maxHeight;
    
    int w = this.heightMap.getWidth();
    int h = this.heightMap.getHeight();
    
    this.vertices = new PVector[w*h];
    
    float squareSize = this.size/(w-1);
    
    for(int y=0; y < h; y+= 1) {
     for(int x=0; x < w; x+= 1) {
       float xx = map(x, 0, w-1, -w/2, w/2);
       float yy = map(this.heightMap.getValue(x, y), 0.0, 1.0, 0.0, this.maxHeight);
       float zz = map(y, 0, h-1, -h/2, h/2);
       this.vertices[y*w + x] = new PVector(xx*squareSize, yy, zz*squareSize);
     }
    }
    
    this.rendered = createShape(GROUP);
    for(int y=0; y<h-1; y+= 1) {
      PShape row = createShape();
      row.beginShape(TRIANGLE_STRIP);
      for(int x=0; x<w; x += 1) {
        row.vertex(vertices[(y+1)*w + x].x, vertices[(y+1)*w + x].y, vertices[(y+1)*w + x].z);
        row.vertex(vertices[y*w+x].x, vertices[y*w+x].y, vertices[y*w+x].z);
      }
      row.endShape();
      this.rendered.addChild(row);
    }
   }
  
 public void display(){
   shape(this.rendered);
 }
}