main = {
    -- Set damageLevel to 100.0 to activate airbags when the vehicle is no longer drivable
    -- This is recommended to stay between 700 - 999.0
    -- Vehicles start at 1000.0 damage level - then gradually reduce
    damageLevel = 960.0,
    -- This is the amount of seconds before the airbags automatically disappear - the /airbag command one does not disappear
    -- If you set this to -1, all airbags will stay forever, even when the vehicle is deleted (so I recommend making these expire)
    secondsToExpire = 50,
    modelName = `prop_car_airbag`,
    exemptVehicleClasses = {8, 16, 15, 13},
    exemptVehicleModels = {`police`, `police2`}
}

-- We do not recommend editing the below section
dev = {
    boneIndex1 = "seat_dside_f",
    boneIndex2 = "seat_pside_f",
    offSet1 = {0.0, 0.30, 0.40},
    rotation1 = {90.0, 0.0, 0.0},
    offSet2 = {0.0, 0.50, 0.40},
    rotation2 = {90.0, 0.0, 0.0},
}