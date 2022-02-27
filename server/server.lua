-- Most of the SQL code from Marcus edited by JackTheDev

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('policeOffDuty')
AddEventHandler('policeOffDuty', function(identifier, currJob)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if ESX.DoesJobExist('police', 5) then
        MySQL.Async.fetchAll('SELECT identifier FROM jtd_storage WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(results)
            for i=1, #results, 1 do
                newID = results[i]['identifier']
            end
        end)
        if newId == nil then
            MySQL.Async.execute('INSERT INTO jtd_storage (identifier, jtdgrade) VALUES (@identifier, @jtdgrade)', {
                ['@identifier'] = identifier,
                ['@jtdgrade'] = currJob
            })

            xPlayer.setJob('police', 5)
        else
            MySQL.Async.execute('UPDATE jtd_storage SET jtdgrade = @jtdgrade WHERE identifier = @identifier', {
                ['@jtdgrade'] = currJob,
                ['@identifier'] = identifier
            })

            xPlayer.setJob('police', 5)
        end
        newID = nil
    end
end)

RegisterNetEvent('policeOnDuty')
AddEventHandler('policeOnDuty', function(identifier)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    MySQL.Async.fetchAll('SELECT * FROM jtd_storage WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(results)
        for i=1, #results, 1 do
            xPlayer.setJob('police', results[i]['jtdgrade'])
        end
    end)
    newID = nil
end)
