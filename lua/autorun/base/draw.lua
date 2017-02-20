draw = {}

local lg = love.graphics
local rad = math.pi*2

-- r should not be greater than the w or h of the rectangle.
function draw.roundedRect( x, y, w, h, r, m, s )

    r = r or 14
    m = m or "fill"
    s = s or 10

    lg.rectangle( m, x + r, y + r, w - r*2, h - r*2 )
    lg.arc( m, x + r, y + r, r, -rad*0.5, -rad*0.25, s )
    lg.arc( m, x + w - r, y + r, r, 0, -rad*0.25, s )
    lg.arc( m, x + r, y + h - r, r, -rad*0.5, -rad*0.75, s )
    lg.arc( m, x + w - r, y + h - r, r, -rad*0.75, -rad, s )

    lg.rectangle( m, x + r, y, w - r*2, r )
    lg.rectangle( m, x, y + r, r, h - r*2 )
    lg.rectangle( m, x + w - r, y + r, r, h - r*2 )
    lg.rectangle( m, x + r, y + h - r, w - r*2, r )

end

function draw.thickLine( x1, y1, x2, y2, size, curve )

    local v1 = vector( x1, y1 )
    local v2 = vector( x2, y2 )
    local norm = ( v2 - v1 ):normalized()

    local r = math.pi/2
    local norm2 = norm:perpendicular()*size
    local norm3 = norm:perpendicular()*-size

    local m, n = norm2.x, norm2.y
    local k, q = norm3.x, norm3.y

    local x3,y3 = x1 + m, y1 + n
    local x4,y4 = x1 - m, y1 - n
    local x5,y5 = x2 + m, y2 + n
    local x6,y6 = x2 - m, y2 - n


    love.graphics.line( x3, y3, x4, y4, x6, y6, x5, y5, x3, y3 )

    -- love.graphics.circle( "fill", x3, y3, 2, 20 )
    -- love.graphics.circle( "fill", x4, y4, 2, 20 )
    -- love.graphics.circle( "fill", x5, y5, 2, 20 )
    -- love.graphics.circle( "fill", x6, y6, 2, 20 )

    --love.graphics.line( x2, y2, x3, y3 )

end
