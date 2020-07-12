package src;

import processing.core.*;

class Item extends AppBase {
  float x, y;
  boolean exist = false;
  int kinds;
  // 0:スピードダウン橙S3
  // 1:キャッチ黄緑C
  // 2:ディスらぷしょんボール増やす水D3
  // 3:エキスパンドパッドを長くする青E3
  // 4:レーザークリックで発射赤L2
  // 5:プレイヤーエクステンドライフを一増やす灰P1
  // 6:リダクションパッドを短くするスコア2倍黒小R2
  String name;
  boolean cflag = false;
  int count = 0;
  boolean active = false;

  public Item(PApplet parentApplet) {
    super(parentApplet);
  }

  void update() {
    if (!(exist))
      return; // itemが存在しないなら
    y += 0.5;
    if (y > parent.height)
      exist = false;// 画面外に出たfalse
    switch (kinds) {
      case 0:
        drawitem("S", 255, 183, 76);

        break;
      case 1:
      case 2:
        drawitem("D", 183, 196, 22);
        break;
      case 3:
        drawitem("E", 50, 50, 200);
        break;
      case 4:
        drawitem("L", 204, 0, 0);
        break;
      case 5:
        drawitem("P", 140, 140, 140);
        break;
      case 6:
        drawitem("R", 38, 38, 38);
        break;
    }
    parent.rectMode(PApplet.CORNER);
    parent.textAlign(PApplet.LEFT);
    if (Globals.item.x + 15.0 / 2 >= Globals.pad_x && Globals.item.x - 15.0 / 2 <= Globals.pad_x + Globals.pad_w
        && Globals.item.y + 15.0 / 2 >= parent.height - 50 && Globals.item.y - 15.0 / 2 <= parent.height - 45) // itemがパッドに触れたとき
    {
      exist = false;
      Globals.score += 1000 * Globals.rate;
      active = true;
      count = 0;
      switch (kinds) {
        case 0:
          for (int i = 0; i < 3; i++) {
            Globals.ball[i].speed -= 1.0;
          }
          break;
        case 1:
        case 2:
          for (int i = 0; i < 3; i++) {
            Globals.ball[i].exist = true;
            Globals.ball[i].dx = Globals.ball[0].dx;
            Globals.ball[i].dy = Globals.ball[0].dy;
            Globals.ball[i].x = Globals.ball[0].x;
            Globals.ball[i].y = Globals.ball[0].y;
          }
          active = false;
          break;
        case 3:
          Globals.pad_w = 100;
          Globals.rate = 1;
          break;
        case 4:
          Globals.padstatus = 1;
          break;

        case 5:
          Globals.life++;
          active = false;
          break;
        case 6:
          Globals.pad_w = 25;
          Globals.rate = 2;
          break;
      }
    }
    if (active) {
      count++;
      if (count / 120 > 30) {
        active = false;
        switch (kinds) {
          case 0:
            for (int i = 0; i < 3; i++) {
              Globals.ball[i].speed += 1.0;
            }
            break;
          case 3:
          case 6:
            Globals.pad_w = (float) 50.0;
            Globals.rate = 1;
            break;
          case 4:
            Globals.padstatus = 0;
            break;
        }
      }
    }
  }

  void drawitem(String s, int r, int g, int b) {
    parent.fill(r, g, b);
    parent.rectMode(PApplet.CENTER);
    parent.rect(x, y, 15, 15);
    if (kinds == 6) {
      parent.fill(255);
    } else {
      parent.fill(0);
    }
    parent.textAlign(PApplet.CENTER);
    parent.textSize(10);
    parent.text(s, x, y + 5);
  }

  boolean generate(int i, int j) {
    int rnd = (int) parent.random(1000);
    if (rnd < 700) {
      if (rnd < 150) {
        kinds = 0;
      } else if (rnd < 300) {
        int count = 0;
        for (int s = 0; s < 3; s++) {
          if (Globals.ball[s].exist == true) {
            count += 1;
          }
        }
        if (count == 1) {
          kinds = 2;
        } else {
          return false;
        }
      } else if (rnd < 450) {
        kinds = 3;
      } else if (rnd < 550) {
        kinds = 4;
      } else if (rnd < 600) {
        kinds = 5;
      } else if (rnd < 700) {
        kinds = 6;
      }
      x = Globals.block[i][j].x + Globals.block[i][j].w / 2;
      y = Globals.block[i][j].y + Globals.block[i][j].h / 2;
      return true;
    }
    return false;
  }
}
