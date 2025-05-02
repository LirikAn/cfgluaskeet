local language_selector = ui.new_combobox("MISC", "Settings", "TT lang", {"Русский", "English"})

local messages = {
    ["Русский"] = {
        headshot = {
            "когда твоя мать заходит в море это называеться tsunami",
            "спотлайт спотлайт",
            "посмеялся? теперь *dead* далбаеб жирный",
            ",mora хiт ю на 1001011 0101 хп у моры осталось жизня 2292020202",
            "ЯРУССКИЙ на 3 сдал",
            "ты духовно до меня еще не созрел",
            "я на очке твоей матери форсаж 15 снимал",
            "единичкой упал пидарас",
            "Re_solved",
            "De_stroyed",
            "мне за такие киллы щас вак прилетит",
            "все хейтеры становятьсЯ фанатами guns.lol/itsmora",
            "https://discord.gg/TrgzQtuY5S"
        },
        knife = {
            "СВИНЬЮ НА КЛЫК ААХАХАХХАХАХА",
            "ДАЛБАЕБИНА MOVE=wasd",
            "глаза открой не видишь что я на тебя лечу",
            "антиаимы от мишы анхитбл https://discord.gg/TrgzQtuY5S",
            "наверное это было больно, СЛАВА МИШЕ Я ЭТО НЕ ПОЧУВСТВУЮ ЗАЗАЗАЗАХАХХАХАХ"
        },
        bodyshot = {
            "на тело принял,да ты ебаный далбаеб",
            "то что ты спрятал еблище ни чем не поможет",
            "на по пузу клоун",
            "вьебал по ножке",
            "я же в тело попал,ты как помер ебанько",
            "фанат вот мой дс @russianassist",
            "https://discord.gg/TrgzQtuY5S"
        }
    },
    ["English"] = {
        headshot = {
            "your mom causes a tsunami when she swims",
            "spotlight, spotlight",
            "laughed? now *dead* u funny n1gger",
            "i hit you for 1001011 0101 hp,and survived with 2292020202 hp",
            "I failed Russian with a f",
            "you’re not spiritually mature enough to face me",
            "I filmed Fast & Furious 15 on your mom's pussy btw",
            "u just *dead* from 1 bullet xd",
            "https://discord.gg/TrgzQtuY5S"
        },
        knife = {
            "PIG STABBED AHAHAHAHA",
            "MOVE=wasd you n!gga",
            "open your eyes, I'm flying at you",
            "anti-aims by Misha — unhitble https://discord.gg/TrgzQtuY5S",
            "that probably hurt, praise Misha, I won’t feel it AHAHAHAHAAHHA"
        },
        bodyshot = {
            "tanked it like a real pig",
            "did u just died from baim lol",
            "go watch my bio fan guns.lol/itsmora",
            "i dont hear u cuz ur mom so loud rn",
            "i just hit u for 10010101010 101010011 in body lol",
            "https://discord.gg/TrgzQtuY5S"
        }
    }
}

local used_messages = {}

local function get_unique_message(tbl)
    local available = {}
    for _, msg in ipairs(tbl) do
        if not used_messages[msg] then
            table.insert(available, msg)
        end
    end

    if #available == 0 then
        used_messages = {}
        available = tbl
    end

    local msg = available[client.random_int(1, #available)]
    used_messages[msg] = true
    return msg
end

client.set_event_callback("player_death", function(event)
    local local_player = entity.get_local_player()
    if not local_player then return end

    local attacker = client.userid_to_entindex(event.attacker)
    local victim = client.userid_to_entindex(event.userid)
    local victim_name = entity.get_player_name(victim)

    if attacker ~= local_player or victim == local_player then return end

    local weapon = event.weapon or ""
    local headshot = event.headshot or false
    local lang = ui.get(language_selector)

    local category
    if weapon:find("knife") then
        category = "knife"
    elseif headshot then
        category = "headshot"
    else
        category = "bodyshot"
    end

    local msg = get_unique_message(messages[lang][category])
    client.exec('say "' .. victim_name .. ', ' .. msg .. '"')
end)
local clantag_clock_enabled = ui.new_checkbox("MISC", "Settings", "Enable clock clantag")

local last_time = ""

client.set_event_callback("paint", function()
    if not ui.get(clantag_clock_enabled) then return end

    local time = os.date("%H:%M:%S")

    if time ~= last_time then
        client.set_clan_tag(time)
        last_time = time
    end
end)
