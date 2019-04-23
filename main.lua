-----------------------------------------------------------------------------------------
--
-- main.lua
--
local function characterCollision( self, event )
 
    if ( event.phase == "began" ) then
        print( self.id .. ": I did not hit her " .. event.other.id )
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": I did not! " .. event.other.id )
    end
end
--
-----------------------------------------------------------------------------------------

-- Gravity

local map = display.newImageRect( "Sky.jpg", 2100,2100 )
map.x = 900
map.y = display.contentHeight - 1050
map.id = "map"


local physics = require( "physics" )

physics.start()
physics.setGravity( 0, 25 ) -- ( x, y )


local theGround = display.newImageRect( "land.png",1000,100 )
theGround.x = 520
theGround.y = display.contentHeight
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )


local theGround = display.newImageRect( "land.png",1000,100 )
theGround.x = display.contentCenterX
theGround.y = display.contentHeight
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )
local theGround = display.newImageRect( "land.png", 400,200 )
theGround.x = display.contentCenterX
theGround.y = display.contentHeight
theGround.id = "the ground"
physics.addBody( theGround, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local blade = display.newImage( "blade.png" )
blade.x = display.contentCenterX
blade.y = display.contentCenterY
blade.id = "the character"
physics.addBody( blade, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )

function blade:touch( event )
    if ( event.phase == "began" ) then
        print( "Touch event began on: " .. self.id )
 
        -- Set touch focus
        display.getCurrentStage():setFocus( self )
        self.isFocus = true
     
    elseif ( self.isFocus ) then
        if ( event.phase == "moved" ) then
            print( "Moved phase of touch event detected." )
 
        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
 
            -- Reset touch focus
            display.getCurrentStage():setFocus( nil )
            self.isFocus = nil
            print( "Touch event ended on: " .. self.id )
        end
    end

    return true
end

blade:addEventListener( "touch", blade )


local function onNinjaTouched( event )
    if ( event.phase == "began" ) then
        print( "Touch event began on: " .. event.target.id )
    elseif ( event.phase == "ended" ) then
        print( "Touch event ended on: " .. event.target.id )
    end
  
    return true
end


local theCharacter = display.newImage( "Ninja.png" )
theCharacter.x = display.contentCenterX
theCharacter.y = display.contentCenterY
theCharacter.id = "the character"
physics.addBody( theCharacter, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )

local dPad = display.newImage( "d-pad.png" )
dPad.x = 150
dPad.y = display.contentHeight - 200
dPad.alpha = 0.50
dPad.id = "d-pad"

local upArrow = display.newImage( "upArrow.png" )
upArrow.x = 150
upArrow.y = display.contentHeight - 310
upArrow.id = "up arrow"

local downArrow = display.newImage( "downArrow.png" )
downArrow.x = 150
downArrow.y = display.contentHeight - 90
downArrow.id = "down arrow"

local leftArrow = display.newImage( "leftArrow.png" )
leftArrow.x = 40
leftArrow.y = display.contentHeight - 200
leftArrow.id = "left arrow"

local rightArrow = display.newImage( "rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 200
rightArrow.id = "right arrow"
 
 local JumpButton = display.newImageRect( "JUMP.png", 100,100 )
JumpButton.x = 150
JumpButton.y = display.contentHeight -200
JumpButton.id = "Jump"


function upArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = -70, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function downArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 0, -- move 0 in the x direction 
        	y = 50, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = -50, -- move 0 in the x direction 
        	y = 0, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
        	x = 50, -- move 0 in the x direction 
        	y = 0, -- move up 50 pixels
        	time = 100 -- move in a 1/10 of a second
        	} )
    end

    return true
end

function JumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( theCharacter, { 
            x = 0, -- move 0 in the x direction 
            y = -50, -- move down 50 pixels
            time = 100 -- move in a 1/10 of a second
            } )
    end


    return true
end

upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
leftArrow:addEventListener( "touch", leftArrow )
rightArrow:addEventListener( "touch", rightArrow )
JumpButton:addEventListener( "touch", JumpButton )

theCharacter.collision = characterCollision
theCharacter:addEventListener( "collision" )