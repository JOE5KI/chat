-- StarBlazt Chat

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source)
	local identifier = ESX.GetPlayerFromId(source).identifier
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
		}
	else
		return nil
	end
end

--[[ COMMANDS ]]--

RegisterCommand('clear', function(source, args, rawCommand)
    TriggerClientEvent('chat:client:ClearChat', source)
end, false)

RegisterCommand('ooc', function(source, args, rawCommand)
	local msg = rawCommand:sub(4)
	local name = getIdentity(source)
	fal = name.firstname .. "  " .. name.lastname
        TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message"><b>OOC {0}:</b> {1}</div>',
        args = { fal, msg }
    })
end, false)
