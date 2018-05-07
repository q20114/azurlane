-- last updated: 2018/5/7

-- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
Settings:set("MinSimilarity", 0.7)

-- ==========  main program ===========

wait(1)
execute=true
avoidRegion = Region(803, 273, 180, 180)
clearRegion = Region(270, 450, 200, 100)
touchRegion = Pattern("touch.png"), Region(573, 482, 200, 200)
heal1Region = Region(1200, 330, 100, 100)
heal2Region = Region(1200, 330, 100, 100)
tukau = Pattern("tukau.png"), Region(1200, 330, 100, 100)
touchRegion = Region(573, 482, 200, 200)
A3Region =  Region(180, 260, 180, 150)
G3Region =  Region(980, 330, 180, 150)
autocheckRegion =  Pattern("autocheck.png"):similar(0.9),Region(110, 70, 150, 100)
attack = Pattern("attack.png"), Region(976, 526, 200, 200)
change = Pattern("change.png"), Region(1200, 330, 100, 100)
war = Pattern("war.png"):similar(0.8), Region(990, 350, 230, 120)
confirmRegion = Pattern("confirm.png") ,Region Region(537, 390, 180, 180)
team1Region = Pattern("team1.png"):similar(0.9) ,Region(120, 40, 200, 100)
team2Region = Pattern("team2.png"):similar(0.9) ,Region(120, 40, 200, 100)


function avoid() -----迴避伏擊
    if (avoidRegion:exists("avoid.png",0))
    then
        click(getLastMatch())
    end
end
function clear() ---戰鬥完成後的處理
    if (clearRegion:exists("clear.png",0))
    then
        click(Location(270, 650))
        wait(1)
        click(Location(270, 650))
        wait(3)
        click(Location(1100, 610))
        wait(4)
        click(Location(1100, 610))
        wait(3)
        i = 20
    end
end
function heal() -----應急
    if (heal2Region:exists("heal2.png",0))
    then
        click(getLastMatch())
        wait(1.5)
        click("tukau.png")

    else if (heal1Region:exists("heal1.png",0))
       then
       click(getLastMatch())
        wait(1.5)
        click("tukau.png")
    end
    end
end
function checkA3() -----檢查到左邊問號的順利
    while not (A3Region:exists("space.png",0))
    do
        getLastMatch():highlight(1)
        click(getLastMatch())
        wait(1.5)
    end
end
function touch() ----拾獲道具確認
    if (touchRegion:exists("touch.png",0))
    then
        click(getLastMatch())
        wait(1)
        i=i+1
    end
end

function battle() -----出擊確認
    if exists(autocheckRegion)
    then
        print("自動沒開")
        click(getLastMatch())
        wait(1)
        click(attack)
        wait(0.5)
        click(attack)
        print("出擊")
        wait(0.5)
        for i = 1, 20, 1 do
            clear()
            wait(5)
        end

    else
        print("自動已開")
        click(attack)
        print("出擊")
        wait(0.5)
        for i = 1, 20, 1 do
            clear()
            wait(5)
        end
    end
end
function BOSS() ----確認BOSS出現並由二隊前往
    print("BOSS出現")
    click(change) ---切換隊伍
    print("切換隊伍")
    if exists(team1Region)
    then
        BOSS()
    else

        while (exists(team2Region) and exists(Pattern("BOSS.png"):similar(0.6)))
        do
            print("條件符合")
            click(getLastMatch())
            wait(2)
            for i = 1, 5, 1 do
                avoid()
                touch()
            end
            battle()
        end
    end
end
function confirm()
    if exists(confirmRegion)
    then
        click(getLastMatch())
    end
end

function gomark() --撿問號
    while not (G3Region:exists("space.png",0)) -----確保第二隊到7-2王點
    do
        click(getLastMatch())
        wait(2)
        for i = 1, 5, 1 do
            avoid()
            touch()
        end
        battle()
    end
    while (exists(Pattern("mark.png")))
        do
end
function goBB()
    if exists(team1Region)
    then
        if exists(Pattern("2BB.png"):similar(0.6))
        then
            print("一個2BB")
            for i = 1, 4, 1 do
                click(getLastMatch())
                wait(2)
                avoid()
                touch()
            end
            battle()
        elseif exists(Pattern("3BB.png"):similar(0.6))
        then
            print("一個3BB")
            for i = 1, 4, 1 do
                click(getLastMatch())
                wait(2)
                avoid()
                touch()
            end
            battle()
        elseif exists(Pattern("1BB.png"):similar(0.6))
        then
            print("一個1BB")
            for i = 1, 4, 1 do
                click(getLastMatch())
                wait(2)
                avoid()
                touch()
            end
            battle()
        elseif exists(Pattern("2DD.png"):similar(0.6))
        then
            print("一個2DD")
            for i = 1, 4, 1 do
                click(getLastMatch())
                wait(2)
                avoid()
                touch()
            end
            battle()
        end
    else
        click(change) ---切換隊伍
    end
end
function goDD()

end
function goCV()

end


function chp72()--選擇7-2

end
while(execute)
    do
    if (exists(Pattern("BOSS.png"):similar(0.6)))
    then
        BOSS()
    elseif (exists(Pattern("mark.png")))
    then
        gomark()
    elseif (exists(Pattern("BB.png")))
    then
        goBB()
    elseif (exists(Pattern("CV.png")))
    then
         goCV()
    else if(exists(pattern("DD.png")))
    then
        goDD()
    else if exists(confirmRegion)
    then
        confirm()
    else
        cho72()
    end
end




--if exists(war)
--then
--    click(war)
--end

--print("OK")