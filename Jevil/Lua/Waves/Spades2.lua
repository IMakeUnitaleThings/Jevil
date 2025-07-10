-- The bouncing bullets attack from the documentation example.
spawntimer = 0
bulletspawns = {}
bullets = {}
cards = {}
FrameTime = 30
speed = 3.5
RandomNeg = {-1, 1}
function Update()
    spawntimer = spawntimer + 1
    if spawntimer%FrameTime == 0 then --spawn new bulletspawns
        --spawn location 
        XMult = RandomNeg[math.random(1,2)]
        YMult = RandomNeg[math.random(1,2)]
        local posx = XMult*(math.random(Arena.width, Arena.width+200))
        local posy = YMult*(math.random(Arena.height, Arena.height+50))
        local bullet = CreateProjectile('bullets/spr_spadebullet', posx, posy)
        local card = CreateProjectile('cards/2', posx, posy)
        card.SendToBottom()
        --set rotation and bullet path
        local velx = posx - Player.x
        local vely = posy - Player.y

        local angle = math.deg(math.atan2(Player.y - bullet.y, Player.x - bullet.x))
        bullet.sprite.rotation = angle
        Len = math.sqrt(math.pow(velx, 2) + math.pow(vely, 2)) 
        vely = (vely/Len)*speed*-1
        velx = (velx/Len)*speed*-1

        bullet.SetVar('velx', velx)
        bullet.SetVar('vely', vely)
        bullet.sprite.rotation = angle
        card.sprite.rotation = angle+90
        card.sprite.Scale(2, 2)

        card.SetVar('age', 0)

        table.insert(bulletspawns, bullet)
        table.insert(cards, card)
    end
    if spawntimer%30 == 0 then 
        FrameTime = FrameTime - 1
    end
    
    if spawntimer%5 == 0 then --spawn normal bullets
        for i=1, #bulletspawns do 
            local bulletspawn = bulletspawns[i]
            if bulletspawn.isactive then
                local bullet = CreateProjectile('bullets/spr_spadebullet', bulletspawn.x, bulletspawn.y)
                local velx = bulletspawn.GetVar('velx')
                local vely = bulletspawn.GetVar('vely')
                bullet.SetVar('velx', velx)
                bullet.SetVar('vely', vely)
                bullet.sprite.rotation = bulletspawn.sprite.rotation
                bullet.sprite.Scale(0.5, 0.5)
                table.insert(bullets, bullet)
            end
        end 
    end

    for i=1,#bulletspawns do --kill old bulletspawns
        cards[i].SetVar('age', cards[i].GetVar('age')+1)
        local bulletspawn = bulletspawns[i]
        if cards[i].GetVar('age') >= FrameTime then 
            if bulletspawn.isactive then
                bulletspawn.remove()
                cards[i].remove()
            end
        end
    end

    for i=1, #bullets do 
        local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        bullet.MoveTo(newposx, newposy)
    end 
end