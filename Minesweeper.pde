

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton [NUM_ROWS][NUM_COLS];
    
    for(int row = 0; row < NUM_ROWS; row++)
    {
      for(int col = 0; col < NUM_COLS; col++)
        buttons[row] [col] = new MSButton(row, col);
    }
    
    setBombs();
}
public void setBombs()
{   
    for(int i = 0; i < NUM_COLS; i++)
    {
        int row = (int)(Math.random()*NUM_ROWS);
        int col = (int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[row][col]))
        {
            bombs.add(buttons[row][col]);
            // System.out.println(row + "," + col); to check position of bombs
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
                return false;
            if(buttons[r][c].isClicked() && bombs.contains(buttons[r][c]))
                return false;
        }
    }
    return true;
}
public void displayLosingMessage()
{
    for(int r = 0; r < NUM_ROWS; r++)
    {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(bombs.contains(buttons[r][c]))
                buttons[r][c].setLabel("!");
                textSize(15);
                buttons[10][6].setLabel("Y");
                buttons[10][7].setLabel("o");
                buttons[10][8].setLabel("u");
                buttons[10][9].setLabel(" ");
                buttons[10][10].setLabel("L");
                buttons[10][11].setLabel("o");
                buttons[10][12].setLabel("s");
                buttons[10][13].setLabel("e !");
        }
    }

}
public void displayWinningMessage()
{
    if (isWon() == true)
        textSize(15);
        buttons[10][6].setLabel("Y");
        buttons[10][7].setLabel("o");
        buttons[10][8].setLabel("u");
        buttons[10][9].setLabel(" ");
        buttons[10][10].setLabel("W");
        buttons[10][11].setLabel("o");
        buttons[10][12].setLabel("n");
        buttons[10][13].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
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
        clicked = true;
        if(keyPressed == true)
            {
                if (marked = true)
                    marked = false;
                else
                    marked = true;
            }
        else if (bombs.contains(this))
            displayLosingMessage();
        else if (countBombs(r,c) > 0)
            setLabel(Integer.toString(countBombs(r,c)));
        else
            {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
            if(isValid(r, c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
            if(isValid(r-1, c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
            if(isValid(r+1, c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
            }
    }   

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int row, int col)
    {
        if(row >= 0 && row < NUM_ROWS && col >= 0 && col < NUM_COLS)
            return true;
        else
            return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //top left
        if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs+=1;
        //top middle
        else if(isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
            numBombs+=1;
        //top right
        if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs+=1;
        //middle left
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
            numBombs+=1;
        //middle right
        if(isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
            numBombs+=1;
        //bottom left
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs+=1;
        //bottom middle
        if(isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
            numBombs+=1;
        //bottom right
        else if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs+=1;

        return numBombs;
    }
}