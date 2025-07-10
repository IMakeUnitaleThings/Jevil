-- The bouncing bullets attack from the documentation example.
spawntimer = 0
bullets = {}
RandomNeg = {-1, 1}
speed = 2.5
function Update()
    if spawntimer == 0 then 
        local posx = Arena.width + 30
        local posy = 0
        Card = CreateProjectile('cards/4', posx, posy)
        Card2 = CreateProjectile('cards/4', -(posx), posy)
        Card.sprite.xscale = 2
        Card2.sprite.xscale = 2
        Card.sprite.yscale = 2
        Card2.sprite.yscale = 2
    end
    spawntimer = spawntimer + 1
    if spawntimer%10 == 0 then
        local leftright = math.random(1, 2)
        local posx = (Arena.width + 30)*RandomNeg[leftright]
        local posy = 0
        local dir = math.random(-25, 25)
        --get slope depending on direction
        local DeltaY = math.tan(dir*(math.pi/180))*(speed*math.random(75, 100)/100)
        local bullet = CreateProjectile('bullets/spr_diamondbullet', posx, posy)
        bullet.SetVar('velx', speed)
        bullet.SetVar('vely', DeltaY)
        bullet.SetVar('leftright', leftright)
        -- random sizing for more chaos
        local BulletSize = math.random(40, 50)/100
        bullet.sprite.xscale = BulletSize
        bullet.sprite.yscale = BulletSize
        bullet.sprite.rotation = -(dir*RandomNeg[leftright])
        table.insert(bullets, bullet)
        --move card
        Card.SendToBottom()
        Card2.SendToBottom()

    end
    
    for i=1,#bullets do
        local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + -(velx*RandomNeg[bullet.GetVar('leftright')])
        local newposy = bullet.y + vely
        bullet.MoveTo(newposx, newposy)
    end
end