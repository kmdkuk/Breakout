class Button
{
  float x, y, w, h;
  float size;
  String text;
  boolean exist = false;
  //ボタンの文字,x座標,y座標,幅,高さ
  Button(String s, float si, float a, float b, float c, float d)
  {
    text = s;
    size = si;
    x = a;
    y = b;
    w = c;
    h = d;
  }

  void update()
  {
    exist = true;
    if (isOnMouse())
    {
      fill(0, 255, 0);
    } else
    {
      fill(255, 255, 255, 200);
    }
    rect(x, y, w, h);
    textAlign(CENTER);
    textSize(size);
    fill(0);
    text(text, x+w/2, y+h-5);
    textAlign(LEFT);
  }

  boolean isOnMouse()
  {
    if (exist)
    {
      if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y + h)
      {
        return true;
      }
    }
    return false;
  }
}
