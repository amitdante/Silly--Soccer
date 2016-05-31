local composer = require( "composer" )

local scene = composer.newScene()

local myData = require ("Data")
local menu = require("Menu")

local resume

local mainMenu

local bg
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function mainMenuFunction( event )
    if(myData.sound) then
    audio.play( myData.menuSound )
end
    myData.p1Ready = false
    myData.p2Ready = false
    myData.gameStarted = false
    composer.gotoScene( "Menu"  )
end

-- "scene:create()"
function scene:create( event )
    local function resumeFunction( event )
        if(myData.sound) then
        audio.play( myData.menuSound )
    end
   composer.hideOverlay( ) 

end

    local sceneGroup = self.view
    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    resume = display.newImage(  "Assets/Menu/Resumebutton.png" )
    resume.x = display.contentCenterX
    resume.y = display.contentCenterY -65
    resume:addEventListener("tap" , resumeFunction)
    mainMenu = display.newImage(  "Assets/Menu/Menubutton.png"  )
    mainMenu.x = display.contentCenterX
    mainMenu.y = display.contentCenterY +30
    mainMenu:addEventListener( "tap", mainMenuFunction )
    bg = display.newImage(  "Assets/Menu/Overlay.png" )
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY 
    bg:scale( 1, 1.02 )

    sceneGroup:insert(  bg  )
    sceneGroup:insert(  resume  )
    sceneGroup:insert(mainMenu)
    

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
        event.parent:resumeGame()
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