local i = 0
function RegisterDoor(door, yA)
    local DoorHash = "ClippyDoor" .. (yA and "PEM_" or "") .. (door.id or i)
    if not IsDoorRegisteredWithSystem(DoorHash) then
        local DoorPos = door.pos or door.position
        AddDoorToSystem(DoorHash, door.model, DoorPos.x, DoorPos.y, DoorPos.z, false, false, false)
    end
    door.hash = DoorHash;
    i = i + 1
end
local function LockDoor(door, bool)
    DoorSystemSetDoorState(door.hash, bool and 1 or 0, false, false)
end
function DoorInitialize()
    for k, v in pairs(Properties.Doors) do
        RegisterDoor(v, true)
    end
    for k, v in pairs(Properties.Doors) do
        LockDoor(v, true)
    end
end

DoorInitialize()
