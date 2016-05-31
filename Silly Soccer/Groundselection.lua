local composer = require( "composer" )

local scene = composer.newScene()
local myData = require("Data" )
local menu = require("Menu")

local button1 , button1Text
local button2 , button2Text

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called
-- -----------------------------------------------------------------------------------------------------------------

-- Local forward references should go here

-- -------------------------------------------------------------------------------
local function button1Tap( event )
    button1:removeEventListener( "tap", button1Tap )
    myData.groundIndex = 1
    audio.play( myData.menuSound )
    if(myData.loc)then
        composer.gotoScene( "Game" )
    end
    if(myData.loc == false)then
    if(myData.player==2)then
        myData.gameStarted = false
        menu.player2Ready()
    elseif(myData.player==1)then
        myData.gameStarted = false
        menu.player1Ready()
    end
end
end 

local function button2Tap( event )
    button2:removeEventListener( "tap", button2Tap )
    myData.groundIndex = 2
    audio.play( myData.menuSound )
   if(myData.loc)then
        composer.gotoScene( "Game" )
    end
    if(myData.loc == false)then
    if(myData.player==2)then
        myData.gameStarted = false
        menu.player2Ready()
    elseif(myData.player==1)then
        myData.gameStarted = false
        menu.player1Ready()
    end
end
end 

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    local bg = display.newImage(  "Assets/Ground/BG1.png" )
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    local text = display.newText(  "CHOOSE GROUND", display.contentWidth/2, display.contentHeight/2 - 100 , "Demolition.ttf",20 )
    text:setFillColor( 0.5,0.5,1 )
    button1 = display.newRoundedRect(  display.contentWidth/2, display.contentHeight/2-30, 150, 50, 20 )
    button1:setFillColor( 1,0.5,0)
    button1Text = display.newText(  "GRASS", display.contentWidth/2,display.contentHeight/2-30,"Demolition.ttf")
    button1Text:setFillColor( 0.1,0.9,0.1 )
    
    button2 = display.newRoundedRect(  display.contentWidth/2, display.contentHeight/2+50, 150, 50, 20 )
    button2:setFillColor( 1,0.7,0)
    button2Text = display.newText(  "DUNGEON", display.contentWidth/2,display.contentHeight/2+50,"Demolition.ttf")
    button2Text:setFillColor( 0.1,0.9,0.5 )
    

    sceneGroup:insert(bg)
    sceneGroup:insert(  button1  )
    sceneGroup:insert(  button2  )
    sceneGroup:insert(button1Text)
    sceneGroup:insert(button2Text)
    sceneGroup:insert(text)

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen)
        button1:addEventListener( "tap", button1Tap )
        button2:addEventListener( "tap", button2Tap )
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen
        -- Insert code here to make the scene come alive
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen)
        -- Insert code here to "pause" the scene
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view
    -- Insert code here to clean up the scene
    -- Example: remove display objects, save state, etc.
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene