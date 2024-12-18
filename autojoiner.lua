if not game:IsLoaded() then
	game.Loaded:Wait()
end

local bb = game:GetService("VirtualUser")
game:service "Players".LocalPlayer.Idled:connect(
    function()
        bb:CaptureController()
        bb:ClickButton2(Vector2.new())
    end
)

local HttpServ = game:GetService("HttpService")
local joinFile = isfile("lastjoin.txt")
if not joinFile then
    writefile("lastjoin.txt", "placeholder")
end
local LastMsgId = readfile("lastjoin.txt")
local thing = game:GetService('ReplicatedFirst'):WaitForChild('UISelector'):WaitForChild('LoadingS2'):WaitForChild('Loading')
while thing.Enabled do
    wait(1)
end
local waittime = delay or 2
wait(waittime)
local notused = game:GetService('ReplicatedStorage'):WaitForChild('Trade'):WaitForChild('AcceptRequest')
game:GetService('TextChatService').TextChannels.RBXGeneral:SendAsync('yo wsg tobi')

local function acceptRequest()
    while task.wait(0.1) do
        game:GetService('ReplicatedStorage'):WaitForChild('Trade'):WaitForChild('AcceptRequest'):FireServer()
    end
end

local function acceptTrade()
    while task.wait(0.1) do
        game:GetService('ReplicatedStorage'):WaitForChild('Trade'):WaitForChild('AcceptTrade'):FireServer(unpack({[1] = 285646582}))
    end
end

task.spawn(acceptRequest)
task.spawn(acceptTrade)

local function autoJoin()
    local response = request({
        Url = "https://discord.com/api/v9/channels/"..channelId.."/messages?limit=1",
        Method = "GET",
        Headers = {
            ['Authorization'] = token,
            ['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
            ["Content-Type"] = "application/json"
        }
    })

    if response.StatusCode == 200 then
        local messages = HttpServ:JSONDecode(response.Body)
        if #messages > 0 then
            local placeId, jobId = string.match(messages[1].content, 'TeleportToPlaceInstance%((%d+),%s*["\']([%w%-]+)["\']%)')

            if tostring(messages[1].id) ~= LastMsgId and placeId ~= nil then
                LastMsgId = tostring(messages[1].id)
                writefile("lastjoin.txt", LastMsgId)
                game:GetService('TeleportService'):TeleportToPlaceInstance(placeId, jobId)
            end
        end
    end
end

while wait(5) do
    autoJoin()
end
