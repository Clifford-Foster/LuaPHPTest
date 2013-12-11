----------------------------------------------------
-- JSON test application
-- Clifford Foster
----------------------------------------------------

----------------------------------------------------
-- Basic configuration and housekeeping
----------------------------------------------------
display.setDefault( "anchorX", 0.5 )
display.setDefault( "anchorY", 0.5 )
display.setStatusBar(display.HiddenStatusBar)

----------------------------------------------------
-- Global Variables
----------------------------------------------------
_H = display.contentHeight
_W = display.contentWidth

----------------------------------------------------
-- Required libraries
----------------------------------------------------
local sqlite3 = require ("sqlite3")
local json = require ("json")

----------------------------------------------------
-- General purpose variables
----------------------------------------------------
local decodedData 
local decodedJSON
local myNewData 

----------------------------------------------------
-- Save data function
----------------------------------------------------
local function SaveData()
  -- save new data to a sqlite file
  -- open SQLite database, if it doesn't exist, create database
  local path = system.pathForFile("movies.sqlite", system.DocumentsDirectory)
  db = sqlite3.open( path ) 
  print(path)

  -- setup the table if it doesn't exist
  local tablesetup = "CREATE TABLE IF NOT EXISTS mymovies (id INTEGER PRIMARY KEY, movie, year);"
  db:exec( tablesetup )
  print(tablesetup)

  -- save  data to database
  local counter = 1
  local index = "movie"..counter
  local movie = decodedData[index]
  print(movie[1])

  while (movie ~=nil) do
    local tablefill ="INSERT INTO mymovies VALUES (NULL,'" .. movie["Movie"] .. "','" .. movie["Year"] .."');"
    print(tablefill)
    db:exec( tablefill )
    counter=counter+1
    index = "movie"..counter
    movie = decodedData[index]
  end      

  --Everything is saved to SQLite database; close database
  db:close()

  --Load database contents to screen
  -- open database  
  local path = system.pathForFile("movies.sqlite", system.DocumentsDirectory)
  db = sqlite3.open( path ) 
  print(path)
  --print all the table contents
  local sql = "SELECT * FROM mymovies"
  for row in db:nrows(sql) do
    local text = row.movie.." "..row.year
    local t = display.newText(text, 30, 20 * row.id, native.systemFont, 12)
    t.anchorX = 0
    t:setFillColor(255,255,255)
  end    
  db:close()

end

local function networkListener( event )
  if ( event.isError ) then
    print( "Network error!")
  else
    myNewData = event.response
    print ("From server: "..myNewData)
    decodedJSON = (json.decode( myNewData))
    decodedData = decodedJSON["data"]
    --print(decodedData["movie1"]["id"])
    SaveData()
  end
end

--network.request( "http://localhost/phpGetMovies.php", "GET", networkListener )
network.request( "http://localhost/index.php/api/?method=retrieve&format=json", "GET", networkListener )