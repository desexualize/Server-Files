const root = GetResourcePath(GetCurrentResourceName())
var rewards = []

onNet("scptr:setRewards", (cfgRewards) => {
    rewards = cfgRewards
})

onNet("scptr:jsCheck", (src, license) => {
    let supposedPath = `${root}/playersData/${license.replace(':', '_')}`
    fs.access(supposedPath, fs.F_OK, (err) => {
        if (err) {
            fs.writeFile(supposedPath, JSON.stringify([0]), function (err) {
                if (err) throw err
            });
        }

        fs.readFile(supposedPath, 'utf8' , (err, data) => {
            if (err) throw err

            var fileData = JSON.parse(data)
            for (let i = 0; i < rewards.length; i++)
                for (let j = 0; j < fileData.length; j++)
                    if (rewards[i]["UniqueID"] == fileData[j])
                        if (rewards[i]["ClaimableMultipleTimes"])
                            fileData.splice(fileData.indexOf(fileData[j]))

            fs.writeFile(supposedPath, JSON.stringify(fileData), function (err) {
                if (err) throw err;
            });

            emitNet("ccptr:setData", src, fileData);
        })
    })
})

onNet("scptr:jsSetPlaytime", (license, src, svT, plT) => {
    let supposedPath = `${root}/playersData/${license.replace(':', '_')}`
    fs.access(supposedPath, fs.F_OK, (err) => {
        if (err) {
            fs.writeFile(supposedPath, JSON.stringify([0]), function (err) {
                if (err) throw err;
            });
        }
        
        fs.readFile(supposedPath, 'utf8' , (err, data) => {
            if (err) throw err

            var fileData

            try {
                fileData = JSON.parse(data)
            } catch (error) {
                throw `ERROR: ${error}\n At -> ${supposedPath}`;
            }
            
            fileData[0] += 10
            emitNet("ccptr:sync", src, svT - plT)
            fs.writeFile(supposedPath, JSON.stringify(fileData), function (err) {
                if (err) throw err;
            });
        })
    })
})

onNet("scptr:jsFullData", (src, license) => {
    let supposedPath = `${root}/playersData/${license.replace(':', '_')}`
    fs.readFile(supposedPath, 'utf8' , (err, data) => {
        if (err) throw err
        emitNet("ccptr:setData", src, JSON.parse(data));
        emitNet("ccptr:setupRewards", src, rewards)
    })
})

onNet("scptr:jsClaimReward", (src, license, UID, sKey) => {
    let supposedPath = `${root}/playersData/${license.replace(':', '_')}`

    fs.readFile(supposedPath, 'utf8' , (err, data) => {
        if (err) throw err
        var fileData = JSON.parse(data)
        
        let rewardPosition = -1
        for (let i = 0; i < rewards.length; i++) {
            if (rewards[i]["UniqueID"] == UID) {
                rewardPosition = i
                break
            }
        }

        let claimed = false
        for (let j = 0; j < fileData.length; j++) {
            if (UID == fileData[j]) {
                claimed = true 
                break
            }
        }

        if (!claimed) {
            fileData[fileData.length] = UID

            fs.writeFile(supposedPath, JSON.stringify(fileData), function (err) {
                if (err) throw err;
                emitNet("ccptr:reward", src, rewards[rewardPosition]["Function"], sKey)
            });
        }
    })
})