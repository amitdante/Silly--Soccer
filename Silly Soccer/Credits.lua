local composer = require( "composer" )

local scene = composer.newScene()

local myData = require( "Data")

local bg
local nextButton

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function nextButtonTap( )
    audio.play( myData.menuSound )
    composer.gotoScene( "Menu"  )
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    bg = display.newRect(  0, 0, display.contentWidth*2.5, display.contentHeight*2.5)
    bg:setFillColor( 0.2,0.4,0.2 )
    local credits = display.newText(  "CREDITS", display.contentCenterX, display.contentCenterY-130 , "Demolition.ttf" ,18 )
    credits:setFillColor( 0.1,0.9,0.3 )
    local programming = display.newText(  "Programming By:",display.contentCenterX-180, display.contentCenterY-80, "space.ttf" ,30)
    programming:setFillColor( 0,0.2,0.2 )
    local graphics = display.newText(  "Graphics By:",display.contentCenterX-200, display.contentCenterY-30 , "space.ttf" ,30)
    graphics:setFillColor( 0,0.2,0.2 )
    local amit = display.newText(  "AMIT DHILLON (DANTE)",display.contentCenterX+50, display.contentCenterY-80, "space.ttf" ,30)
    local ankit = display.newText(  "ANKIT DHILLON",display.contentCenterX, display.contentCenterY-30, "space.ttf" ,30)
    local instr = display.newText(  "INSTRUCTIONS",display.contentCenterX, display.contentCenterY+20, "space.ttf" ,20)
    instr:setFillColor( 0.9,1,0.2 )

    local instrText = [[   Hold The Rotation Buttons To Rotate Your Player.
    If You Collide With Anything, You Will Be Headed Back.
    Hit the Ball to Move it, WHoever Scores More 
                                                         WINS!!!]]

    --------------------------------------------------------    
    local instruction = display.newText( instrText,display.contentCenterX  , display.contentCenterY+80, "space" ,18)

    nextButton = display.newImage(  "Assets/Menu/next.png"  )
    nextButton.x = display.contentCenterX+200 
    nextButton.y =display.contentCenterY + 125
    nextButton:scale( 0.12, 0.12 )
    nextButton.Rotation = 90
    nextButton:addEventListener( "tap", nextButtonTap )

    

    sceneGroup:insert(  bg  )
    sceneGroup:insert( credits  )
    sceneGroup:insert(programming)
    sceneGroup:insert(graphics)
    sceneGroup:insert(amit)
    sceneGroup:insert(ankit)
    sceneGroup:insert(instr)
    sceneGroup:insert(instruction)
    sceneGroup:insert(nextButton)
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
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