-- The bouncing bullets attack from the documentation example.
spawntimer = 0
bullets = {}
speed = 1
function Update()
    spawntimer = spawntimer + 1
    if spawntimer%15 == 0 then
        local posx = Arena.height + 30
        local posy = Arena.height/2
        for i=1,math.random(12),1 do 
            local dir = math.random(160, 200)
            local bullet = CreateProjectile('bullets/spr_diamondbullet')
            --get slope depending on direction
            local DeltaY = math.tan(dir*(math.pi/180))*speed
            local bullet = CreateProjectile('bullet', posx, posy)
            bullet.SetVar('velx', speed)
            bullet.SetVar('vely', DeltaY)
            table.insert(bullets, bullet)
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