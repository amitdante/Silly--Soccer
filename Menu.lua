local composer = require( "composer" )

local scene = composer.newScene()
local myData = require("Data" )

local localButton , numPlayers, server, client , isClient , isServer
local serverReceived, clientReceived,sendFullFrame,sendFullFrameTimer, playerDropped, connectionAttemptFailed, isServer,isClient,autolanConnected
local multiPlayerButton
local silly
local soccer
local numPlayers = 0
local numberOfServers = 0
local spawnMenu
local clients = {}
local menuGroup = display.newGroup( )
local bg
local creditsButton
local soundOn
local soundOff
local comingSoon


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------


local function multiPlayerButtonTap( event )
    if(myData.sound) then
        if(myData.sound) then
    audio.play( myData.menuSound )
end
end
    comingSoon.isVisible = true
    timer.performWithDelay( 1500, function ()
        comingSoon.isVisible = false
    end ,1)
end




local function localButtonTap( event )
    localButton:setFillColor( 0.5,0.5,0.5 )
    timer.performWithDelay( 1000, function (  )
        localButton:setFillColor( 1,1,1 )
    end,1)
    if(myData.sound) then
    audio.play( myData.menuSound )
end
    composer.gotoScene( "Characterselection")
end


local function creditsButtonTap( event )
    if(myData.sound) then
    audio.play( myData.menuSound )
end
    composer.gotoScene( "Credits"  )
end

local function soundOnTap( event )
    audio.pause( myData.bgMusic )
    myData.sound = false
    soundOff.isVisible = true
    soundOn.isVisible = false
end

local function soundOffTap( event )
    myData.sound =true
    audio.play( myData.bgMusic,{channel= 0 , loop = -1} )
    soundOn.isVisible = true
    soundOff.isVisible = false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    composer.removeHidden(  "Game" )
    myData.displayGroup.isVisible = false
    bg = display.newImage( "Assets/Menu/BG1.png" )
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg)

    comingSoon = display.newText(  "COMING SOON", display.contentCenterX, display.contentCenterY-100 ,  "Demolition.ttf" ,20)
    comingSoon.isVisible = false
    comingSoon:setFillColor( 1,0,0 )

    creditsButton = display.newImage( "Assets/Menu/credits.png" )
    creditsButton.x = display.contentCenterX + 250
    creditsButton.y = display.contentCenterY -120
    creditsButton:scale( 1.2, 1.2 )
    creditsButton:addEventListener( "tap", creditsButtonTap )

    soundOn = display.newImage(  "Assets/Menu/volon.png" )
    soundOn.x = display.contentCenterX - 250
    soundOn.y = display.contentCenterY - 120
    soundOn:addEventListener( "tap", soundOnTap )

    soundOff = display.newImage(  "Assets/Menu/voloff.png" )
    soundOff.x = display.contentCenterX - 250
    soundOff.y = display.contentCenterY - 120
    soundOff:addEventListener( "tap", soundOffTap )
    soundOff.isVisible = false

    localButton = display.newImage(  "Assets/Menu/local.png" )
    localButton.id= "localButton"
    localButton.x = display.contentCenterX-90
    localButton.y = display.contentCenterY+55
    sceneGroup:insert(localButton)
    localButton:addEventListener( "tap", localButtonTap )

    multiPlayerButton = display.newImage(  "Assets/Menu/multiplayer.png"  )
    multiPlayerButton.id= "multiPlayerButton"
    multiPlayerButton.x = display.contentCenterX+90
    multiPlayerButton.y = display.contentCenterY+55
    sceneGroup:insert(multiPlayerButton)
    multiPlayerButton:addEventListener( "tap", multiPlayerButtonTap )

    silly = display.newImage(  "Assets/Menu/silly.png" )
    silly.x = display.contentCenterX
    silly.y = display.contentCenterY - 70

    soccer = display.newImage(  "Assets/Menu/soccer.png"  )
    soccer.x = display.contentCenterX
    soccer.y = display.contentCenterY -20


    sceneGroup:insert(silly)
    sceneGroup:insert(soccer)
    sceneGroup:insert(  creditsButton  )
    sceneGroup:insert(soundOff)
    sceneGroup:insert(soundOn)
    sceneGroup:insert(comingSoon)


end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        audio.pause( myData.bgSound)
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc
        if(myData.sound) then
        audio.play( myData.bgMusic,{channel = 0, loops = -1} )
    end
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