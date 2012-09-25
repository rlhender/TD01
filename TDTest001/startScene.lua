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

local bg, text1, text2, text3

-- Touch event listener for background image
local function onPlayTouch( self, event )
    if event.phase == "began" then
       storyboard.gotoScene( "TDBoardScene", "fade", 400  )
       return true 
    end
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

    bg = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    bg:setFillColor(71, 107, 214)
    group:insert( bg )

    bg.touch = onPlayTouch

    text1 = display.newText( "Scene 1", 0, 0, native.systemFontBold, 24 )
    text1:setTextColor( 255 )
    text1:setReferencePoint( display.CenterReferencePoint )
    text1.x, text1.y = display.contentWidth * 0.5, 50
    group:insert( text1 )

    text2 = display.newText( "MemUsage: ", 0, 0, native.systemFont, 16 )
    text2:setTextColor( 255 )
    text2:setReferencePoint( display.CenterReferencePoint )
    text2.x, text2.y = display.contentWidth * 0.5, display.contentHeight * 0.5
    group:insert( text2 )

    text3 = display.newText( "Touch to start.", 0, 0, native.systemFontBold, 18 )
    text3:setTextColor( 255 ); text3.isVisible = false
    text3:setReferencePoint( display.CenterReferencePoint )
    text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 100
    group:insert( text3 )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    -----------------------------------------------------------------------------

    --	INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------
    text3.isVisible = true
    bg:addEventListener( "touch", obj )
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