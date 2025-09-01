-- Path scripthooked:lua\\homigrad\\sh_notification.lua"
-- Scripthooked by ???

if SERVER then
    util.AddNetworkString("HGNotificate")

    --local hg_old_notificate = ConVarExists("hg_old_notificate") and GetConVar("hg_old_notificate") or CreateConVar("hg_old_notificate",0,FCVAR_SERVER_CAN_EXECUTE,"enable old notifications (chatprints)",0,1)

    local function CreateNotification(ply,msg,delay,msgKey,showTime)
        if not IsValid(ply) or not ply:IsPlayer() then error("player is not valid!") return false end
        if not msg or not isstring(msg) then error("no message or message is invalid!") return false end
        msgKey = msgKey or msg
        ply.msgs = ply.msgs or {}
        if msgKey and ply.msgs[msgKey] then
            if isnumber(ply.msgs[msgKey]) then
                if ply.msgs[msgKey] > CurTime() then
                    return false
                end
            else
                return false
            end
        end
        
        if msgKey then ply.msgs[msgKey] = delay and (not isnumber(delay) or CurTime() + delay) or nil end
        --показывать один раз за промежуток времени
        --(если delay не номерок то оно пинганет в следующей жизни)
        if ply:GetInfoNum( "hg_old_notificate", 0 ) > 0 then
            ply:ChatPrint(msg)
        else
            net.Start("HGNotificate")
            net.WriteString(msg)
            net.WriteFloat(showTime or 3)
            net.Send(ply)
        end

        return true
    end

    hg.CreateNotification = CreateNotification

    hook.Add("Player Death","removeNotifications",function(ply)
        ply.msgs = {}
    end)

    local PLAYER = FindMetaTable("Player")

    function PLAYER:Notify(...)
        return CreateNotification(self,...)
    end
else
    local hg_old_notificate = ConVarExists("hg_old_notificate") and GetConVar("hg_old_notificate") or CreateConVar("hg_old_notificate",0,{FCVAR_USERINFO,FCVAR_ARCHIVE},"enable old notifications (chatprints)",0,1)

    surface.CreateFont("HuyFont", {
		font = "Bahnschrift",
		extended = true,
		size = ScreenScale(12),
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		strikeout = false,
		shadow = false,
		outline = false,
	})

    hook.Add("Player Death","removeNotifications",function(ply)
        hg.currentNotification = nil
        hg.notifications = {}
    end)

    hg.notifications = hg.notifications or {}

    local defaultShowTimer = 3
    local function CreateNotification(msg,showTimer)
        table.insert(hg.notifications,{msg,(showTimer or defaultShowTimer)})
    end

    local PLAYER = FindMetaTable("Player")

    function PLAYER:Notify(...)
        return CreateNotification(self,...)
    end

    net.Receive("HGNotificate",function()
        local msg = net.ReadString()
        local showtime = net.ReadFloat()
        local lply = LocalPlayer()

        CreateNotification(msg,showtime)
    end)

    hg.CreateNotification = CreateNotification
    local colred = Color(255,0,0)
    local function NotificationsThink()
        if hg.currentNotification or #hg.notifications == 0 then return end
        local tbl = hg.notifications[1]

        if tbl and istable(tbl) and not table.IsEmpty(tbl) then
            hg.currentNotification = {tbl[1],CurTime() + tbl[2],tbl[2]}
            MsgC(colred,tbl[1].."\n")--для нубов с короткой памятью
            table.remove(hg.notifications,1)
        end--показываем только одну нотификацию за раз (остальные держим в уме....)
    end

    local colBrown = Color(40,40,40)
    local Color_Notification = Color(0,0,0,0)
    local maxtimefade = 1
    local function NotificationsDraw()
        local tbl = hg.currentNotification
        
        if tbl and istable(tbl) and not table.IsEmpty(tbl) then
            local msg,time,timeshow = tbl[1],tbl[2],tbl[3]

            if time > CurTime() then
                local part = (CurTime() - (time - timeshow)) < math.min(timeshow / 2,maxtimefade) and (CurTime() - (time - timeshow)) / math.min(timeshow / 2,maxtimefade) or (time - CurTime()) / math.min(maxtimefade,timeshow / 2)
                surface.SetFont("HuyFont")
                local txtw = surface.GetTextSize(msg)
                --surface.SetFont("HuyFont")
                local x,y = ScrW() / 2 - txtw / 2, ScrH() - ScrH() / 6
                --surface.SetTextPos(x,y)
                --surface.SetTextColor(255,255,255,255 * part)
                local col = Color_Notification
                col.r = 255
                col.g = 255
                col.b = 255
                col.a = 255 * part
                colBrown.a = 255 * part
                draw.SimpleTextOutlined(msg,"HuyFont",x,y,col,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER,1.5,colBrown)
            else
                hg.currentNotification = nil
            end
        end
    end
    
    hook.Add("HUDPaint","HGNotificationsThink",NotificationsDraw)
    hook.Add("Think","HGNotificationsThink",NotificationsThink)
end