import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
public final static int NUM_BOMBS=50;
private MSButton[][] buttons;
private ArrayList <MSButton> bombs;
void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);
  Interactive.make( this );
  bombs=new ArrayList <MSButton>();
  buttons=new MSButton[NUM_ROWS][NUM_COLS];
  for (int rows=0; rows<NUM_ROWS; rows++)
  {
    for (int col=0; col<NUM_COLS; col++)
    {
      buttons[rows][col]=new MSButton(rows, col);
    }
  }
  setBombs();
}
public void setBombs()
{
  while (bombs.size()<NUM_BOMBS)
  {
    int r= (int)(Math.random()*NUM_ROWS);
    int c= (int)(Math.random()*NUM_COLS);
    if (!bombs.contains(buttons[r][c]))
    {
      bombs.add(buttons[r][c]);
    }
  }
}
public void draw ()
{
  background( 0 );
  if (isWon())
  {
    displayWinningMessage();
  }
}
public boolean isWon()
{
  for (int r=0; r<NUM_ROWS; r++)
  {
    for (int c=0; c<NUM_COLS; c++)
    {
      if (!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
      {
        return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
  for (int r=0; r<NUM_ROWS; r++)
  {
    for (int c=0; c<NUM_COLS; c++)
    {
      if (bombs.contains(buttons[r][c])&& !buttons[r][c].isClicked())
      {
        buttons[r][c].marked=false;
        buttons[r][c].clicked=true;
      }
    }
  }
  /*
  for (int i=0; i<NUM_ROWS; i++)
   {
   for (int x=0; x<NUM_COLS; x++)
   {
   buttons[x][i].label="";
   }
   }
   */
  buttons[9][9].label="y";
  buttons[9][10].label="o";
  buttons[9][11].label="u";
  buttons[9][12].label="";
  buttons[10][8].label="l";
  buttons[10][9].label="o";
  buttons[10][10].label="s";
  buttons[10][11].label="e";
  buttons[10][12].label="!";
}
public void displayWinningMessage()
{
  /*
  for (int i=0; i<NUM_ROWS; i++)
   {
   for (int x=0; x<NUM_COLS; x++)
   {
   buttons[x][i].label="";
   }
   }
   */
  buttons[9][9].label="y";
  buttons[9][10].label="o";
  buttons[9][11].label="u";
  buttons[9][12].label="";
  buttons[10][8].label="w";
  buttons[10][9].label="o";
  buttons[10][10].label="n";
  buttons[10][11].label="!";//your code here
}
public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;
  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  { 
    if (mouseButton==RIGHT)
    {
      marked=!marked;
    } 
    if (mouseButton==LEFT&&!marked)
    {
      clicked=true;
    }
    if (bombs.contains(this))
    {
      displayLosingMessage();
    } else if (countBombs(r, c)>0)
    {
      label="" + countBombs(r, c);
    } else 
    {
      if (isValid(r, c-1)==true && buttons[r][c-1].isClicked()==false)
      {
        buttons[r][c-1].mousePressed();
      }
      if (isValid(r, c+1)==true && buttons[r][c+1].isClicked()==false)
      {
        buttons[r][c+1].mousePressed();
      }
      if (isValid(r-1, c)==true && buttons[r-1][c].isClicked()==false)
      {
        buttons[r-1][c].mousePressed();
      }
      if (isValid(r+1, c)==true && buttons[r+1][c].isClicked()==false)
      {
        buttons[r+1][c].mousePressed();
      }
      if (isValid(r-1, c+1)==true && buttons[r-1][c+1].isClicked()==false)
      {
        buttons[r-1][c+1].mousePressed();
      }
      if (isValid(r+1, c+1)==true && buttons[r+1][c+1].isClicked()==false)
      {
        buttons[r+1][c+1].mousePressed();
      }
      if (isValid(r-1, c-1)==true && buttons[r-1][c-1].isClicked()==false)
      {
        buttons[r-1][c-1].mousePressed();
      }
      if (isValid(r+1, c-1)==true && buttons[r+1][c-1].isClicked()==false)
      {
        buttons[r+1][c-1].mousePressed();
      }
    }
  }
  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );
    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    return r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS;
  }
  public int countBombs(int r, int c)
  {
    int numBombs = 0;
    if (isValid(r, c-1) && bombs.contains(buttons[r][c-1]))
    {
      numBombs++;
    }
    if (isValid(r, c+1) && bombs.contains(buttons[r][c+1]))
    {
      numBombs++;
    }
    if (isValid(r-1, c) && bombs.contains(buttons[r-1][c]))
    {
      numBombs++;
    }
    if (isValid(r+1, c) && bombs.contains(buttons[r+1][c]))
    {
      numBombs++;
    }
    if (isValid(r-1, c+1) && bombs.contains(buttons[r-1][c+1]))
    {
      numBombs++;
    }
    if (isValid(r+1, c+1) && bombs.contains(buttons[r+1][c+1]))
    {
      numBombs++;
    }
    if (isValid(r-1, c-1) && bombs.contains(buttons[r-1][c-1]))
    {
      numBombs++;
    }
    if (isValid(r+1, c-1) && bombs.contains(buttons[r+1][c-1]))
    {
      numBombs++;
    }
    return numBombs;
  }
}
