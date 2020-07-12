package src;

import processing.core.*;

public class App extends PApplet {
    Main m;

    public void settings() {
        size(600, 700);
    }

    public void setup() {
        frameRate(120);
        background(0);
        m = new Main(this);
    }

    public void draw() {
        m.update();
    }

    // クリック時
    // 基本モード変更
    public void mouseClicked() {
        m.clicked();
    }

    public void stop() {
        super.stop();
    }

    public static void main(String[] args) {
        PApplet.main("src.App");
    }
}
