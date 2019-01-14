import controlP5.*;
int n = 10;
Button addN;
Button subN;

PVector[] points;
PVector current;
PVector previous;
float percent = 0.5;
int RGBS[][] = new int[n][3];

void setup() {
  size(1080, 720);
  //fullScreen();
  addN = new Button("+", 50, 480, 50, 50);
  subN = new Button("-", 50, 580, 50, 50);

  reset();
}

void reset() {
  
  points = new PVector[n];

  for (int i = 0; i < n; i++) 
  {
    float angle = i * 2 * PI / n;
    PVector v = PVector.fromAngle(angle);

    v.mult(width / 3.5);
    v.add(width / 2, height / 2);
    points[i] = v;
  }
  for (int i = 0; i < n; i++)
  {
  RGBS[i][0] = (int)random(50,255);
  RGBS[i][1] = (int)random(50,255);
  RGBS[i][2] = (int)random(50,255);
  }
  
  /////////////////////////////////////////////////
  current = new PVector(random(width), random(height));
  background(0);
  stroke(255);
  strokeWeight(3);
  for (PVector p : points) {
    point(p.x, p.y);
  }
}

void keyPressed()
{
  if (keyCode == ' ')
  {
    reset();
  }
}

void mouseReleased() {
  if (addN.MouseIsOver()) 
  {
   if (n < 10)
    n++;
    reset();
  }
  if (subN.MouseIsOver()) 
  {
    if(n > 1)
    n--;
    reset();
  }
}

void draw() 
{
  addN.Draw();
  subN.Draw();
 
textSize(32);
fill(0, 102, 153, 204);
text(n, 70, 550);  

  for (int i = 0; i < 1000; i++) {
    strokeWeight(0.5);
    int randomN = floor(random(points.length));
    PVector next = points[randomN];
    if (next != previous) {
      stroke( RGBS[randomN][0],
            RGBS[randomN][1],
            RGBS[randomN][2]);
            
      current.x = lerp(current.x, next.x, percent);
      current.y = lerp(current.y, next.y, percent);
      point(current.x, current.y);
    }
    previous = next;
  }
}
