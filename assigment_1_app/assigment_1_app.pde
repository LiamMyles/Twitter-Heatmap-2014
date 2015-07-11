////////////////////////////***Libraries***////////////////////////////
////////////////////////////***Libraries***////////////////////////////
////////////////////////////***Libraries***////////////////////////////

import com.francisli.processing.http.*;


////////////////////////////***Global Variables***////////////////////////////
////////////////////////////***Global Variables***////////////////////////////
////////////////////////////***Global Variables***////////////////////////////


HttpClient client;
//creates the client

//creates the  CapCity Instances for Europe
CapCity am, at, berlin, bern, brus, bud, copen, dub, lis, lon, lux, mad, paris, prague, rome;
//creates CapCity instances for states in Usa
CapCity cal, tex, ny, flor, ill, pen, ohio, geor, mich, nc, nj, vir, wash, mass, ariz;
//arrayList for elements
ArrayList<CapCity> europeList;
ArrayList<CapCity> usaList;

//global varibales
HashMap twitterParams = new HashMap(); 

//Search Terms
String hashtags, mood, search, searchWord, hashtagsUsa;

//drawn varibales
String text, user, tweet, name, currentTweet;

//arrays
StringList usernames;
StringList tweets;

//intergers
int capNum;

//images
PImage europe;
PImage ui;
PImage usa;
PImage info;

//Fonts
PFont lucidaC;
PFont franklin;

//matching Hashtags
String [] match;
String hashtagText;

//map location
int mapX, mapY;

//booleans
boolean stopTweets, changedTweet, searchSent, requestInfo;

//tweet responce 
int tweetNum, tweetsStored; 

//changeing tweet displayed
int displayNum;

//used in max_Id for tweets
//**out of use but kept in because code was left in just incase #YOLO #SarcasticYOLO**
//String maxIdString; 
//long maxIdLong;
//long maxIdLongOld;

//selection Variables
int emo, location, choice;
String emotion;
String emotion2;
String local;
String[] searchChoice;
color emoColour;
boolean locationBoolean; 


////////////////////////////***Setup***////////////////////////////
////////////////////////////***Setup***////////////////////////////
////////////////////////////***Setup***////////////////////////////
void setup()
{
  //**classes**
  //CapCity Class Instances
  europeList = new ArrayList<CapCity>(15);
  europeList.add(am = new CapCity(167, 261, 0, "#amsterdam", "Amsterdam"));
  europeList.add(at = new CapCity(336, 449, 0, "#athens", "Athens"));
  europeList.add(berlin = new CapCity(233, 265, 0, "#berlin", "Berlin"));
  europeList.add(bern = new CapCity(179, 335, 0, "#bern", "Bern"));
  europeList.add(brus = new CapCity(160, 283, 0, "#brussles", "Brussles"));
  europeList.add(bud = new CapCity(284, 330, 0, "#budapest", "Budapest"));
  europeList.add(copen = new CapCity(225, 229, 0, "#copenhegam", "Copenhegam"));
  europeList.add(dub = new CapCity(82, 226, 0, "#dublin", "Dublin"));
  europeList.add(lis = new CapCity(5, 414, 0, "#lisbon", "Lisbon"));
  europeList.add(lon = new CapCity(125, 265, 0, "#london", "London"));
  europeList.add(lux = new CapCity(170, 297, 0, "#luxenburg", "Luxenburg"));
  europeList.add(mad = new CapCity(70, 403, 0, "#madrid", "Madrid"));
  europeList.add(paris = new CapCity(122, 308, 0, "#paris", "Paris"));
  europeList.add(prague = new CapCity(240, 299, 0, "#prague", "Prague"));
  europeList.add(rome = new CapCity(225, 404, 0, "#rome", "Rome"));

  //CapCity Class usa States
  usaList = new ArrayList<CapCity>(15);
  usaList.add(cal = new CapCity(45, 230, 0, "#California", "California"));
  usaList.add(tex = new CapCity(228, 318, 0, "#Texas", "Texas"));
  usaList.add(ny = new CapCity(468, 160, 0, "#Newyork", "New York "));
  usaList.add(flor = new CapCity(410, 344, 0, "#Florida", "Florida"));
  usaList.add(ill = new CapCity(320, 213, 0, "#Illinois", "Illinois"));
  usaList.add(pen = new CapCity(420, 190, 0, "#Pennsylvania", "Pennsylvania"));
  usaList.add(ohio = new CapCity(380, 200, 0, "#Ohio", "Ohio"));
  usaList.add(geor = new CapCity(385, 295, 0, "#Georgia", "Georgia"));
  usaList.add(mich = new CapCity(356, 168, 0, "#Michigan", "Michigan"));
  usaList.add(nc = new CapCity(420, 255, 0, "#North Carolina", "North Carolina"));
  usaList.add(nj = new CapCity(440, 190, 0, "#Newjersey", "New Jersey"));
  usaList.add(vir = new CapCity(420, 230, 0, "#Virginia", "Virginia"));
  usaList.add(wash = new CapCity(65, 100, 0, "#Washington", "Washington"));
  usaList.add(mass = new CapCity(470, 160, 0, "#Massachusetts", "Massachusetts"));
  usaList.add(ariz = new CapCity(100, 270, 0, "#Arizona", "Arizona"));

  //**Visual**
  //default Text
  tweet = "Waiting...";
  name = "Waiting...";
  currentTweet = "0";

  //emotion collour for :) :( background
  emoColour = color(225, 0);
  //images being loaded
  europe = loadImage("europe.jpg");
  ui = loadImage("app_ui.png");
  usa = loadImage("usa.jpg");
  info = loadImage("info.png");
  
  
  //Fonts being Loaded
  lucidaC = loadFont("LucidaConsole-48.vlw");
  franklin = loadFont("FranklinGothic-Book-15.vlw");
  textFont(franklin);
  //General visual settings
  smooth();
  frameRate(25);
  size(800, 800);
  background(250);
  fill(0);

  //**Array Setup**
  //createing arrays for List of usernames and Tweets
  usernames = new StringList();
  tweets = new StringList();
  searchChoice = new String[6];
  //Filling searchChoice array with search words. 
  searchChoice[0] = "Love";
  searchChoice[1] = "Hate";
  searchChoice[2] = "Santa";
  searchChoice[3] = "Pie";
  searchChoice[4] = "Cake";
  searchChoice[5] = "Cookie";

  //**varibales setup**
  tweetsStored = 0;
  location = 0;

  //**twitter setups** 
  search ="1.1/search/tweets.json";
  //word to be searched for
  searchWord = "Love";
  mood ="";
  emotion2 = "None";
  emotion = "";
  local = "Europe";
  //hashtags of captials in europe to be searched
  //%23 = # | %20 = space
  hashtags =  "%20%23Amsterdam"+"%20OR%20"+
    "%23Athens"+"%20OR%20"+
    "%23Berlin"+"%20OR%20"+
    "%23Bern"+"%20OR%20"+
    "%23Brussels"+"%20OR%20"+
    "%23Budapest"+"%20OR%20"+
    "%23Copenhagen"+"%20OR%20"+
    "%23Dublin"+"%20OR%20"+
    "%23Lisbon"+"%20OR%20"+
    "%23London"+"%20OR%20"+
    "%23Luxembourg"+"%20OR%20"+
    "%23Madrid"+"%20OR%20"+
    "%23Paris"+"%20OR%20"+
    "%23Prague"+"%20OR%20"+
    "%23Rome";
  //hashtags for states in europe
  hashtagsUsa =  "%20%23California"+"%20OR%20"+
    "%23Texas"+"%20OR%20"+
    "%23Newyork"+"%20OR%20"+
    "%23Florida"+"%20OR%20"+
    "%23Illinois"+"%20OR%20"+
    "%23Pennsylvania"+"%20OR%20"+
    "%23Ohio"+"%20OR%20"+
    "%23Georgia"+"%20OR%20"+
    "%23Michigan"+"%20OR%20"+
    "%23NorthCarolina"+"%20OR%20"+
    "%23Newjersey"+"%20OR%20"+
    "%23Virginia"+"%20OR%20"+
    "%23Washington"+"%20OR%20"+
    "%23Massachusetts"+"%20OR%20"+
    "%23Arizona";

  //**HashMap**
  //Twitter Parameters
  twitterParams.put("q", "-RT%20"+searchWord+hashtags+mood);
  twitterParams.put("lang", "en");
  twitterParams.put("count", 100);

  //**Client**
  //twitter client httpclient consturctor 
  //use the httpclient constructor to create a client connecting to twiter api
  client = new HttpClient(this, "api.twitter.com");
  // turn on https
  client.useSSL = true;
  // turn on OAuth request signing
  client.useOAuth = true;
  // set up OAuth signing parameters
  // twitter log ins
  client.oauthConsumerKey = "KEY";
  client.oauthConsumerSecret = "SECRET";
  client.oauthAccessToken = "TOKEN";
  client.oauthAccessTokenSecret = "TOKEN SECRET"; 
  //Statrs the first search
  //client.GET(search, twitterParams);

  //**Map**
  //location europen map
  mapX = 150;
  mapY = 300;
}

////////////////////////////***Draw***////////////////////////////
////////////////////////////***Draw***////////////////////////////
////////////////////////////***Draw***////////////////////////////

void draw()
{
  //redraws the background
  background(250);
  //fill colour of text
  fill(0);
  //Text
  textFont(franklin);
  textSize(15);
  textAlign(CENTER);
  //tweet user is on / tweets that have been loaded
  // 1/100
  text(currentTweet+"/"+str(tweetsStored), 400, 40, 420, 50);
  textAlign(LEFT);
  //The tweet owners Name
  text(name, 170, 40, 400, 50);
  textSize(13);
  //The tweet
  text(tweet, 170, 60, 470, 280);

  //search options
  textFont(lucidaC);
  textAlign(CENTER);
  textSize(35);
  noStroke();
  fill(emoColour);
  rect(170, 220, 140, 60);
  fill(0);
  text(emotion2, 245, 260);
  text(local, 560, 260);
  text(searchWord, 400, 260);

  textSize(30);
  //What is being searched 
  text(emotion+searchWord + " in "+ local, 400, 175);


  //map location
  //if false EU if ture USA
  if (locationBoolean == false)
  {
    image(europe, mapX, mapY);
  }
  if (locationBoolean == true)
  {
    image(usa, mapX, mapY);
  }
  //calls the heatMap funcion which updates the bubbles. 
  heatMap();
  //places the Image UI
  image(ui, 75, 15);
  //Places the tutorial over the screen if requestInfo is ture
  //Request info is placed if space bar is pressed
  // False = show true = hide
  if (requestInfo == false)
  {
    image(info, 0, 0);
  }
}

////////////////////////////***HTTP Responce Function***////////////////////////////
////////////////////////////***HTTP Responce Function***////////////////////////////
////////////////////////////***HTTP Responce Function***////////////////////////////

void responseReceived(HttpRequest req, HttpResponse res)
{
  if (res.statusCode == 200)
  {
    com.francisli.processing.http.JSONObject results = res.getContentAsJSONObject();
    //sometimes the amount of tweets receieved is less then requested
    //this causes an index out of bounds exception error, to combat this
    //I count how many results are given (tSize)
    int tSize = results.get("statuses").size(); 
    //tSize has no results it wont continue and will instead say that the search failed.
    if (tSize > 0)
    {
      for (int i = 0; i < tSize; i++)
      {
        text = results.get("statuses").get(i).get("text").stringValue();
        user = results.get("statuses").get(i).get("user").get("name").stringValue();

        //replaces all new lines (\n) and carriage returns (\r) with a blank. 
        //Prevent the idiots who make stupid tweets that break the desgin...
        text = text.replace("\n", "").replace("\r", "");
        //places the user name and tweet into the the i pos of the stringList
        usernames.set(i, user);
        tweets.set(i, text);
        //sends the text to the hastag function
        checkHashtags(text);
        //adds togeather all the tweets that have been stored
        tweetsStored += 1;
        //if more than 100 tweets are collected it breaks the loop and changes booleans
        if (tweetsStored >= 100)
        {
          println("100 tweets have been colected");
          stopTweets = true;
          searchSent = false;
          break;
        }
      }
                //function that was used when I didn't load all the tweets at once,
                //if the user went past the last loaded tweet it would say "Loading.." and once
                //the next tweets where loaded the last tweet would get changed.
                //    if (changedTweet == false && tweetsStored < 100)
                //    {
                //      name = usernames.get(tweetNum);
                //      tweet = tweets.get(tweetNum);
                //      currentTweet = str(displayNum+1);
                //    }
      //Changes booleans                 
      stopTweets = true;
      searchSent = false;

      //updates the Feed
      name = usernames.get(0);
      tweet = tweets.get(0);
      currentTweet = "1";

                //was required when I grabed tweets a few at a time, grabing in chunks makes this useless and destructive in some cases
                //      //checks the last tweet and grabs the ID of the tweet as a string because
                //      //it wasn't working as a long
                //      maxIdString = results.get("statuses").get(tSize-1).get("id_str").stringValue();
                //      //turns the string into a long
                //      maxIdLongOld = Long.parseLong(maxIdString);
                //      //I took away -1 from the max Id to pervent dups tweets. 
                //      //https://dev.twitter.com/docs/working-with-timelines
                //      maxIdLong = maxIdLongOld - 1;
                //      //sets the max_id perameter for twitter
                //      twitterParams.put("max_id", maxIdLong);
                //      println("last tweets Id was " + maxIdLong);
    }
    //else for tSize check
    else
    {
      name = "Failed Search";
      tweet = "Not results found, try a different search?";
      currentTweet = "0";
    }
  }
  //else for status code check
  else
  {
    //displays the error
    name = "Failed Search";
    currentTweet = "0";
    tweet = "Request fail, twitter error "+ res.statusCode+" try again shortly";
  }
}

////////////////////////////***Key Pressed Functions***////////////////////////////
////////////////////////////***Key Pressed Functions***////////////////////////////
////////////////////////////***Key Pressed Functions***////////////////////////////

void keyPressed()
{
  //checks if the spacebar was pressed and changes if the tutorial is viewable
  if (key == ' ')
  {
    if (requestInfo == true)
    {
      requestInfo = false;
    }
    else
    {
      requestInfo = true;
    }
  }
  
  //Checks if A key was pressed.
  //If pressed it changes the Emotion status of the search
  if (key == 'a' || key == 'A')
  {
    emo += 1;
    if (emo == 1)
    {
      emotion = ":) ";
      emotion2 = ":) ";
      //space - : - ) <- url encoded
      mood = "%20%3A%29";
      emoColour = color(50, 255, 50, 50);
    }
    else if (emo == 2)
    {
      emotion = ":( ";
      emotion2 = ":( ";
      //space - : - ( <- url encoded
      mood = "%20%3A%28";
      emoColour = color(255, 50, 50, 50);
    }
    else
    {
      emo = 0;
      emotion = " ";
      emotion2 = "None";
      mood = "";
      emoColour = color(255, 0);
    }
  }
  //Checks if the S key was pressed
  //If pressed it cycles through the array of search words. 
  if (key == 's' || key == 'S')
  {
    choice += 1;
    if (choice < 6)
    {
      searchWord = searchChoice[choice];
    }
    else
    {
      choice = 0;
      searchWord = searchChoice[choice];
    }
  }
  //Checks if the D key was pressed
  //If pressed it changes the location of the Searches. 
  if (key == 'd' || key == 'D')
  {
    location += 1;
    if (location == 1)
    {
      local = "USA";
      locationBoolean = true;
    }
    else
    {
      location = 0;
      local = "Europe";
      locationBoolean = false;
    }
  }
  //Checks if the C key was pressed.
  //If pressed it captures a screenshot of the current state of the screen.
  // it then saves the screenshot as a number and increases that number.
  // This makes you able to take more than 1 screenshot. 
  if (key == 'c' || key == 'C')
  {
    capNum += 1;
    save("capture("+capNum+").jpg");
  }
  //Checks if the Enter/Return key has been pressed.
  //If pressed it will start a search and change the text with loading text.
  if (keyCode == RETURN || keyCode == ENTER)
  {
    if (searchSent == false)
    {
      tweet = "Loading...";
      name = "Loading...";
      currentTweet = "0";
      println("Enter Pressed");
      checkTwitter();
    }
  }
  //CODED is used for right and left arrow key checks. 
  if (key == CODED)
  {
    // Checks if the key Pressed is the right arrow key
    //If pressed it will display the next tweet in the list.
    if (keyCode == RIGHT)
    {
      //switches the tweet to the next tweet
      if (displayNum+1 < tweetsStored)
      {
        displayNum += 1;
        changedTweet = true;
        tweet = tweets.get(displayNum);
        name = usernames.get(displayNum);
        currentTweet = str(displayNum+1);
      }
              //if you try to select a tweet that doesn't exist it fills in the items
              //redudent after requesting every tweet at once, can be implemented again if
              //loading a stream of tweets is required
              //      else if (changedTweet == true && tweetsStored != 100)
              //      {
              //        changedTweet = false;
              //        displayNum += 1;
              //        tweet = "Loading...";
              //        name = "Loading...";
              //        currentTweet = "N/A";
              //      }
      //if the next tweet is empty it will replace the text with a message asking for them to try another search
      else if (displayNum+1 == tweetsStored)
      {
        tweet = "Try another search?";
        name = "Last tweet";
        currentTweet = str(tweetsStored);
      }
    }
    //Checks if the key pressed is the left arrow key.
    //switches to the perviouse tweet, if its 0 it defaults to the first tweet.
    if (keyCode == LEFT)
    {
      displayNum -= 1;

      if (displayNum < 0)
      {
        displayNum = 0;
      }
      else
      {
        changedTweet = true;
        tweet = tweets.get(displayNum);
        name = usernames.get(displayNum);
      }
      currentTweet = str(displayNum+1);
    }
  }
}

////////////////////////////***Check Twitter Function***////////////////////////////
////////////////////////////***Check Twitter Function***////////////////////////////
////////////////////////////***Check Twitter Function***////////////////////////////

//checks twitter and uses and changes the twitter search depending on the locationBoolean
void checkTwitter()
{
  if (searchSent == false && stopTweets == false)
  {
    println("search Sent");
    searchSent = true;
    if (locationBoolean == false)
    {
      twitterParams.put("q", "-RT%20"+searchWord+hashtags+mood);
      client.GET(search, twitterParams);
    }
    if (locationBoolean == true)
    {
      println("searching usa using "+"-RT%20"+searchWord+hashtagsUsa+mood);
      twitterParams.put("q", "-RT%20"+mood+searchWord+hashtagsUsa);
      client.GET(search, twitterParams);
    }
  }
  //Resets the seacrch if a search has already been started.
  else
  {
    resetSearch();
  }
}

////////////////////////////***Resets Search Function***////////////////////////////
////////////////////////////***Resets Search Function***////////////////////////////
////////////////////////////***Resets Search Function***////////////////////////////

//resets most things back to defaults.
void resetSearch()
{
  stopTweets = false;
  usernames.clear();
  tweets.clear();
  tweet = "Waiting...";
  name = "Waiting...";
  currentTweet = "0";
  tweetsStored = 0;
  displayNum = 0;
  resetBubbles();
  checkTwitter();
}

////////////////////////////***CapCity Check Hasgtags Function***////////////////////////////
////////////////////////////***CapCity Check Hasgtags Function***////////////////////////////
////////////////////////////***CapCity Check Hasgtags Function***////////////////////////////


void checkHashtags(String checkText)
{
  //takes the tweet (checkText) and checks it againest
  //each Instances of CapClass
  hashtagText = checkText;
  
  //Depending on locationBoolean it will run through the approate arrayList 
  //It will then check the check() function in each item of the array list.
  if (locationBoolean == false)
  {
    //https://www.processing.org/reference/ArrayList.html
    for (int i = europeList.size()-1;  i >=0; i--)
    {
      CapCity cap = europeList.get(i);
      cap.check();
    }
  }
  if (locationBoolean == true);
  {
    for (int i = usaList.size()-1;  i >=0; i--)
    {
      CapCity cap = usaList.get(i);
      cap.check();
    }
  }
}


////////////////////////////***CapCity Class Heatmap Function***////////////////////////////
////////////////////////////***CapCity Class Heatmap Function****////////////////////////////
////////////////////////////***CapCity Class Heatmap Function****////////////////////////////

//function with all the bubbles for the map. 
void heatMap()
{
  //Depending on locationBoolean it will run through the approate arrayList 
  //It will then check the update() function in each item of the array list.
  //
  if (locationBoolean == false)
  {
    //updates and displays every bubble on the map
    for (int i = europeList.size()-1;  i >=0; i--)
    {
      CapCity cap = europeList.get(i);
      cap.update();
    }
  }
  if (locationBoolean == true)
  {
    for (int i = usaList.size()-1;  i >=0; i--)
    {
      CapCity cap = usaList.get(i);
      cap.update();
    }
  }
}

////////////////////////////***CapCity Class Reset Bubbles Function***////////////////////////////
////////////////////////////***CapCity Class Reset Bubbles Function****////////////////////////////
////////////////////////////***CapCity Class Reset Bubbles Function****////////////////////////////


void resetBubbles()
{
  //Will run through the approate arrayList 
  //It will then start the resetSize() function in each item of the array list.
  //resets the bubbles on both maps. 
  for (int i = europeList.size()-1;  i >=0; i--)
  {
    CapCity cap = europeList.get(i);
    cap.resetSize();
  }

  for (int i = usaList.size()-1;  i >=0; i--)
  {
    CapCity cap = usaList.get(i);
    cap.resetSize();
  }
}

////////////////////////////***CapCity Class***////////////////////////////
////////////////////////////***CapCity Class****////////////////////////////
////////////////////////////***CapCity Class****////////////////////////////


//class that increases the size of the bubbles
//function one checks if the hashtag was found and increases the size if ture
//Function two updates the size of the bubble.
class CapCity
{
  //variables for use in the other functions
  float addThis, growth;
  int size, x, y; 
  String hashTag, city;
  //constructor
  CapCity(int cityX, int cityY, int citySize, String cityHash, String cityName)
  {
    x = cityX;
    y = cityY;
    size = citySize;
    hashTag = cityHash;
    city = cityName;
  }
  //Function that will reset the cirlces sizes. 
  void resetSize()
  {
    size = 0;
    growth = 0;
  }
  //function that will check with regEx if any of the tweets contain a hashtag.
  void check()
  {
    match = match(hashtagText, "(?i)("+hashTag+")");
    if (match != null)
    {
      size += 2;
      //println(city + " = " + size);
    }
    else
    {
    }
  }
  //function that must be in the draw loop so it can update the bubbles.
  //the funcion will then take the size given from the check function 
  // and use it to grow the size of the bubbles on the map.
  void update()
  {
    //animations the growing of the bubbles. 
    if (stopTweets == true)
    {
      if (size > growth)
      {
        growth += size * 0.04;
      }
      else if (size < growth)
      {
        growth = size;
      }
    }
    //default values for bubble colours
    fill(255, 20, 20, 180);
    stroke(100, 20, 20);
    ellipse(mapX+x, mapY+y, growth, growth);
  }
}

