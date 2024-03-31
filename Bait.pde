class Bait
{
    PVector position;
    int baitType;

    Bait(float x, float y, int type) {
    position = new PVector(x, y);
    this.baitType = type;
    }

    void display() {
    if (baitType == 1) {
        fill(#912BBC, 180); // Red for type 1
    } else {
        fill(#31363F, 180); // Blue for type 2
    }
    noStroke();
    ellipse(position.x, position.y, 32, 32);
    }
}