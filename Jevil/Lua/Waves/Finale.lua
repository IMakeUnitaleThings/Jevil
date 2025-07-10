-- The bouncing bullets attack from the documentation example.
spawntimer = 0
bulletspawns = {}
bullets = {}
speed = 3
sspeed = 4
pspeed = 6
pradius = 50
pangle = 0
spawnangle = 0

offset = 360/3
Encounter.SetVar('wavetimer', 90)
function Update()
    if spawntimer == 0 then 
        --set up player movement
        Player.SetControlOverride(true)
        Player.sprite.rotation = math.deg(math.atan2(0 - Player.y, 0 - Player.x)) + 90
        Player.sprite.color = {.427,.427,.753}
        Arena.Resize(500, 500)
    end
    --move player
    if Input.Left > 0 then
        pangle = pangle + pspeed
    elseif Input.Right > 0 then
        pangle = pangle - pspeed
    end    
    if Input.Confirm == 1 then 
        if pradius == 150 then 
            pradius = 50
        elseif pradius == 50 then
            pradius = 150
        end
    end
    px = pradius*(math.cos(pangle*math.pi/180))
    py = pradius*(math.sin(pangle*math.pi/180))
    Player.MoveTo(px, py)
    Player.sprite.rotation = math.deg(math.atan2(0 - Player.y, 0 - Player.x)) + 90
    if spawntimer >= 1800 and spawntimer%90==0 then 
        sspeed = -sspeed
        
    elseif spawntimer%600 == 0 then
        --Bullettimer = BulletTimer - 5
        local angle = 0 + offset
        local posx = 200*(math.cos(angle*math.pi/180))
        local posy = 200*(math.sin(angle*math.pi/180))
        --local timer = BulletTimer
        local bullet = CreateProjectile('bullets/spr_clubsbullet', posx, posy)
        bullet.sprite.rotation = math.deg(math.atan2(0 - bullet.y, 0 - bullet.x))
        bullet.SetVar('angle', angle)
        bullet.SetVar('timer', timer)
        table.insert(bulletspawns, bullet)
        offset = offset + 360/3
    end
    spawntimer = spawntimer + 1
    if spawntimer%1 == 0 then
        for i=1, #bulletspawns do
            if math.random(1,1) == 1 then
                local sbullet = bulletspawns[i]
                local angle = sbullet.GetVar('angle')
                local posx = 200*(math.cos(angle*math.pi/180))
                local posy = 200*(math.sin(angle*math.pi/180))
                --shoot
                local bullet = CreateProjectile('bullets/spr_clubsbullet', posx, posy)
                bullet.SetVar('timer', 70)
                bullet.sprite.Scale(0.3,  0.3)
                table.insert(bullets, bullet)
            end
        end
    end
    for i=1,#bulletspawns do
        --get bullet move info
        local sbullet = bulletspawns[i]
        local angle = sbullet.GetVar('angle')
        angle = angle + sspeed
        local posx = 200*(math.cos(angle*math.pi/180))
        local posy = 200*(math.sin(angle*math.pi/180))
        sbullet.SetVar('angle', angle)
        sbullet.sprite.rotation = math.deg(math.atan2(0 - sbullet.y, 0 - sbullet.x))
        sbullet.MoveTo(posx, posy)
    end



    for i=#bullets, 1, -1 do
        local bullet = bullets[i]
        if bullet.isactive then
            local velx = bullet.x
            local vely = bullet.y
            --normalize vector
            local Len = math.sqrt(math.pow(velx, 2) + math.pow(vely, 2))
            velx = (velx/Len)*speed*-1
            vely = (vely/Len)*speed*-1

            local newposx = bullet.x + velx
            local newposy = bullet.y + vely
            bullet.sprite.rotation = math.deg(math.atan2(0 - bullet.y, 0 - bullet.x))
            if bullet.GetVar('timer') <= 0 then
                bullet.remove()
                table.remove(bullets, i)
            else 
                bullet.SetVar('timer', bullet.GetVar('timer') -1)
                bullet.MoveTo(newposx, newposy)
            end
        end
    end
end
