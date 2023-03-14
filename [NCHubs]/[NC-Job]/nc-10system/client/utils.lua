function CheckValidJob(jobName)
    for k,v in pairs(NCConfig.WhitelistedJobs) do
        if k == jobName then
            return true
        end
    end
    return false
end