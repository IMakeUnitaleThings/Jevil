-- A basic encounter script skeleton you can copy and modify for your own creations.

music = "TheWorldRevolving" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "The world spins around you." --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"Hearts2"}
wavetimer = 10
arenasize = {155, 130}
wavesdone = 0
CurrentRank = 1
Player.lv = 2
Player.hp = Player.maxhp
enemies = {
"Jevil"
}

enemypositions = {
{0, 50}
}

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"Diamonds"}

function EncounterStarting()
    AtkSet1 = {"Diamonds", "Spades", "Hearts"}
    AtkSet2 = {"Diamonds2", "Spades2", "Hearts2"}
    AtkSet3 = {"Diamonds3", "Spades3", "Hearts3"}
    AtkSet4 = {"Diamonds4", "Spades4", "Hearts4"}
    AtkSet5 = {"Diamonds5", "Spades5", "Hearts5"}
    

    for i=8,0,-1 do
        Inventory.AddItem('Dog Salad', 1)
    end
    -- If you want to change the game state immediately, this is the place.

end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    if wavesdone >= 21 then
        nextwaves = {"Finale"}
        enemies[1].SetVar('canspare', true)
    elseif CurrentRank == 6 then
        CurrentRank = 1
    elseif CurrentRank == 5 then 
        nextwaves = { AtkSet5[math.random(#AtkSet5)] }
        CurrentRank = 1
    elseif CurrentRank == 4 or wavesdone >= 15 then
        nextwaves = { AtkSet4[math.random(#AtkSet4)] }
    elseif CurrentRank == 3 or wavesdone >= 10 then
        nextwaves = { AtkSet3[math.random(#AtkSet3)] }
    elseif CurrentRank == 2 or wavesdone >= 5 then
        nextwaves = { AtkSet2[math.random(#AtkSet2)] }
    else 
        nextwaves = { AtkSet1[math.random(#AtkSet1)] }
    end
    wavesdone = wavesdone + 1
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
    BattleDialog({"Selected item " .. ItemID .. "."})
end