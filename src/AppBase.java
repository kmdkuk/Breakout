package src;

import processing.core.*;

public abstract class AppBase {
  protected PApplet parent;

  public AppBase(PApplet parentApplet) {
    this.parent = parentApplet;
  }
}
