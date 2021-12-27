// Show Cursor (Change cursor sprite after when cursor is hover an entity ...)
// SetMouseCursorActiveThisFrame()
// Disable Camera Movement
// DisableControlAction(0, 1)
// DisableControlAction(0, 2)
// DisableControlAction(0, 4)
// DisableControlAction(0, 5)
// Disable Attack & Aim
// DisableControlAction(0, 24)
// DisableControlAction(0, 25)
// let x = GetControlNormal(0, 239);
// let y = GetControlNormal(0, 240);

class ContextMenuClass {
    constructor() {
        this.IsActive = false;
        this.IsLocked = false;
        this.Tick = null;
        this.LastRaycast = GetGameTimer();
        this.RaycastDatas = {};
        this.LastEntity = null;
        this.CloseOnUnlock = false;
        this.LastClick = null;
        // 2 Vehicle + 8 Peds + 16 Objects
        this.DefaultRaycastFlag = 26;
        // To use with other system than menu like selecting a player for give option in inventory ...
        this.RaycastFlag = null;
        this.ClickedCallbackName = "";
        this.DisableOnClick = false;
    }

    Toggle(force = null, isKey = false, flag = null, onEntityClicked = null, disableOnClick = false) {
        if (!isKey && this.IsLocked) {
            if (force == false || this.IsActive) {
                this.CloseOnUnlock = true;
            }
            return;
        }
        this.CloseOnUnlock = false;
        if (force !== null) {
            this.IsActive = !this.IsActive;
        } else {
            this.IsActive = force;
        }
        emit("offline:contextMenuStateChanged", this.IsActive);
        this.RaycastFlag = this.DefaultRaycastFlag;
        if (flag != null)
            this.RaycastFlag = flag
        if (onEntityClicked != null)
            this.ClickedCallbackName = onEntityClicked;
        this.DisableOnClick = disableOnClick;
        if (this.IsActive)
            this.Enable();
        else
            this.Disable();
    }

    Enable() {
        SetCursorLocation(.5, .5);
        this.Tick = setTick(() => {
            if (!this.IsActive)
                return clearTick(this.Tick);
            // Show Cursor (Change cursor sprite after when cursor is hover an entity ...)
            if (!this.IsLocked)
                SetMouseCursorActiveThisFrame();
            // Disable Camera Movement
            DisableControlAction(0, 1);
            DisableControlAction(0, 2);
            DisableControlAction(0, 4);
            DisableControlAction(0, 5);
            // Disable Attack & Aim
            DisableControlAction(0, 24);
            DisableControlAction(0, 25);

            if (this.LastRaycast + 100 <= GetGameTimer()) {
                //22
                let [
                    [_, hit, coords, surface, entity], mouseWorldPos
                ] = screenToWorld(this.RaycastFlag, -1);
                this.RaycastDatas = {
                    hit,
                    coords: hit ? coords : mouseWorldPos,
                    surface,
                    entity
                };
                // DrawMarker(28, coords[0], coords[1], coords[2], 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 0, 0, 255, false, false, 0, false)
                // console.log(hit, coords, surface, entity)
                this.LastRaycast = GetGameTimer();
            }
            if (!this.IsLocked && this.RaycastDatas.entity != 0) {
                SetMouseCursorSprite(4);
            } else {
                SetMouseCursorSprite(1);
            }
            if (!this.IsLocked) {
                if (this.LastEntity != this.RaycastDatas.entity) {
                    if (this.LastEntity != null)
                        SetEntityAlpha(this.LastEntity, 255, 0);
                    if (this.RaycastDatas.entity != null)
                        SetEntityAlpha(this.RaycastDatas.entity, 200, 0);
                    this.LastEntity = this.RaycastDatas.entity | null;
                }

                if (IsDisabledControlJustPressed(0, 24)) {
                    if (this.ClickedCallbackName != "") {
                        emit("offline::contextmenu:customClickCallback", this.RaycastDatas);
                        if (this.DisableOnClick)
                            this.Disable();
                        return;
                    }
                    if (!this.LastClick) {
                        this.LastClick = setTimeout(() => {
                            emit("offline::contextmenu:click", 1, this.RaycastDatas);
                            this.LastClick = null;
                        }, 250);
                    } else {
                        clearTimeout(this.LastClick);
                        this.LastClick = null;
                        emit("offline::contextmenu:click", 3, this.RaycastDatas);
                    }
                } else if (IsDisabledControlJustPressed(0, 25)) {
                    emit("offline::contextmenu:click", 2, this.RaycastDatas);
                }
            }
        });
    }

    Disable() {
        if (this.Tick != null)
            clearTick(this.Tick);
        if (this.IsLocked)
            this.IsLocked = false;
        this.Tick = null;
        this.RaycastDatas = {};
        if (this.LastEntity != null) {
            SetEntityAlpha(this.LastEntity, 255, 0);
            this.LastEntity = null;
        }
        // reset values in case
        this.RaycastFlag = null;
        this.ClickedCallbackName = "";
    }

    SetLocked(val) {
        this.IsLocked = val;
    }
}

const ContextMenu = new ContextMenuClass();

function mulNumber(vector1, value) {
    var result = {};
    result.x = vector1.x * value;
    result.y = vector1.y * value;
    result.z = vector1.z * value;
    return result;
}

function toVector3(arr) {
    return {
        x: arr[0],
        y: arr[1],
        z: arr[2]
    }
}

// Add one vector to another.
function addVector3(vector1, vector2) {
    if (vector1 instanceof Array)
        vector1 = toVector3(vector1);
    if (vector2 instanceof Array)
        vector2 = toVector3(vector2);
    return {
        x: vector1.x + vector2.x,
        y: vector1.y + vector2.y,
        z: vector1.z + vector2.z
    };
}

// Subtract one vector from another.
function subVector3(vector1, vector2) {
    if (vector1 instanceof Array)
        vector1 = toVector3(vector1);
    if (vector2 instanceof Array)
        vector2 = toVector3(vector2);
    return {
        x: vector1.x - vector2.x,
        y: vector1.y - vector2.y,
        z: vector1.z - vector2.z
    };
}

function rotationToDirection(rotation) {
    if (rotation instanceof Array)
        rotation = toVector3(rotation);
    let z = degToRad(rotation.z);
    let x = degToRad(rotation.x);
    let num = Math.abs(Math.cos(x));

    let result = {};
    result.x = -Math.sin(z) * num;
    result.y = Math.cos(z) * num;
    result.z = Math.sin(x);
    return result;
}

function w2s(position) {
    let result = GetScreenCoordFromWorldCoord(
        position.x,
        position.y,
        position.z,
        undefined,
        undefined
    );

    if (!result[0]) {
        return undefined;
    }

    let newPos = {};
    newPos.x = (result[1] - 0.5) * 2;
    newPos.y = (result[2] - 0.5) * 2;
    newPos.z = 0;
    return newPos;
}

function processCoordinates(x, y) {
    var res = GetActiveScreenResolution(0, 0);
    let screenX = res[0];
    let screenY = res[1];

    let relativeX = 1 - (x) * 1.0 * 2;
    let relativeY = 1 - (y) * 1.0 * 2;

    if (relativeX > 0.0) {
        relativeX = -relativeX;
    } else {
        relativeX = Math.abs(relativeX);
    }

    if (relativeY > 0.0) {
        relativeY = -relativeY;
    } else {
        relativeY = Math.abs(relativeY);
    }

    return { x: relativeX, y: relativeY };
}

function s2w(camPos, relX, relY) {
    let camRot = GetGameplayCamRot(0);
    let camForward = rotationToDirection(camRot);
    let rotUp = addVector3(camRot, { x: 10, y: 0, z: 0 });
    let rotDown = addVector3(camRot, { x: -10, y: 0, z: 0 });
    let rotLeft = addVector3(camRot, { x: 0, y: 0, z: -10 });
    let rotRight = addVector3(camRot, { x: 0, y: 0, z: 10 });

    let camRight = subVector3(
        rotationToDirection(rotRight),
        rotationToDirection(rotLeft)
    );
    let camUp = subVector3(rotationToDirection(rotUp), rotationToDirection(rotDown));

    let rollRad = -degToRad(camRot[1]);

    let camRightRoll = subVector3(
        mulNumber(camRight, Math.cos(rollRad)),
        mulNumber(camUp, Math.sin(rollRad))
    );
    let camUpRoll = addVector3(
        mulNumber(camRight, Math.sin(rollRad)),
        mulNumber(camUp, Math.cos(rollRad))
    );

    let point3D = addVector3(
        addVector3(addVector3(camPos, mulNumber(camForward, 10.0)), camRightRoll),
        camUpRoll
    );

    let point2D = w2s(point3D);

    if (point2D === undefined) {
        return addVector3(camPos, mulNumber(camForward, 10.0));
    }

    let point3DZero = addVector3(camPos, mulNumber(camForward, 10.0));
    let point2DZero = w2s(point3DZero);

    if (point2DZero === undefined) {
        return addVector3(camPos, mulNumber(camForward, 10.0));
    }

    let eps = 0.001;

    if (
        Math.abs(point2D.x - point2DZero.x) < eps ||
        Math.abs(point2D.y - point2DZero.y) < eps
    ) {
        return addVector3(camPos, mulNumber(camForward, 10.0));
    }

    let scaleX = (relX - point2DZero.x) / (point2D.x - point2DZero.x);
    let scaleY = (relY - point2DZero.y) / (point2D.y - point2DZero.y);
    let point3Dret = addVector3(
        addVector3(
            addVector3(camPos, mulNumber(camForward, 10.0)),
            mulNumber(camRightRoll, scaleX)
        ),
        mulNumber(camUpRoll, scaleY)
    );

    return point3Dret;
}

function degToRad(deg) {
    return (deg * Math.PI) / 180.0;
}

// Get entity, ground, etc. targeted by mouse position in 3D space.
function screenToWorld(flags, ignore) {
    let x = GetControlNormal(0, 239);
    let y = GetControlNormal(0, 240);

    let absoluteX = x;
    let absoluteY = y;

    let camPos = GetGameplayCamCoord();
    let processedCoords = processCoordinates(absoluteX, absoluteY);
    // let processedCoords = {x: absoluteX, y: absoluteY};
    let target = s2w(camPos, processedCoords.x, processedCoords.y);

    let dir = subVector3(target, camPos);
    let from = addVector3(camPos, mulNumber(dir, 0.05));
    let to = addVector3(camPos, mulNumber(dir, 300));

    let ray = StartShapeTestRay(
        from.x,
        from.y,
        from.z,
        to.x,
        to.y,
        to.z,
        flags,
        ignore,
        0
    );
    return [GetShapeTestResult(ray), to];
}

RegisterKeyMapping('+contextmenu', 'Menu Contextuel', 'keyboard', 'GRAVE');

RegisterCommand('+contextmenu', function() {
    ContextMenu.Toggle(true)
});

RegisterCommand('-contextmenu', function() {
    ContextMenu.Toggle(false, true)
});

on("offline::contextmenu:forceStart", () => {
    ContextMenu.Toggle(true);
});

on("offline::contextmenu:forceClose", () => {
    ContextMenu.Toggle(false);
});

on("offline::contextmenu:lock", () => {
    ContextMenu.SetLocked(true);
});

on("offline::contextmenu:unlock", () => {
    ContextMenu.SetLocked(false);
    if (ContextMenu.CloseOnUnlock) {
        ContextMenu.Toggle(false);
    }
});