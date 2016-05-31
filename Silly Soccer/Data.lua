local m = {}
m.displayGroup = display.newGroup( )
m.ground = nil

m.score1 = 0
m.score2 = 0

m.score1Text = display.newText( m.displayGroup,"P1: "..m.score1, 10, 25 , "Demolition.ttf",16 )
m.score1Text:setFillColor( 1,0.3,0 )
m.score1Text:setStrokeColor( 1,1,1 )

m.score2Text = display.newText( m.displayGroup,"P2: "..m.score2, 470, 300 , "Demolition.ttf",16 )
m.score2Text:setFillColor( 1,0.3,0)
m.score2Text.rotation = 180

m.optionsBKid = {
	width = 53,
	height = 47,
	numFrames = 9,
	sheetContentWidth = 477,
	sheetContentHeight = 47

}
m.optionsNKid = {
	width = 52,
	height = 46,
	numFrames = 9,
	sheetContentWidth = 468,
	sheetContentHeight = 46

}

m.optionsBGirl = {
	width = 52,
	height = 46,
	numFrames = 9,
	sheetContentWidth = 468,
	sheetContentHeight = 46

}

m.optionsNGirl = {
	width = 53,
	height = 51,
	numFrames = 9,
	sheetContentWidth = 477,
	sheetContentHeight = 51

}
m.optionsGMan = {
	width = 52,
	height = 46,
	numFrames = 9,
	sheetContentWidth = 468,
	sheetContentHeight = 46

}
m.optionsOWoman = {
	width = 52,
	height = 46,
	numFrames = 9,
	sheetContentWidth = 468,
	sheetContentHeight = 46

}

m.BGirl = graphics.newImageSheet("Assets/Characters/BGirl.png", m.optionsBGirl )
m.NKid =  graphics.newImageSheet("Assets/Characters/NKid.png", m.optionsNKid )
m.BKid = graphics.newImageSheet("Assets/Characters/BKid.png", m.optionsBKid )
m.NGirl = graphics.newImageSheet("Assets/Characters/NGirl.png", m.optionsNGirl )
m.GMan = graphics.newImageSheet("Assets/Characters/GMan.png", m.optionsGMan )
m.OWoman = graphics.newImageSheet("Assets/Characters/OWoman.png", m.optionsOWoman )


m.player1 = {}
m.player1.speed = 30
m.player1.imagesheet = graphics.newImageSheet("Assets/Characters/BKid.png", m.optionsBKid )
m.player1.sequenceData = {

		{ name="idle", start =1, count =9, time = 400}

}
m.animationData  = nil
m.player1.animation = display.newSprite(m.displayGroup, m.player1.imagesheet,m.player1.sequenceData )


m.player2 = {}
m.player2.speed = 20
m.player2.options = {
	width = 49,
	height = 38.5,
	numFrames = 9,
	sheetContentWidth = 150,
	sheetContentHeight = 115

}
m.player2.imagesheet = graphics.newImageSheet( "Assets/Characters/NKid.png", m.optionsNKid )
m.player2.sequenceData = {

		{ name="idle", start =1, count =9, time = 700}

}
m.player2.animation = display.newSprite(m.displayGroup, m.player2.imagesheet,m.player1.sequenceData )





m.ball = {}

m.ball.options = {
	width = 16.5,
	height = 18,
	numFrames = 2,
	sheetContentHeight = 36,
	sheetContentWidth = 18
}
m.ball.imagesheet = graphics.newImageSheet( "Assets/Ground/ball.png",m.ball.options)
m.ball.sequenceData = {
	{name = "ball", start=1 , count = 2, time = 500}
}
m.ball.animation = display.newSprite(m.displayGroup, m.ball.imagesheet, m.ball.sequenceData )
m.ball.animation.id = "ball"


m.rotateClock = display.newImage( m.displayGroup, "Assets/HUD/p1clock.png")
m.rotateClock.x = 15
m.rotateClock.y = 250
m.rotateClock:scale( 0.9, 0.9 )

m.rotateAntiClock = display.newImage(m.displayGroup,  "Assets/HUD/p1anticlock.png")
m.rotateAntiClock.x = 465
m.rotateAntiClock.y = 250
m.rotateAntiClock:scale( 0.9, 0.9)

m.rotateClock2 = display.newImage(m.displayGroup,  "Assets/HUD/p2clock.png")
m.rotateClock2.x = 15
m.rotateClock2.y = 75
m.rotateClock2:scale( 0.9, 0.9 )

m.rotateAntiClock2 = display.newImage( m.displayGroup, "Assets/HUD/p2anticlock.png")
m.rotateAntiClock2.x = 465
m.rotateAntiClock2.y = 75
m.rotateAntiClock2:scale( 0.9, 0.9 )

m.wall1 = display.newImage(  "Assets/Ground/wall1.png" )
m.wall1.x = 65
m.wall1.y = display.contentHeight/2
m.wall1.isVisible = false

m.wall2 = display.newImage(  "Assets/Ground/wall2.png" )
m.wall2.x = display.contentWidth/2 +  170
m.wall2.y = display.contentHeight/2+2
m.wall2.isVisible = false

m.wall3 = display.newImage( "Assets/Ground/wall3.png" )
m.wall3.x = display.contentWidth/2+185
m.wall3.y = 15
m.wall3.isVisible = false

m.wall5 = display.newImage( "Assets/Ground/wall3.png" )
m.wall5.x = display.contentWidth/2-185
m.wall5.y = 15
m.wall5.isVisible = false

m.wall6 = display.newImage( "Assets/Ground/wall3.png" )
m.wall6.x = display.contentWidth/2 - 185
m.wall6.y = 305
m.wall6.isVisible = false

m.wall4 = display.newImage( "Assets/Ground/wall4.png" )
m.wall4.x = display.contentWidth/2 +185
m.wall4.y = 305
m.wall4.isVisible = false

m.goal1 = display.newImage( m.displayGroup, "Assets/Ground/goal1.png")
m.goal1.x = display.contentWidth/2
m.goal1.y = 310
m.goal1.id = "goal1"
m.goal1.text = 0

m.goal2 = display.newImage(m.displayGroup,  "Assets/Ground/goal2.png" )
m.goal2.x = display.contentWidth/2
m.goal2.y = 10
m.goal2.id = "goal2"
m.goal2.text = 0

m.bgSound = audio.loadSound( "Assets/Sounds/crowd.mp3" )
m.menuSound = audio.loadSound( "Assets/Sounds/menu.mp3" )
m.whistleSound = audio.loadSound( "Assets/Sounds/whistle.mp3" )
m.goalSound = audio.loadSound( "Assets/Sounds/goal.mp3" )
m.bgMusic = audio.loadSound( "Assets/Sounds/bgMusic.mp3" )
m.kick = audio.loadSound( "Assets/Sounds/kick.mp3" )

m.index = 1
m.index2 = 2
m.groundIndex = 1

m.sound = false
m.pT = true

m.loc = true

m.p1Ready = false
m.p2Ready = false

m.player = nil

m.gameStarted = false

m.gamePaused = false





return m