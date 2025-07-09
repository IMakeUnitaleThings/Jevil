-- The bouncing bullets attack from the documentation example.
spawntimer = 0
bullets = {}
cards = {}
RandomNeg = {-1, 1}
speed = 1
function Update()
    if spawntimer == 0 then 
        local posx = Arena.width + 30
        local posy = 0
        Card = CreateProjectile('cards/4', posx, posy)
        Card2 = CreateProjectile('cards/4', -(posx), posy)
        Card3 = CreateProjectile('cards/4', 0, -(Arena.height+30))
        table.insert(cards, Card1)
        table.insert(cards, Card2)
        table.insert(cards, Card3)
        for i=1,#cards do
            cards[i].sprite.xscale = 2
            cards[i].sprite.yscale = 2
        end
    end
    spawntimer = spawntimer + 1
    if spawntimer%10 == 0 then
        if math.random(1,3) == 1 then
            local posx = 0
            local posy = -(Arena.height+30)
            local dir = -(math.random(70, 110))
            local DeltaY = math.tan(dir*(math.pi/180))*(1*math.random(75, 100)/100)
            local bullet = CreateProjectile('bullets/spr_diamondbullet', posx, posy)
            bullet.SetVar('velx', DeltaY)
            bullet.SetVar('vely', speed)
            local BulletSize = math.random(40, 50)/100
            bullet.sprite.xscale = BulletSize
            bullet.sprite.yscale = BulletSize
            bullet.sprite.rotation = -(dir)
            table.insert(bullets, bullet)
        else
            local leftright = math.random(1, 2)
            local posx = (Arena.width + 30)*RandomNeg[leftright]
            local posy = 0
            local dir = math.random(-25, 25)
            --get slope depending on direction
            local DeltaY = math.tan(dir*(math.pi/180))*(speed*math.random(75, 100)/100)
            local bullet = CreateProjectile('bullets/spr_diamondbullet', posx, posy)
            bullet.SetVar('velx', -(speed*RandomNeg[leftright]))
            bullet.SetVar('vely', DeltaY)
            bullet.SetVar('leftright', leftright)
            -- random sizing for more chaos
            local BulletSize = math.random(40, 50)/100
            bullet.sprite.xscale = BulletSize
            bullet.sprite.yscale = BulletSize
            bullet.sprite.rotation = -(dir*RandomNeg[leftright])
            table.insert(bullets, bullet)

        end
        
        --move card
        for i=1,#cards do 
            cards[i].SendToBottom()
        end

    end
    
    for i=1,#bullets do
        local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        bullet.MoveTo(newposx, newposy)
    end
end