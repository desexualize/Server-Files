function GetLicense(userInformations)
    for i = 1, #userInformations, 1 do
        if string.sub(userInformations[i], 1, string.len("license:")) == "license:" then
            return userInformations[i]
        end
    end
end