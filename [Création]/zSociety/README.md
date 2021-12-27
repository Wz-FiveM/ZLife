[Preview](https://youtu.be/zAdmgCs61hQ)

[Discord - Shop](https://discord.gg/msqgkqY5Wz)

[Discord](https://discord.gg/fcrvNbgazk)

## IMPORTANT

Edit this in es_extended/server/paycheck.lua

```lua
TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)

to 

TriggerEvent('zSociety:getSociety', xPlayer.job.name, function (society)
```

## sh_config.lua

Language = "fr" <!-- Choose your language -->

```lua
--[[ The compulsory base ]]

--[[ This is the obligatory basis for the proper functioning of a company ]]
{
    pos = vector3(--[[ Position X ]], --[[ Position Y ]], --[[ Position Z ]]),
    name = "jobname", --[[ The job name  ]]
    label = "Label Of Job", --[[ The job label ]]
    salary_max = 5000, --[[ The maximum salary in relation to grades ]]
    options = {
        money = true, 
        wash = false, 
        employees = true, 
        grades = true
    },
},

--[[ All the arguments ]]

--[[ Some arguments are not mandatory for the proper functioning of your company ]]

{
    pos = vector3(--[[ Position X ]], --[[ Position Y ]], --[[ Position Z ]]),
    name = "jobname", --[[ The job name  ]]
    label = "Label Of Job", --[[ The job label ]]
    salary_max = 5000, --[[ The maximum salary in relation to grades ]]
    
    percent = 50, --[[ if wash = true ]] --[[ Percentage that the player receives from the amount he enters during the laundering ]] 

    options = {
        money = true, 
        wash = false, 
        employees = true, 
        grades = true
    },

    blip = {
        label = "Blip Label", 
        id = 1,                --[[ if you want to add a blip at the position shown above ]]
        color = 1,
        scale = 1.0
    },
},
```

## sv_config.lua

```lua

Webhooks = "Your Webhooks Link",

Avatar = "Your Username Avatar",

Color = "16777215", -- https://gist.github.com/thomasbnt/b6f455e2c7d743b796917fa3c205f812

Footer = "Your Text",

Footer_URL = "Your Picture",


--[[ Turn false if you want to remove this information from the log ]]
Discord = true,
License = true,
Steam = true,
Ip = false,
```
