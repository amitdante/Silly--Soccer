local composer = require( "composer" )

local scene = composer.newScene()

local myData = require("Data")

local nKid
local bGirl
local nGirl
local gMan
local bKid
local oWoman
local bg
local bgRect
local selPlayer
local nextButton
local prevButton

-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function bGirlTap( event )
    myData.index = 1 
    bGirl:setFillColor( 0.5,0.5,0.5 )
end

local function nGirlTap( event )
    myData.index = 2 
    nGirl:setFillColor( 0.5,0.5,0.5 )
   
end
local function nKidTap( event )
    myData.index = 3  
    nKid:setFillColor( 0.5,0.5,0.5 )
  
end
local function bKidTap( event )
    myData.index = 4 
    bKid:setFillColor( 0.5,0.5,0.5 )
   
end
local function gManTap( event )
    myData.index = 5 
    gMan:setFillColor( 0.5,0.5,0.5 )
  
end
local function oWomanTap( event )
    myData.index = 6 
    oWoman:setFillColor( 0.5,0.5,0.5 )
   
end
----------------------------------------------------------------------------------
local function bGirlTap2( event )
    myData.index2 = 1
    bGirl2:setFillColor( 0.5,0.5,0.5 )
   
end

local function nGirlTap2( event )
    myData.index2 = 2 
    nGirl2:setFillColor( 0.5,0.5,0.5 )
 
end
local function nKidTap2( event )
    myData.index2 = 3
    nKid2:setFillColor( 0.5,0.5,0.5 )
    
end
local function bKidTap2( event )
    myData.index2 = 4
    bKid2:setFillColor( 0.5,0.5,0.5 )
   
end
local function gManTap2( event )
    myData.index2 = 5 
    gMan2:setFillColor( 0.5,0.5,0.5 )
   
end
local function oWomanTap2( event )
    myData.index2 = 6
    oWoman2:setFillColor( 0.5,0.5,0.5 )
   
end
local function nextButtonTap( event )
    if(myData.sound) then
    audio.play( myData.menuSound )
end
    composer.gotoScene( "Groundselection"  )
end

-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    nextButton = display.newImage(  "Assets/Menu/next.png"  )
    nextButton.x = display.contentCenterX 
    nextButton.y =display.contentCenterY + 125
    nextButton:scale( 0.12, 0.12 )
    nextButton:addEventListener( "tap", nextButtonTap )


    selPlayer = display.newText(  "CHOOSE PLAYER", display.contentWidth/2, display.contentHeight/2 - 130 , "Demolition.ttf",20 )
    selPlayer:setFillColor( 0.2,0,1 )

    local player1 = display.newText(  "PLAYER 1", display.contentWidth/2, display.contentHeight/2 - 85 , "Demolition.ttf",12 )
    player1:setFillColor( 0,0.3,1 )

    local player2 = display.newText(  "PLAYER 2", display.contentWidth/2, display.contentHeight/2 +18 , "Demolition.ttf",12 )
    player2:setFillColor( 0,0.3,1 )

    bg = display.newImage(  "Assets/Ground/BG1.png"  )
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    bgRect = display.newRect(  0, display.contentCenterY - 40, display.contentWidth*3, 60 )
    bgRect:setFillColor( 0,1,0.5 )
    bGirl = display.newImage(  "Assets/Characters/BlondeGirl.png" ) 
    bGirl.x = 20
    bGirl.y = display.contentCenterY-40
    bGirl:addEventListener( "tap",bGirlTap)

    nGirl = display.newImage(  "Assets/Characters/Girl.png" ) 
    nGirl.x = bGirl.x + 90
    nGirl.y = display.contentCenterY-40
    nGirl:addEventListener( "tap",nGirlTap)

    nKid = display.newImage(  "Assets/Characters/NerdKid.png" ) 
    nKid.x = bGirl.x + 160
    nKid.y = display.contentCenterY-40
    nKid:addEventListener( "tap",nKidTap)

    bKid = display.newImage(  "Assets/Characters/BlondeKid.png" ) 
    bKid.x = bGirl.x + 270
    bKid.y = display.contentCenterY-40
    bKid:addEventListener( "tap",bKidTap)

    gMan = display.newImage(  "Assets/Characters/GrumpyMan.png" ) 
    gMan.x = bGirl.x + 360
    gMan.y = display.contentCenterY-40
    gMan:addEventListener( "tap",gManTap)

    oWoman = display.newImage(  "Assets/Characters/OldWoman.png" ) 
    oWoman.x = bGirl.x + 450
    oWoman.y = display.contentCenterY-40
    oWoman:addEventListener( "tap",oWomanTap)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    bgRect2 = display.newRect(  0, display.contentCenterY +60, display.contentWidth*3, 60 )
    bgRect2:setFillColor( 0,1,0.5 )
    bGirl2 = display.newImage(  "Assets/Characters/BlondeGirl.png" ) 
    bGirl2.x = 20
    bGirl2.y = display.contentCenterY + 60
    bGirl2:addEventListener( "tap",bGirlTap2)

    nGirl2 = display.newImage(  "Assets/Characters/Girl.png" ) 
    nGirl2.x = bGirl.x + 90
    nGirl2.y = display.contentCenterY + 60
    nGirl2:addEventListener( "tap",nGirlTap2)

    nKid2 = display.newImage(  "Assets/Characters/NerdKid.png" ) 
    nKid2.x = bGirl.x + 160
    nKid2.y = display.contentCenterY + 60
    nKid2:addEventListener( "tap",nKidTap2)

    bKid2 = display.newImage(  "Assets/Characters/BlondeKid.png" ) 
    bKid2.x = bGirl.x + 270
    bKid2.y = display.contentCenterY +60
    bKid2:addEventListener( "tap",bKidTap2)

    gMan2 = display.newImage(  "Assets/Characters/GrumpyMan.png" ) 
    gMan2.x = bGirl.x + 360
    gMan2.y = display.contentCenterY +60
    gMan2:addEventListener( "tap",gManTap2)

    oWoman2 = display.newImage(  "Assets/Characters/OldWoman.png" ) 
    oWoman2.x = bGirl.x + 450
    oWoman2.y = display.contentCenterY +60
    oWoman2:addEventListener( "tap",oWomanTap2)

    sceneGroup:insert(bg)
    sceneGroup:insert(  nextButton  )
    sceneGroup:insert(selPlayer)
    sceneGroup:insert(player1)
    sceneGroup:insert(player2)
    sceneGroup:insert(bgRect)
    sceneGroup:insert(oWoman)
    sceneGroup:insert(gMan)
    sceneGroup:insert(bKid)
    sceneGroup:insert( nKid  )
     sceneGroup:insert( bGirl  )
    sceneGroup:insert(  nGirl  )

    sceneGroup:insert(bgRect2)
    sceneGroup:insert(oWoman2)
    sceneGroup:insert(gMan2)
    sceneGroup:insert(bKid2)
    sceneGroup:insert( nKid2  )
     sceneGroup:insert( bGirl2  )
    sceneGroup:insert(  nGirl2 )
end
   

-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        bGirl:setFillColor( 1,1,1 )
        bGirl2:setFillColor( 1,1,1 )
        nGirl:setFillColor( 1,1,1 )
        nGirl2:setFillColor( 1,1,1 )
        bKid2:setFillColor( 1,1,1 )
        bKid:setFillColor( 1,1,1)
        gMan:setFillColor( 1,1,1 )
        gMan2:setFillColor( 1,1,1 )
        oWoman2:setFillColor( 1,1,1 )
        oWoman:setFillColor( 1,1,1 )
        nKid2:setFillColor( 1,1,1)
        nKid:setFillColor( 1,1,1)
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