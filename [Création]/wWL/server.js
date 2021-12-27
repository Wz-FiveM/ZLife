//////////////////////////////////////////
//           Discord Whitelist          //
//////////////////////////////////////////

/// Config Area ///

var guild = "843043037206151168";
var botToken = "ODQ5NzEwNzE3NjA3MDg0MDYz.YLfIxQ.WpI7dI0UXKyfhKTs7YcdtPVL0X0";

var whitelistRoles = [ // Roles by ID that are whitelisted.
    "869984318255140914"
]

var blacklistRoles = [ // Roles by Id that are blacklisted.
    "845915147498946580",
    "843059992814551040"
]

var notWhitelistedMessage = "Vous n'êtes pas sur la liste blanche. Ce serveur est sur liste blanche et nécessite un accès pour rejoindre."
var noGuildMessage = "Guilde non détectée. Il semble que vous ne soyez pas dans la guilde de cette communauté."
var blacklistMessage = "Vous êtes sur liste noire de ce serveur."
var debugMode = true

/// Code ///
const axios = require('axios').default;
axios.defaults.baseURL = 'https://discord.com/api/v8';
axios.defaults.headers = {
    'Content-Type': 'application/json',
    Authorization: `Bot ${botToken}`
};
function getUserDiscord(source) {
    if(typeof source === 'string') return source;
    if(!GetPlayerName(source)) return false;
    for(let index = 0; index <= GetNumPlayerIdentifiers(source); index ++) {
        if (GetPlayerIdentifier(source, index).indexOf('discord:') !== -1) return GetPlayerIdentifier(source, index).replace('discord:', '');
    }
    return false;
}
on('playerConnecting', (name, setKickReason, deferrals) => {
    let src = global.source;
    deferrals.defer();
    var userId = getUserDiscord(src);

    setTimeout(() => {
        deferrals.update(`Hello ${name}. Votre identifiant Discord est en cours de vérification avec notre liste blanche.`)
        setTimeout(async function() {
            if(userId) {
                axios(`/guilds/${guild}/members/${userId}`).then((resDis) => {
                    if(!resDis.data) {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' ne peut pas être trouvé dans la guilde assignée et n'a pas obtenu l'accès.`);
                        return deferrals.done(noGuildMessage);
                    }
                    const hasRole = typeof whitelistRoles === 'string' ? resDis.data.roles.includes(whitelistRoles) : resDis.data.roles.some((cRole, i) => resDis.data.roles.includes(whitelistRoles[i]));
                    const hasBlackRole = typeof blacklistRoles === 'string' ? resDis.data.roles.includes(blacklistRoles) : resDis.data.roles.some((cRole, i) => resDis.data.roles.includes(blacklistRoles[i]));
                    if(hasBlackRole) {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' est sur liste noire pour rejoindre ce serveur.`);
                        return deferrals.done(blacklistMessage);
                    }
                    if(hasRole) {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' a obtenu l'accès et a passé la liste blanche.`);
                        return deferrals.done();
                    } else {
                        if(debugMode) console.log(`'${name}' with ID '${userId}' n'est pas sur la liste blanche pour rejoindre ce serveur.`);
                        return deferrals.done(notWhitelistedMessage);
                    }
                }).catch((err) => {
                    if(debugMode) console.log(`^1Il y a eu un problème avec la demande d'API Discord. L'ID de guilde et le jeton de bot sont-ils corrects?^7`);
                });
            } else {
                if(debugMode) console.log(`'${name}' n'a pas été autorisé à accéder car un identifiant Discord n'a pas pu être trouvé.`);
                return deferrals.done(`Discord was not detected. Please make sure Discord is running and installed. See the below link for a debugging process - https://docs.faxes.zone/c/fivem/debugging-discord`);
            }
        }, 0)
    }, 0)
})