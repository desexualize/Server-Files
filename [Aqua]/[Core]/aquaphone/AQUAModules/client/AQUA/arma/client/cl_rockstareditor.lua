rockstarConfig = {
    binding = {
        start_record_replay = 288,
        start_record = 57,
        stop_save_record = 57,
        stop_discard_record = 289,
        open_editor = 178
    }
}
recordingMode = false
function func_recordingMode()
    if recordingMode then
        if IsRecording() then
            if IsControlJustPressed(1, rockstarConfig.binding.stop_save_record) then
                StopRecordingAndSaveClip()
            end
            if IsControlJustPressed(1, rockstarConfig.binding.stop_discard_record) then
                StopRecordingAndDiscardClip()
            end
        else
            if IsControlJustPressed(1, rockstarConfig.binding.start_record_replay) then
                StartRecording(0)
            end
            if IsControlJustPressed(1, rockstarConfig.binding.start_record) then
                StartRecording(1)
            end
        end
        if IsControlJustPressed(1, rockstarConfig.binding.open_editor) then
            NetworkSessionLeaveSinglePlayer()
            ActivateRockstarEditor()
        end
    end
end
tARMA.createThreadOnTick(func_recordingMode)
RegisterCommand("rockstareditor",function()
    recordingMode = not recordingMode
    if not recordingMode then
        tARMA.notify("~r~Recording mode is now off")
    else
        tARMA.notify("~g~Recording mode is now on (F10 to record)")
    end
end)
