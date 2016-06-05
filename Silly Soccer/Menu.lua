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
local menuGroup
local bg
local creditsButton
local soundOn
local soundOff
local comingSoon
local startTimer
local function mechanics( player )
    if(myData.pT) then
    player:setLinearVelocity(math.sin(math.rad(player.rotation)) * -myData.player1.speed, math.cos(math.rad(player.rotation)) * myData.player1.speed)
end
end



-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here

-- -------------------------------------------------------------------------------
local function makeClient()
    if(isServer) then --if we were a server before, we need to unregister all the event listeners
        Runtime:removeEventListener("autolanPlayerDropped", playerDropped)
        Runtime:removeEventListener("autolanPlayerJoined", addPlayer)
        Runtime:removeEventListener("autolanReceived", serverReceived) --all incoming packets sent to serverReceived
        timer.cancel(sendFullFrameTimer)
        isServer = false
    end
    print("making client")
    client = require("Client")
    client:start()
    client:scanServers()
    isClient = true
    Runtime:addEventListener("autolanReceived", clientReceived) --all incoming packets are sent to clientReceived
    Runtime:addEventListener("autolanConnectionFailed", connectionAttemptFailed)
    Runtime:addEventListener("autolanDisconnected", connectionAttemptFailed)    
end
local function makeServer()
    if(isClient) then --if we were a client before, we need to unregister all the event listeners
        isClient = false
        Runtime:removeEventListener("autolanReceived", clientReceived) --all incoming packets are sent to clientReceived
        Runtime:removeEventListener("autolanConnectionFailed", connectionAttemptFailed)
        Runtime:removeEventListener("autolanDisconnected", connectionAttemptFailed) 
    end
    server = require("Server")
    server:setCustomBroadcast("1 Player")
    server:start()
    isServer = true
    menuGroup:removeSelf()
    --add event listeners
    Runtime:addEventListener("autolanPlayerDropped", playerDropped)
    Runtime:addEventListener("autolanPlayerJoined", addPlayer)
    Runtime:addEventListener("autolanReceived", serverReceived) --all incoming packets sent to serverReceived
    sendFullFrameTimer = timer.performWithDelay(250, sendFullFrame, -1)
end
---------------------------UI OBJECTS--------------------
local numberOfServers = 0
local function spawnMenu(group)
    --functions to handle button events
    multiPlayerButton.isVisible = false
    localButton.isVisible = false
    silly.isVisible = false
    soccer.isVisible = false
    local joinText 

    local function joinPressed()
        myData.player = 2 
        joinText.text = "Scanning..."
         makeClient()
    end
    local function hostPressed()
        myData.player = 1
        makeServer()
    end
    
    local titleText = display.newText(group, "MULTIPLAYER LOBBY", 0, 0, "Demolition.ttf", 18)
    titleText.x, titleText.y = display.contentCenterX, 55
    titleText:setFillColor( 0.2,0.2,0.2 )

    --host button
    local host = display.newRoundedRect(group, 130, 120, 120,60,20)
    host:setFillColor(100,100,100)
    host:addEventListener("tap", hostPressed)
    local hostText = display.newText(group, "HOST", 130, 120, "Demolition.ttf", 20)
    hostText:setFillColor( 0.5,0.5,0.5 )
    --host button
    local join = display.newRoundedRect(group, 350, 120, 120,60,20)
    join:addEventListener("tap", joinPressed)
    join:setFillColor(100,100,100)  
    joinText = display.newText(group, "JOIN", 350, 120,"Demolition.ttf", 20)
    joinText:setFillColor( 0.5,0.5,0.5 )


    local function createListItem(event) --displays found servers
        local item = display.newGroup()
        item.background = display.newRoundedRect(item,250,200,200,50,20)
        item.background.strokeWidth = 3
        item.background:setFillColor(70, 70, 70)
        item.background:setStrokeColor(180, 180, 180)
        item.text = display.newText(item,event.serverName, 250, 200, "Helvetica-Bold", 18 )
            item.text:setTextColor( 0,0,0 )
        item.serverIP = event.serverIP      
        --attach a touch listener
        function item:tap(e)
            client:connect(self.serverIP)
            menuGroup.isVisible = false
            
        end
        item:addEventListener("tap", item)
        menuGroup:insert(item)
    end
    Runtime:addEventListener("autolanServerFound", createListItem)
    
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local numPlayers = 0
local function getFullGameState()
    local state = {}
    state[1] = 2--protocol id
    state[2] = myData.player1.animation.x
    state[3] = myData.player1.animation.y
    state[4] = myData.player1.animation.rotation
    state[5] = myData.player2.animation.x
    state[6] = myData.player2.animation.y
    state[7] = myData.player2.animation.rotation
    state[8] = myData.ball.animation.x
    state[9] = myData.ball.animation.y
    state[10] = myData.ball.animation.rotation
    return state
end

local function autolanPlayerDropped(event)
   
end
Runtime:addEventListener("autolanPlayerDropped", autolanPlayerDropped)

playerDropped = function(event)
    local clientDropped = event.client
    --go through the table and find the client that dropped
    for i=1, numPlayers do
        if(clients[i] == clientDropped) then
            table.remove(clients, i) --remove this client
            numPlayers = numPlayers - 1
        end
    end
end
addPlayer = function(event)
    local client = event.client --this is the client object, used to send messages
    print("player joined",client)
    --look for a client slot
    numPlayers = numPlayers+1
    clients[numPlayers] = client
    client:sendPriority({1,numPlayers}) --initialization packet
    client:sendPriority(getFullGameState()) --initialization packet 
    server:setCustomBroadcast(numPlayers.." Players")
    composer.gotoScene("Characterselection")
end

sendFullFrame = function()
    for i=1, numPlayers do
        clients[i]:send(getFullGameState())
    end 
end
serverReceived =  function(event)
    local message = event.message
    if(message[1]=="paused")then
        myData.gamePaused = true
        composer.showOverlay( "Pause",{ isModal = true } )
    end
    if(message[1]=="resumed")then
        myData.gamePaused = false
        composer.hideOverlay( "Pause",{ isModal = true } )
    end
    print(message[3])
    if(message[1] == 11)then
        myData.player2.animation.rotation = message[2]
        mechanics(myData.player2.animation)
    end
    if(message[1]==12)then
        myData.p2Ready = true
    end
end

----------------------------------------------------------------------------------------------
-------------------------------------CLIENT SPECIFIC CODE-------------------------------------
----------------------------------------------------------------------------------------------

connectionAttemptFailed = function(event)
    print("connection failed, redisplay menu")
    numberOfServers = 0
    menuGroup = display.newGroup()
    spawnMenu(menuGroup)
end

local function connectedToServer(event)
    print("connected, waiting for sync")
    composer.gotoScene("Characterselection")
end
Runtime:addEventListener("autolanConnected", connectedToServer)

local function restoreGameState(message)
    if(myData.gameStarted==true) then
    myData.player1.animation.x = message[2]
    myData.player1.animation.y = message[3]
    myData.player1.animation.rotation = message[4]
    myData.player2.animation.x = message[5]
    myData.player2.animation.y = message[6]
    myData.player2.animation.rotation = message[7]
    myData.ball.animation.x = message[8]
    myData.ball.animation.y = message[9]
    myData.ball.animation.rotation = message[10]
    mechanics(myData.player1.animation)
    mechanics(myData.player2.animation)  
    end  

end
clientReceived = function (event)
    local message = event.message
    if(message[1]=="paused")then
        myData.gamePaused = true
        composer.showOverlay( "Pause",{ isModal = true } )
    end
    if(message[1]=="resumed")then
        myData.gamePaused = false
        composer.hideOverlay( "Pause",{ isModal = true } )
    end
    if(message[1] == 13)then
        
        composer.gotoScene("Game")
        myData.gameStarted = true
    end
    --figure out packet type
    if(message[1] == 1) then
        print("got init packet")

    elseif(message[1] == 2) then
        if(myData.gameStarted == true)then
        restoreGameState(message)
    end
    elseif(message[1] == 11) then    
        myData.player1.animation.rotation = message[2]
        mechanics(myData.player1.animation)
    end
        
end



local function multiPlayerButtonTap( event )
    myData.loc = false
    if(myData.sound) then
    audio.play( myData.menuSound )
end
spawnMenu(menuGroup)
end

 
local function player2UpdateFunction(  )
     local state = {}
    state[1] = 11
    state[2] = myData.player2.animation.rotation
    client:send(state)
     
end
scene.player2Update = player2UpdateFunction

local function startGame(  )
    local state = {}
    state[1] = 13
        clients[1]:send(state)
    composer.gotoScene("Game")
    myData.gameStarted = true
end

local function player2R(  )
    myData.p2Ready = true
    local state = {}
    state[1] = 12
    client:send(state)
end

scene.player2Ready = player2R
local function canceltimer(  )
    timer.cancel( startTimer )
end
local function player1R( )
    myData.p1Ready = true
    startTimer = timer.performWithDelay( 1000,function (  )
        if(myData.p1Ready and myData.p2Ready)then
            canceltimer()
            startGame()
        end
    end,-1 )
end
scene.player1Ready = player1R

local function player1UpdateFunction(  )
     local state = {}
    state[1] = 11
    state[2] = myData.player1.animation.rotation
    for i=1, numPlayers do
        clients[i]:send(state)
    end
end
scene.player1Update = player1UpdateFunction
local function pauseGamef(  )
    if(isServer)then
        local state = {}
        state[1]="paused"
        for i=1, numPlayers do
        clients[i]:send(state)
    end
end
    if(isClient)then
        local state = {}
        state[1]="paused"
        client:send(state)
    end


end
scene.pauseGame = pauseGamef

local function resumeGamef(  )
    if(isServer)then
        local state = {}
        state[1]="resumed"
        for i=1, numPlayers do
        clients[i]:send(state)
    end
end
    if(isClient)then
        local state = {}
        state[1]="resumed"
        client:send(state)
    end
end
scene.resumeGame = resumeGamef

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

    


end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        numPlayers = 0
        audio.pause( myData.bgSound)
        Runtime:removeEventListener("autolanReceived", clientReceived) --all incoming packets are sent to clientReceived
        Runtime:removeEventListener("autolanConnectionFailed", connectionAttemptFailed)
        Runtime:removeEventListener("autolanDisconnected", connectionAttemptFailed) 
        isClient = false

        Runtime:removeEventListener("autolanPlayerDropped", playerDropped)
        Runtime:removeEventListener("autolanPlayerJoined", addPlayer)
        Runtime:removeEventListener("autolanReceived", serverReceived) --all incoming packets sent to serverReceived
        isServer = false
        -- Called when the scene is still off screen (but is about to come on screen).
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc
        multiPlayerButton.isVisible = true
        localButton.isVisible = true
        silly.isVisible = true
        soccer.isVisible = true
        menuGroup = display.newGroup( )
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
