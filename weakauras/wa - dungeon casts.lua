function(...)
    local s = aura_env.state

    if not s.interruptible -- and not UnitIsUnit(tostring(s.sourceUnit), 'focus') then
        return false
    end

    print(' -- ')
    print( ('sourceName: %s; castName: %s; interruptible: %s; isFocus: %s'):format(tostring(s.sourceName), tostring(s.name), tostring(s.interruptible), tostring(UnitIsUnit(tostring(s.sourceUnit), 'focus'))) )

    local castFinish = aura_env.states[1].expirationTime
    local kickReady = aura_env.states[2].expirationTime

    print( ('%s - %s = %s'):format(tostring(castFinish), tostring(kickReady), tostring(castFinish - kickReady)) )

    print( ('aura_env.region: %s'):format( tostring(aura_env.region) ))
    print( ('aura_env.region.bar: %s'):format( tostring(aura_env.region.bar) ))
    print( ('aura_env.region.bar.bg: %s'):format( tostring(aura_env.region.bar.bg) ))

    print(' -- ')

    return (castFinish - kickReady) > 0
end


-- local dbgStr = ''
-- dbgStr = dbgStr .. 'sourceUnit: ' .. tostring(s.sourceUnit)) .. '; '
-- dbgStr = dbgStr .. 'interruptible: ' .. tostring(s.interruptible)) .. '; '
-- dbgStr = dbgStr .. 'isFocus: ' .. tostring(UnitIsUnit(tostring(s.sourceUnit), 'focus'))) .. '; '
-- print(dbgStr)

-- local dbgStr = ''
-- dbgStr = dbgStr .. 'castFinish: ' .. tostring(castFinish) .. '; '
-- dbgStr = dbgStr .. 'intrpReady: ' .. tostring(kickReady) .. '; '
-- dbgStr = dbgStr .. 'int avail in time? ' .. tostring(castFinish - kickReady) .. '; '
-- print(dbgStr)


-- kickReady == 0 -> color
-- castFinish - kickReady > 0 -> will be up before cast finishes
-- castFinish - kickReady < 0 -> not avail in time 

--[[
local tblStr = 'states[1]: { '
for k,v in pairs(aura_env.states[1]) do
    tblStr = tblStr .. '"' .. k .. '": ' .. tostring(v) .. ', '
end
tblStr = tblStr .. ' }'
print(tblStr)

local tblStr = 'states[2]: { '
for k,v in pairs(aura_env.states[2]) do
    tblStr = tblStr .. '"' .. k .. '": ' .. tostring(v) .. ', '
end
tblStr = tblStr .. ' }'
print(tblStr)
--]]


function(...)
    local s = aura_env.state
    local isFocus = UnitIsUnit(tostring(s.sourceUnit), 'focus')

    print(' --- ')
    print('interrupt: %b', s.interruptible)
    print('isFocus: %b', isFcous)
    print('cond: ', (not s.interruptible and not isFocus))

    print('sourceName: ', tostring(s.sourceName), ' | castName: ', s.name, ' | interruptible: ', s.interruptible, ' | isFocus: ', isFocus)

    print( ('sourceName: %s; castName: %s; interruptible: %s; isFocus: %s'):format(tostring(s.sourceName), tostring(s.name), tostring(s.interruptible), tostring(UnitIsUnit(tostring(s.sourceUnit), 'focus'))) )

    if not s.interruptible then -- and not UnitIsUnit(tostring(s.sourceUnit), 'focus') then
        return false
    end

    local castFinish = aura_env.states[1].expirationTime
    local kickReady = aura_env.states[2].expirationTime

    local bgColor
    if kickReady == 0 then -- interrupt ready
        bgColor = {r=178, g=121, b=193, a=1}
    elseif (castFinish - kickReady) > 0 then -- interrupt on cd but will be up before cast finishes
        bgColor = {r=0, g=121, b=193, a=1}
    elseif (castFinish - kickReady) < 0 then -- interrupt on cd and will not be ready in time
        bgColor = {r=178, g=121, b=0, a=1}
    end
    WeakAuras.GetRegion(aura_env.id):SetBackgroundColor(bgColor.r, bgColor.g, bgColor.b, bgColor.a)

    return (castFinish - kickReady) > 0
end




function(...)
    local s = aura_env.state
    local isFocus = UnitIsUnit(tostring(s.sourceUnit), 'focus')

    -- print(' --- ')
    -- print('sourceName: ', tostring(s.sourceName), ' | castName: ', s.name, ' | interruptible: ', s.interruptible, ' | isFocus: ', isFocus)

    if not s.interruptible or not isFocus then
        -- print('not int and not focus')
        return false
    end
    local kickReady = aura_env.states[2].expirationTime
    local castFinish = aura_env.states[1].expirationTime

    return kickReady == 0
end







function(...)
    local s = aura_env.state
    if not s.interruptible or not UnitIsUnit(tostring(s.sourceUnit), 'focus') then
        return false
    end

    local kickReady = aura_env.states[2].expirationTime
    local castFinish = aura_env.states[1].expirationTime
 
    return kickReady == 0
end

className, classFile, classId = UnitClass('player') -- use classFile
GetSpecialization()

aura_env.classInterrupts = {
    MONK = {
        [116705] = true -- spear hand strike
    },
    PRIEST = {
        [15487] = true -- silence
    }
}
