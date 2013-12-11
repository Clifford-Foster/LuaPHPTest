----------------------------------------------------
-- Test application
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
-- Load audio
----------------------------------------------------
local music = audio.loadStream("sounds/music.mp3") -- Load background music
audio.play(music, {loops =- 1})

----------------------------------------------------
-- Intro
----------------------------------------------------
local background = display.newImageRect("images/clouds.png",480,320)
background.x = _W/2
background.y = _H/2

local function removeBalloon(obj)
	obj:removeSelf( )
	obj = nil
end

local balloon = display.newImageRect("images/balloon.png",25,25)
balloon.x = _W/2
balloon.y = _H/2
balloon.xScale = 8
balloon.yScale = 8
balloon.alpha = 0

function balloon:touch(e)
	removeBalloon(self)
end

balloon:addEventListener( "touch", balloon )

--transition.to(balloon, {time = 2000, alpha = 1, xScale = 1, yScale = 1, onComplete = removeBalloon})
transition.to(balloon, {time = 2000, alpha = 1, xScale = 1, yScale = 1})

----------------------------------------------------
-- Game functions
----------------------------------------------------
local function startGame()
end

----------------------------------------------------
-- Main Game Loop
----------------------------------------------------
