Config = {}

Config.waitTimeInSeconds = 5
Config.waitTime = Config.waitTimeInSeconds * 1000

-- Add the job prefixes in here that match with your database.
Config.whitelistedJobs = {
	"police",
	"ambulance",
	"mecano"
}