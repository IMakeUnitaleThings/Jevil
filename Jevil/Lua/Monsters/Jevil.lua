-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Jevil is shuffling the cards.", "The world spins and twists around you.", "Your soul aches."}
commands = {}
randomdialogue = {"THE WORLD IS SPINNING, SPINNING"}

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