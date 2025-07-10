-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Jevil is shuffling the cards.", "You feel dizzy."}
commands = {"Draw Card"}
randomdialogue = {"THE WORLD IS SPINNING,\n SPINNING"}

sprite = "spr_joker_main_0" --Always PNG. Extension is added automatically.
name = "Jevil"
hp = 1125
atk = 4
def = 8
check = "1125 HP 4 ATK 8 DEF\n Can do anything."
dialogbubble = "right" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
monstersprite.xscale = 2
monstersprite.yscale = 2

-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
    else
        -- player did actually attack
    end
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "DRAW CARD" then
        local CurrentRank = Encounter.GetVar('CurrentRank')+1
        if Player.speed >= 150 then 
            BattleDialog({"You're already at the highest speed."})
        else
            currentdialogue = {"TIME TO UP THE\n STAKES!"}
            BattleDialog({"Your speed increased. Jevil's\nattacks got harder this turn."})
            Encounter.SetVar('CurrentRank', 5)
            Player.speed = Player.speed + 10
        end
    end
end