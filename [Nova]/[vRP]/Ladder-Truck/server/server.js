onNet("TL:emitTLdict", (dict) => {
    emitNet("TL:requestTLdict", -1, dict);
})

onNet("TL:syncExtraEmit", (nid, extraId, state) => {
    emitNet("TL:syncExtraReturn", -1, nid, extraId, state);
})

onNet("TL:uploadTLentry", (nid, entry) => {
    emitNet("TL:emitTLentry", -1, nid, entry);
})

onNet("TL:deleteTL", (nid) => {
    emitNet("TL:deleteTLobjs", -1, nid);
})

onNet("TL:playSoundEmit", (nid, type, soundOrigin, open) => {
    emitNet("TL:playSoundReturn", -1, nid, type, soundOrigin, open);
})