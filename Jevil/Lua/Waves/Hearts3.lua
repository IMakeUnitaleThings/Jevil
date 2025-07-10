-- The bouncing bullets attack from the documentation example.
spawntimer = 0
bullets = {}
speed = 3
bspeed = 5
function Update()
    spawntimer = spawntimer + 1
    speed = speed + .005
    if spawntimer%30 == 0 then
        for i=1,1,2 do
            --create equation for circle
            local angle = math.random(360)
            local radius = 50
            local posx = Player.x + radius*(math.cos(angle*(math.pi/180)))
            local posy = Player.y + radius*(math.sin(angle*(math.pi/180)))

            local bullet = CreateProjectile('bullets/spr_heartbullet', posx, posy)
            bullet.SetVar('angle', angle)
            bullet.SetVar('radius', radius)
            bullet.SetVar('timer1', math.random(30,  45))
            bullet.SetVar('timer2', 20)

            bullet.sprite.xscale = 0.75
            bullet.sprite.yscale = 0.75
            table.insert(bullets, bullet)
        end


    end
    
    for i=1,#bullets do
        local bullet = bullets[i]
        local angle = bullet.GetVar('angle')
        local radius = bullet.GetVar('radius')
        local timer1 = bullet.GetVar('timer1')
        local timer2 = bullet.GetVar('timer2')

        if timer1 > 0 then 
            bullet.SetVar('timer1', timer1-1)
            angle = angle + speed
            bullet.SetVar('angle', angle)
            local newposx = Player.x + radius*(math.cos(angle*math.pi/180))
            local newposy = Player.y + radius*(math.sin(angle*math.pi/180))
            bullet.MoveTo(newposx, newposy)
            bullet.sprite.rotation = math.deg(math.atan2(Player.y - bullet.y, Player.x - bullet.x)) + 90
            
        elseif timer1 == 0 then 
            bullet.sprite.rotation = math.deg(math.atan2(Player.y - bullet.y, Player.x - bullet.x)) + 90
            bullet.SetVar('timer1', timer1-1)
            --save bullet info
            bullet.SetVar('bx', bullet.x)
            bullet.SetVar('by', bullet.y)
            --save player info 
            bullet.SetVar('px', Player.x)
            bullet.SetVar('py', Player.y)
            bullet.sprite.color = {.427,.427,.753}
        elseif timer2 >= 0 then 
            bullet.SetVar('timer2', timer2-1)


        elseif timer2 <= 0 then 
            local velx = bullet.GetVar('bx')- bullet.GetVar('px')
            local vely = bullet.GetVar('by') - bullet.GetVar('py')
            --normalize vector
            Len = math.sqrt(math.pow(velx, 2) + math.pow(vely, 2))
            velx = (velx/Len)*bspeed*-1
            vely = (vely/Len)*bspeed*-1


            local newposx = bullet.x + velx
            local newposy = bullet.y + vely
            bullet.MoveTo(newposx, newposy)
        end

    end
end