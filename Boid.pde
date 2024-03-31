class Boid
{
    PVector position;
    PVector velocity;
    PVector acceleration;

    float maxSpeed = 2;
    float maxForce = 0.01;
    float perceptionRadius = 120;

    boolean goingTowardsBait = false;

    int flockID;

    Boid(float x, float y, int fID)
    {
        position = new PVector(x, y);
        velocity = PVector.random2D();
        acceleration = new PVector(0, 0);
        flockID = fID;
    }

    void applyForce(PVector force)
    {
        acceleration.add(force);
    }

    void flock(ArrayList<Boid> boids)
    {
        PVector sep = seperation(boids);
        PVector ali = alignment(boids).mult(1.6);
        PVector coh = cohesion(boids).mult(1.27); 

        float edgeDistance = min(min(position.x, width - position.x), min(position.y, height - position.y));
        if (edgeDistance < 200 || goingTowardsBait) {
            sep.mult(1.8);
        } else {
            sep.mult(1.55);
        }
        
        acceleration.add(sep);
        acceleration.add(ali);
        acceleration.add(coh);
    }

    void update()
    {
        position.add(velocity);
        velocity.add(acceleration);
        velocity.limit(maxSpeed);
        acceleration.mult(0);
    }

    void show(PImage img)
    {
        pushMatrix();
            translate(position.x, position.y);
            rotate(velocity.heading());
            imageMode(CENTER);
            image(img, 0, 0);
        popMatrix();
    }

    void edges() {
        PVector avoidEdge = new PVector(0, 0);
        float margin = 150;
        float turnForce = 0.09;

        if (position.x < margin) {
            avoidEdge.x = turnForce;
        } else if (position.x > width - margin) {
            avoidEdge.x = -turnForce;
        }

        if (position.y < margin) {
            avoidEdge.y = turnForce;
        } else if (position.y > height - margin) {
            avoidEdge.y = -turnForce;
        }

        applyForce(avoidEdge);
    }

    PVector alignment(ArrayList<Boid> boids)
    {
        PVector steering = new PVector();
        int total = 0;

        for (Boid other : boids)
        {
            float dist = PVector.dist(position, other.position);

            if (other != this && other.flockID == this.flockID && dist < perceptionRadius)
            {
                steering.add(other.velocity);
                total++;
            }
        }

        if (total > 0)
        {
            steering.div(total);
            steering.setMag(maxSpeed);
            steering.sub(velocity);
            steering.limit(maxForce);
        }

        return steering;
    }

    PVector cohesion(ArrayList<Boid> boids)
    {
        PVector steering = new PVector();
        int total = 0;

        for (Boid other : boids)
        {
            float dist = PVector.dist(position, other.position);

            if (other != this && other.flockID == this.flockID && dist < perceptionRadius)
            {
                steering.add(other.position);
                total++;
            }
        }

        if (total > 0)
        {
            steering.div(total);
            steering.sub(position);
            steering.setMag(maxSpeed);
            steering.sub(velocity);
            steering.limit(maxForce);
        }

        return steering;
    }

    PVector seperation(ArrayList<Boid> boids)
    {
        PVector steering = new PVector();
        int total = 0;

        for (Boid other : boids)
        {
            float dist = PVector.dist(position, other.position);

            if (other != this && dist < perceptionRadius)
            {
                PVector diff = PVector.sub(position, other.position);
                diff.div(dist * dist);
                steering.add(diff);
                total++;
            }
        }

        if (total > 0)
        {
            steering.div(total);
            steering.setMag(maxSpeed);
            steering.sub(velocity);
            steering.limit(maxForce);
        }

        return steering;
    }

    void attractToBaitAndEat(ArrayList<Bait> baits) 
    {
        PVector closestBaitPos = null;
        float closestDist = Float.MAX_VALUE;
        Bait closestBait = null;
        for (Bait bait : baits) {
        float d = PVector.dist(position, bait.position);
        if (bait.baitType == this.flockID && d < closestDist) {
            closestDist = d;
            closestBaitPos = bait.position.copy();
            closestBait = bait;
        }
        }

        if (closestBaitPos != null && closestDist < 200) {
            goingTowardsBait = true;
            PVector desired = PVector.sub(closestBaitPos, position);
            desired.setMag(maxSpeed);
            PVector steer = PVector.sub(desired, velocity);
            steer.limit(maxForce * 2);
            acceleration.add(steer);

            if (closestDist < 10) {
                baits.remove(closestBait);
            }
        }
        else
        {
            goingTowardsBait = false;
        }
}


}