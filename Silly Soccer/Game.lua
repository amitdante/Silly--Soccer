local composer = require( "composer" )

local scene = composer.newScene()

local physics = require("physics")

local myData = require("Data" )
local menu = require("Menu")

local rotateTimer1
local rotateTimer2
local rotateTimer3
local rotateTimer4
local pauseButton
local audioPlayed = false
local pauseTimer

physics.start( )
physics.setGravity(0,0)
--physics.setDrawMode( "hybrid" )


local function player1Mechanics( player)
    if(myData.pT) then
    player:setLinearVelocity(math.sin(math.rad(player.rotation)) * -myData.player1.speed, math.cos(math.rad(player.rotation)) * myData.player1.speed)
end
end


-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------

local function rotateClockwise( event )
    if (event.phase == "began") then
          event.target:setFillColor( 0.7,0.7,0.7 )
         display.getCurrentStage():setFocus(event.target, event.id)  -- set touch focus on this object
         event.target.hasFocus = true  -- remember that this object has the focus
             rotateTimer1 = timer.performWithDelay( 1, function( event )
                if(myData.pT) then
                    
        myData.player1.animation.rotation = myData.player1.animation.rotation + 5
        player1Mechanics(myData.player1.animation)
        if(myData.loc == false) then
        menu.player1Update()
    end

        
    end
    end,0)
         return true  -- indicate the event was handled
         
      elseif (event.target.hasFocus) then  -- this object is handling touches
          
         if (event.phase == "moved") then
        
         else  -- "ended" and "cancelled" phases
         myData.rotateClock:setFillColor( 1,1,1 )
         timer.cancel(rotateTimer1)
            display.getCurrentStage():setFocus(event.target, nil)  -- remove touch focus
            event.target.hasFocus = false  -- this object no longer has the focus
         end
         return true  -- indicate that we handled the touch and not to propagate it
 end   
end

local function rotateAntiClockwise( event )
if (event.phase == "began") then
          event.target:setFillColor( 0.7,0.7,0.7 )
         display.getCurrentStage():setFocus(event.target, event.id)  -- set touch focus on this object
         event.target.hasFocus = true  -- remember that this object has the focus
             rotateTimer2 = timer.performWithDelay( 1, function( event )
                if(myData.pT) then
        myData.player1.animation.rotation = myData.player1.animation.rotation - 5
        player1Mechanics(myData.player1.animation)
        if(myData.loc == false) then
        menu.player1Update()
    end
        
    end
    end,0)
         return true  -- indicate the event was handled
         
      elseif (event.target.hasFocus) then  -- this object is handling touches
          
         if (event.phase == "moved") then
        
         else  -- "ended" and "cancelled" phases
         myData.rotateAntiClock:setFillColor( 1,1,1 )
         timer.cancel(rotateTimer2)
            display.getCurrentStage():setFocus(event.target, nil)  -- remove touch focus
            event.target.hasFocus = false  -- this object no longer has the focus
         end
         return true  -- indicate that we handled the touch and not to propagate it
 end   
end

local function rotateClockwise2( event )
   if (event.phase == "began") then
         event.target:setFillColor( 0.7,0.7,0.7 ) 
         display.getCurrentStage():setFocus(event.target, event.id)  -- set touch focus on this object
         event.target.hasFocus = true  -- remember that this object has the focus
             rotateTimer3 = timer.performWithDelay( 1, function( event )
                if(myData.pT) then
        myData.player2.animation.rotation = myData.player2.animation.rotation + 5
        player1Mechanics(myData.player2.animation)
        if(myData.loc == false) then
        menu.player2Update()
    end
    end
    end,0)
         return true  -- indicate the event was handled
         
      elseif (event.target.hasFocus) then  -- this object is handling touches
          
         if (event.phase == "moved") then
        
         else  -- "ended" and "cancelled" phases
         myData.rotateClock2:setFillColor( 1,1,1 )
         timer.cancel(rotateTimer3)
            display.getCurrentStage():setFocus(event.target, nil)  -- remove touch focus
            event.target.hasFocus = false  -- this object no longer has the focus
         end
         return true  -- indicate that we handled the touch and not to propagate it
 end   
end

local function rotateAntiClockwise2( event )
   if (event.phase == "began") then
         event.target:setFillColor( 0.7,0.7,0.7 ) 
         display.getCurrentStage():setFocus(event.target, event.id)  -- set touch focus on this object
         event.target.hasFocus = true  -- remember that this object has the focus
             rotateTimer4 = timer.performWithDelay( 1, function( event )
                if(myData.pT) then
        myData.player2.animation.rotation = myData.player2.animation.rotation - 5
        player1Mechanics(myData.player2.animation)
        if(myData.loc == false) then
        menu.player2Update()
    end
    end
    end,0)
         return true  -- indicate the event was handled
         
      elseif (event.target.hasFocus) then  -- this object is handling touches
          
         if (event.phase == "moved") then
        
         else  -- "ended" and "cancelled" phases
         myData.rotateAntiClock2:setFillColor( 1,1,1 )
         timer.cancel(rotateTimer4)
            display.getCurrentStage():setFocus(event.target, nil)  -- remove touch focus
            event.target.hasFocus = false  -- this object no longer has the focus
         end
         return true  -- indicate that we handled the touch and not to propagate it
 end   
end


local function ballCollision( event)
    if(event.phase == "began") then
    if(event.other.id == "goal1") then
        if(myData.sound) then
        audio.play( myData.goalSound)
    end
        myData.score2 = myData.score2 + 1
        myData.score2Text.text = "P2: "..myData.score2
        timer.performWithDelay(1,function ( )
        myData.ball.animation.x = display.contentWidth/2
        myData.ball.animation.y = display.contentHeight/2
        end,1)
        composer.gotoScene( "Goal" )
        
        elseif(event.other.id == "goal2") then
            if(myData.sound) then
        audio.play( myData.goalSound)
    end
        myData.score1 = myData.score1 + 1
        myData.score1Text.text = "P1: "..myData.score1
        timer.performWithDelay(1,function ( )
        myData.ball.animation.x = display.contentWidth/2
        myData.ball.animation.y = display.contentHeight/2
        end,1)
        composer.gotoScene( "Goal" )

      end  
    end
end


local function colliderSetter( event )
    event.target.collided = false
end

local function playerCollision( event )
   player1Mechanics(event.target)
    if (event.other.id == "ball") then
        if(audioPlayed == false) then
            if(myData.sound) then
        audio.play( myData.kick , {duration = 100} )
    end
        audioPlayed = true
        timer.performWithDelay( 200, function (  )
            audioPlayed = false
        end , 1)
    end
        if(myData.pT) then
        event.other:applyForce( math.sin(math.rad(event.target.rotation)) * -0.25, math.cos(math.rad(event.target.rotation)) * 0.25, event.other.x, event.other.y )
        player1Mechanics(event.target)
    end
    elseif(event.target.collided == false) then
        event.target.collided = true
        player1Mechanics(event.target)
        if(myData.pT) then
        event.target.rotation = event.target.rotation + 180
    end
    player1Mechanics(event.target)
    timer.performWithDelay( 1000, function()
        return colliderSetter(event)
    end,1)
end
end

local function playerCollisionTimerFunction(event )
    timer.performWithDelay( 1,function()
        return playerCollision(event)
    end,1 )
    
end
local function pauseGame(  )
    if(myData.gamePaused == true)then
    audio.pause( myData.bgSound)
    physics.pause( )
    myData.player1.animation:setLinearVelocity( 0, 0 )
    myData.player2.animation:setLinearVelocity( 0, 0 )
    myData.player2.animation:pause( )
    myData.player1.animation:pause( )
    myData.ball.animation:pause( )
end
end
local function pauseButtonTap( event )
    myData.gamePaused = true
    menu.pauseGame();
    audio.pause( myData.bgSound)
    if(myData.sound) then
    audio.play( myData.menuSound )
end
    physics.pause( )
    myData.player1.animation:setLinearVelocity( 0, 0 )
    myData.player2.animation:setLinearVelocity( 0, 0 )
    myData.player2.animation:pause( )
    myData.player1.animation:pause( )
    myData.ball.animation:pause( )
    composer.showOverlay( "Pause" ,{ isModal = true } )
end
function scene:resumeGame( )
    menu.resumeGame()
    myData.gamePaused = false
    myData.player2.animation:play( )
    myData.player1.animation:play( )
    myData.ball.animation:play( )
    if(myData.sound) then
    audio.play( myData.bgSound)
end
    physics.start( )
    player1Mechanics(myData.player1.animation)
    player1Mechanics(myData.player2.animation)
end

local function resetGameState(  )
    physics.stop( )

end
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    pauseButton = display.newImage(  "Assets/Menu/Pausebutton.png" )
    pauseButton.x = 470
    pauseButton.y = 20
    pauseButton:addEventListener( "tap", pauseButtonTap )
    

    sceneGroup:insert(myData.ball.animation)
    
    sceneGroup:insert(myData.rotateClock)
    sceneGroup:insert(myData.rotateAntiClock)
    sceneGroup:insert(myData.rotateClock2)
    sceneGroup:insert(myData.rotateAntiClock2)
    sceneGroup:insert(myData.wall1)
    sceneGroup:insert(myData.wall2)
    sceneGroup:insert(myData.wall3)
    sceneGroup:insert(myData.wall4)
    sceneGroup:insert(myData.wall5)
    sceneGroup:insert(myData.wall6)
    sceneGroup:insert(myData.goal1)
    sceneGroup:insert(myData.goal2)
    sceneGroup:insert(myData.score1Text)
    sceneGroup:insert(myData.score2Text)
    sceneGroup:insert(pauseButton)
   

    

    
    myData.player2.animation:addEventListener( "collision", playerCollisionTimerFunction )
    myData.ball.animation:addEventListener( "collision", ballCollision )
    myData.rotateClock:addEventListener( "touch", rotateClockwise )
    myData.rotateAntiClock:addEventListener( "touch", rotateAntiClockwise )
    myData.rotateClock2:addEventListener( "touch", rotateClockwise2 )
    myData.rotateAntiClock2:addEventListener( "touch", rotateAntiClockwise2 )

   

end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase
    pauseTimer = timer.performWithDelay(500,pauseGame,-1)
    myData.pT = true

    if ( phase == "will" ) then
        
    myData.score1Text.text = "P1: "..myData.score1
    myData.score2Text.text = "P2: "..myData.score2

    if(myData.groundIndex == 1) then
        myData.ground = display.newImage( "Assets/Ground/BG1.png" )
    elseif(myData.groundIndex ==2) then
        myData.ground = display.newImage( "Assets/Ground/BG2.png" )
    end

    if(myData.player==1)then
        myData.rotateClock2.isVisible = false
        myData.rotateAntiClock2.isVisible = false
        myData.rotateClock.isVisible = true
        myData.rotateAntiClock.isVisible = true
    elseif(myData.player==2)then
        myData.rotateClock.isVisible = false
        myData.rotateAntiClock.isVisible = false
        myData.rotateClock2.isVisible = true
        myData.rotateAntiClock2.isVisible = true
    end



    if( myData.index == 1 ) then
        myData.player1.animation = display.newSprite(myData.displayGroup, myData.BGirl ,myData.player1.sequenceData )
    elseif( myData.index == 2 ) then
        myData.player1.animation = display.newSprite(myData.displayGroup, myData.NGirl ,myData.player1.sequenceData )
    elseif( myData.index == 3 ) then
        myData.player1.animation = display.newSprite(myData.displayGroup, myData.NKid ,myData.player1.sequenceData )
    elseif( myData.index == 4 ) then
        myData.player1.animation = display.newSprite(myData.displayGroup, myData.BKid ,myData.player1.sequenceData )
    elseif( myData.index == 5 ) then
        myData.player1.animation = display.newSprite(myData.displayGroup, myData.GMan ,myData.player1.sequenceData )
    elseif( myData.index == 6 ) then
        myData.player1.animation = display.newSprite(myData.displayGroup, myData.OWoman ,myData.player1.sequenceData )
    end

    if( myData.index2 == 1 ) then
        myData.player2.animation = display.newSprite(myData.displayGroup, myData.BGirl ,myData.player1.sequenceData )
    elseif( myData.index2 == 2 ) then
        myData.player2.animation = display.newSprite(myData.displayGroup, myData.NGirl ,myData.player1.sequenceData )
    elseif( myData.index2 == 3 ) then
        myData.player2.animation = display.newSprite(myData.displayGroup, myData.NKid ,myData.player1.sequenceData )
    elseif( myData.index2 == 4 ) then
        myData.player2.animation = display.newSprite(myData.displayGroup, myData.BKid ,myData.player1.sequenceData )
    elseif( myData.index2 == 5 ) then
        myData.player2.animation = display.newSprite(myData.displayGroup, myData.GMan ,myData.player1.sequenceData )
    elseif( myData.index2 == 6 ) then
        myData.player2.animation = display.newSprite(myData.displayGroup, myData.OWoman ,myData.player1.sequenceData )
    end

    sceneGroup:insert(myData.ground)
    myData.ground:toBack( )
     myData.ground.x = display.contentWidth/2
    myData.ground.y = display.contentHeight/2
    sceneGroup:insert( myData.player2.animation )
    myData.player2.animation:addEventListener( "collision", playerCollisionTimerFunction )
    sceneGroup:insert( myData.player1.animation )
    myData.player1.animation:addEventListener( "collision", playerCollisionTimerFunction )

    physics.start( )
    physics.setGravity(0,0)

    physics.addBody( myData.ball.animation, "dynamic", {bounce = 1.5 , friction = 0 , radius = 7} )
    physics.addBody( myData.wall1, "static" )
    physics.addBody( myData.wall2, "static" )
    physics.addBody( myData.wall3, "static" )
    physics.addBody( myData.wall4, "static" )
    physics.addBody( myData.wall5, "static" )
    physics.addBody( myData.wall6, "static" )
    physics.addBody( myData.goal1, "static" )
    physics.addBody( myData.goal2, "static" )
    physics.addBody( myData.player1.animation, "dynamic" , { radius = 16 })
    physics.addBody( myData.player2.animation, "dynamic", {radius = 16} )
    myData.ball.animation.isBullet = true
    if(myData.sound) then
    audio.play( myData.whistleSound,{duration = 1000} )
    end

    if (rotateTimer1) then
    timer.cancel( rotateTimer1 )
    end
    if (rotateTimer2) then
    timer.cancel( rotateTimer2 )
    end
    if (rotateTimer3) then
    timer.cancel( rotateTimer3 )
    end
    if (rotateTimer4) then
    timer.cancel( rotateTimer4 )
    end
    
    
    myData.ball.animation.linearDamping = 10
    myData.ball.animation.angularDamping = 10
    myData.ball.animation.x = display.contentWidth/2
    myData.ball.animation.y = display.contentHeight/2

    myData.player1.animation.angularDamping = 100
    myData.player1.animation.rotation = 180
    myData.player1.animation.x= display.contentWidth/2
    myData.player1.animation.y = display.contentHeight/2 + 110
    myData.player1.animation.collided = false
    

    myData.player2.animation.angularDamping = 100
    myData.player2.animation.rotation = 0
    myData.player2.animation.x =  display.contentWidth/2
    myData.player2.animation.y = display.contentHeight/2-110
    myData.player2.animation.collided = false
    
    player1Mechanics(myData.player1.animation)
    player1Mechanics(myData.player2.animation)
    myData.player1.animation:play()
    myData.player2.animation:play()
    myData.ball.animation:play()

        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        audio.pause( myData.bgMusic )
        if(myData.sound) then
       audio.play( myData.bgSound,{channel = 0, loops = -1})
        end

    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        myData.pT = false
        

        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
        timer.cancel( pauseTimer )
        sceneGroup:remove( myData.player1.animation )  
        sceneGroup:remove( myData.player2.animation )
        sceneGroup:remove( myData.ground )

    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view

    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc

end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


-- -------------------------------------------------------------------------------

return scene 
