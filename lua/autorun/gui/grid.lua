
--[[--
 ▄▀▀█▄▄   ▄▀▀█▄▄▄▄  ▄▀▀▀▀▄  ▄▀▀▄ ▀▀▄  ▄▀▀▄ ▀▄  ▄▀▄▄▄▄  
█ ▄▀   █ ▐  ▄▀   ▐ █ █   ▐ █   ▀▄ ▄▀ █  █ █ █ █ █    ▌ 
▐ █    █   █▄▄▄▄▄     ▀▄   ▐     █   ▐  █  ▀█ ▐ █      
  █    █   █    ▌  ▀▄   █        █     █   █    █      
 ▄▀▄▄▄▄▀  ▄▀▄▄▄▄    █▀▀▀       ▄▀    ▄▀   █    ▄▀▄▄▄▄▀ 
█     ▐   █    ▐    ▐          █     █    ▐   █     ▐  
▐         ▐                    ▐     ▐        ▐   
--]]--

local lg = love.graphics
local lm = love.mouse
local PANEL = {}

function PANEL:initialize()
	self.columnWidth = 25
	self.rowHeight = 25
	self.gridObjects = {}
	self.xgap = 5
	self.ygap = 5
end 

function PANEL:setColumnWidth( n )	
	self.columnWidth = n
end 

function PANEL:getColumnWidth()
	return self.columnWidth 
end 

function PANEL:setRowHeight( n ) 
	self.rowHeight = n 
end 

function PANEL:getRowHeight()
	return self.rowHeight
end

function PANEL:setXGap( gap )
	self.xgap = gap 
end 

function PANEL:getXGap()
	return self.xgap
end 

function PANEL:setYGap( gap )
	self.ygap = gap 
end 

function PANEL:getYGap()
	return self.ygap 
end 

function PANEL:setGap( x, y )
	self.xgap = x; self.ygap = y 
end 

function PANEL:getGap()
	return self.xgap, self.ygap
end 

function PANEL:arrangeGrid()

	local children = self:getChildren()
	local rowH = self:getRowHeight()
	local colW = self:getColumnWidth()

	local r = math.floor( (self:getHeight()/rowH) )
	local c = math.floor( (self:getWidth()/colW) )

	local gridObjects = self:getGridObjects()
	for i = 1,#gridObjects do 
		local xmod = i%c
		local ymod = math.floor( i/c )
		local x = xmod*( colW + self:getXGap() )
		local y = ymod*( rowH + self:getYGap() )
		gridObjects[ i ]:setPos( x - colW/2, y - rowH/2 )
		gridObjects[ i ]:setSize( colW, colH )
	end 

end 

function PANEL:getGridObjects()
	return self.gridObjects
end 

function PANEL:add( panel )	
	panel:setParent( self )
	table.insert( self.gridObjects, panel )
	self:arrangeGrid()
end 

function PANEL:onSizeChanged()
	self:arrangeGrid()
end 

function PANEL:onChildAdded( panel )
end 

function PANEL:onChildRemoved( panel )
	lume.remove( self.gridObjects, panel )
end 

function PANEL:paint()
end

gui.register( "grid", PANEL, "panel" )