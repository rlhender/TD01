----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

local emptySquare = {}
--local emptySquare.speed = 0  --0 = fast ... 9 = slow
local width = display.contentWidth
local height = display.contentHeight

--* functions declarations

local boardInit
local squareWidthCalculate
local initSquare
local calculateMargin
local board = {}

--* function implementations

squareWidthCalculate = function( _horizontalSquareCount, 
        _verticalSquareCount )
   local tempHorizontalSquareWidth = math.floor(width / 
        _horizontalSquareCount)
   local tempVerticalSquareHeight = math.floor((height - 
        display.statusBarHeight) / _verticalSquareCount) 
   if tempHorizontalSquareWidth < tempVerticalSquareHeight then
       return tempHorizontalSquareWidth
   else
       return tempVerticalSquareHeight
   end
end

boardInit = function()
    --all variables reinitialized here
    local horizontalSquareCount = 20
    local verticalSquareCount = 30
    local squareWidth = squareWidthCalculate(
            horizontalSquareCount, verticalSquareCount)
    local leftMargin = calculateMargin(width, squareWidth, 
            horizontalSquareCount)
    local topMargin = display.statusBarHeight + 
            calculateMargin(height, squareWidth, verticalSquareCount)
    local lboard = {}
    lboard.boardDisplay = display.newRect(leftMargin, topMargin, 
            squareWidth * horizontalSquareCount,
            squareWidth * verticalSquareCount )
    lboard.horizontalSquareCount = horizontalSquareCount
    lboard.verticalSquareCount = verticalSquareCount
    lboard.squareWidth = squareWidth
    lboard.leftMargin = leftMargin
    lboard.topMargin = topMargin
    for i = 1, horizontalSquareCount , 1 do
        lboard[i] = {}
        for j = 1, verticalSquareCount, 1 do
            lboard[i][j] = {}
            lboard[i][j].square = initSquare(i,j,lboard)
        end
    end
    return lboard
end

calculateMargin = function(_width, _squareWidth, _squareCount)
    return math.floor( (_width - ( _squareWidth * _squareCount ) ) * 0.5 )
end

initSquare = function(_xSquare, _ySquare, _board)
    local tempLeft = _board.leftMargin + ( ( _xSquare - 1 ) * 
            _board.squareWidth )
    local tempRight = _board.leftMargin + ( _xSquare * _board.squareWidth )
    local tempTop = _board.topMargin + ( ( _ySquare - 1 ) * _board.squareWidth )
    local tempBottom = _board.topMargin + ( _ySquare * _board.squareWidth )
    local thisSquare = display.newRect(tempLeft, tempTop, _board.squareWidth, 
            _board.squareWidth)
    thisSquare:setFillColor(71, 107, 214, 100)
    thisSquare.xSquare = _xSquare
    thisSquare.ySquare = _ySquare
    thisSquare.left = tempLeft
    thisSquare.right = tempRight
    thisSquare.top = tempTop
    thisSquare.bottom = tempBottom
    thisSquare.isObstacle = false
    thisSquare.object = emptySquare
    return thisSquare
end


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
 
	-----------------------------------------------------------------------------
		
	--	CREATE display objects and add them to 'group' here.
	--	Example use-case: Restore 'group' from previously saved state.
	
	-----------------------------------------------------------------------------
   local board = boardInit()
   group:insert( board.boardDisplay )
	
end 

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
		
	--	INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
	
	-----------------------------------------------------------------------------
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	-----------------------------------------------------------------------------
	
	--	INSERT code here (e.g. remove listeners, widgets, save state, etc.)
	
	-----------------------------------------------------------------------------
	
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene