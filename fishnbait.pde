PImage fishBlue, fishGrey, pond;
ArrayList<Boid> flock1, flock2;
ArrayList<Bait> baits;
void setup() 
{
    size(1440, 960);
    fishBlue = loadImage("FishBlue.png");
    fishGrey = loadImage("FishGrey.png");
    pond = loadImage("pond.png");

    flock1 = new ArrayList<Boid>();
    flock2 = new ArrayList<Boid>();
    baits = new ArrayList<Bait>();

    for (int i = 0; i < 15; i++)
    {
        flock1.add(new Boid(width/2 - random(-50, 50), height/4 - random(-50, 50), 1));
    }

    for (int i = 0; i < 15; i++)
    {
        flock2.add(new Boid(width/4 + random(-50, 50), height/2 + random(-50, 50), 2));
    }
}

void draw() 
{
    background(pond);

    if (baits.size() > 0)
    {
        for(Bait bait : baits)
        {
            bait.display();
        }
    }

    for (Boid boid : flock1)
    {
        boid.update();
        boid.flock(flock1);
        boid.attractToBaitAndEat(baits);
        boid.edges();
        boid.show(fishBlue);
    }
    for (Boid boid : flock2)
    {
        boid.update();
        boid.flock(flock2);
        boid.attractToBaitAndEat(baits);
        boid.edges();
        boid.show(fishGrey);
    }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    baits.add(new Bait(mouseX, mouseY, 1)); // type 1
  } else if (mouseButton == RIGHT) {
    baits.add(new Bait(mouseX, mouseY, 2)); // type 2
  }
}
