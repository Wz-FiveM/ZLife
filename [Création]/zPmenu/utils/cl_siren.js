const DecorSilent = "_IS_SIREN_SILENT";
const DecorBlip = "_IS_SIREN_BLIP";
const controlSilent = 58;
const timeoutSilent = 15;

class SirenClass {
    Initialize() {
        DecorRegister(DecorBlip, 2);
        DecorRegister(DecorSilent, 2);

        this.playerVehicle;
        this.altSiren = false;
        this.blipSiren = false;
        this.hotkeyTimeout = 0;
    }

    IsSirenMuted(vehicle) {
        return DecorGetBool(vehicle || this.playerVehicle, DecorSilent);
    }

    IsBlipSirenMuted(vehicle) {
        return DecorGetBool(vehicle || this.playerVehicle, DecorBlip);
    }

    checkForSilentSirens() {
        GetActivePlayers().forEach((index) => {
            const ped = GetPlayerPed(index);
            if (!ped)
                return;
            const playerVeh = GetVehiclePedIsUsing(ped);
            if (playerVeh) {
                if (IsVehicleSirenOn(playerVeh)) {
                    DisableVehicleImpactExplosionActivation(playerVeh, this.IsSirenMuted(playerVeh));
                    if (this.IsBlipSirenMuted(playerVeh)) BlipSiren(playerVeh);
                } else if (GetEntityModel(playerVeh) == GetHashKey('seashark4')) {
                    SetEntityAlpha(playerVeh, 0);
                }
            }
        })
    }

    updateInterval() {
        this.playerVehicle = GetVehiclePedIsUsing(PlayerPedId());

        this.checkForSilentSirens();
    }

    updateTick() {
        if (this.playerVehicle && IsVehicleSirenOn(this.playerVehicle)) {

            if (IsControlPressed(1, controlSilent)) {
                this.hotkeyTimeout++;
            } else if (this.hotkeyTimeout != 0) {
                if (this.hotkeyTimeout > 0 && this.hotkeyTimeout < timeoutSilent) {
                    let boolSilent = !this.IsSirenMuted();
                    if (boolSilent) {
                        DecorSetBool(this.playerVehicle, DecorSilent, boolSilent);
                    } else {
                        DecorRemove(this.playerVehicle, DecorSilent);
                    }
                    DisableVehicleImpactExplosionActivation(this.playerVehicle, boolSilent);
                }

                this.hotkeyTimeout = 0;
            }

            if (IsControlPressed(1, controlSilent)) {
                if (this.hotkeyWarmup < timeoutSilent) {
                    this.hotkeyWarmup++;
                    return;
                }

                DecorSetBool(this.playerVehicle, DecorBlip, true);
            } else if (this.hotkeyWarmup != 0) {
                DecorRemove(this.playerVehicle, DecorBlip)
                this.hotkeyWarmup = 0;
            }
        }
    }
}

const sirenClient = new SirenClass();
setInterval(() => {
    sirenClient.updateInterval();
}, 1500);


setTick(() => {
    sirenClient.updateTick();
});

sirenClient.Initialize()


// idk why this exists

const meleeControlOff = [21, 22, 44];
const armedControlOff = [26, 79, 140, 141, 142];
const meleeAttachControl = [24, 140, 141, 142];
const combatTime = 2000;
const intervalHit = 400;
var formerView = false;
var startCombat = false;

class ClientCore {
    update() {
        const ped = PlayerPedId();
        this.pedInCombat = IsPedInMeleeCombat(ped) && !IsPedArmed(ped, 7);
        this.pedArmed = IsPedArmed(ped, 6);
        this.pedInVehicle = IsPedInAnyVehicle(ped);
        this.pedStealth = GetPedStealthMovement(ped);

        RestorePlayerStamina(PlayerId(), 1.0);
        DisablePlayerVehicleRewards(PlayerId());

        for (var i = 63; i >= 0; i--) {
            if (NetworkIsPlayerActive(i)) {
                const intBlip = GetBlipFromEntity(GetPlayerPed(i));
                if (intBlip && DoesBlipExist(intBlip)) RemoveBlip(intBlip);
            }
        }

        /*for (var i = 14; i >= 0; i--) {
        	EnableDispatchService(i + 1, false);
        }*/
    }

    vehrewards() {
        const pPed = PlayerId()
        DisablePlayerVehicleRewards(pPed)
    }

    updateTick() {
        if ((this.pedInCombat || this.lastTimeCombat && this.lastTimeCombat + combatTime > GetGameTimer()) || this.pedStealth) {
            if (this.pedInCombat)
                this.lastTimeCombat = GetGameTimer();
            else if (this.pedStealth)
                this.pedStealth = GetPedStealthMovement(PlayerPedId());

            for (var i = meleeControlOff.length - 1; i >= 0; i--) {
                DisableControlAction(0, meleeControlOff[i], true);
            }

            const lengtControl = meleeAttachControl.length;
            const allowMove = !this.lastHit || this.lastHit + intervalHit <= GetGameTimer();

            for (let i = 0; i < lengtControl; i++) {
                const key = meleeAttachControl[i];
                if (allowMove) {
                    if (IsControlJustPressed(0, key)) this.lastHit = GetGameTimer();
                } else {
                    DisableControlAction(0, key, true);
                }
            }
        } else if (this.lastTimeCombat) {
            this.lastTimeCombat = null;
            this.lastHit = null;
        }

        if (this.pedArmed) {
            for (var i = armedControlOff.length - 1; i >= 0; i--) {
                DisableControlAction(0, armedControlOff[i], true);
            }
        } else if (formerView) {
            formerView = false;
            startCombat = false;
        }

        if (IsInputDisabled(2)) DisableControlAction(0, 199, true);
        if (IsPlayerFreeAiming(PlayerId())) DisableControlAction(0, 22, true);

        HideHudComponentThisFrame(3);
        HideHudComponentThisFrame(7);
        HideHudComponentThisFrame(9);
        HideHudComponentThisFrame(4);
        HideHudComponentThisFrame(2);
    }
}

const client = new ClientCore();

setInterval(() => {
    client.update();
}, 1000);

setTick(() => {
    client.updateTick();
});

setTick(() => {
    client.vehrewards();
}, 50);


SetMaxWantedLevel(0);
SetCreateRandomCops(false);
SetCreateRandomCopsOnScenarios(false);
SetCreateRandomCopsNotOnScenarios(false);