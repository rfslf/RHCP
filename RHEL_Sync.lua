-- Taken from GRM Author: Arkaan... aka "TheGenomeWhisperer"

RHEL_sync = {};

-- All Sync Globals
RHEL_syncGlobals = {};
RHEL_syncGlobals.channelName = "GUILD";
RHEL_syncGlobals.DebugEnabled = true
RHEL_syncGlobals.channelType = "WHISPER"
--RHEL_syncGlobals.DatabaseLoaded = false;
--RHEL_syncGlobals.RulesSet = false;
--RHEL_syncGlobals.LeadSyncProcessing = false;
RHEL_syncGlobals.SyncOK = true;

-- Prefixes for tagging info as it is sent and picked up across server channel to other players in guild.
RHEL_sync.listOfPrefixes = { 

    -- Main Sync Prefix...  rest will be text form
    "RHEL_SYNC"
};

-- Version check
RHEL_sync.Version = "001100";
RHEL_sync.IncompatibleAddonUsers = {};
RHEL_sync.CompatibleAddonUsers = {};

-- TCP-like ack mechanic
RHEL_sync.pckg = 1
RHEL_sync.waitPckgs = {}

-------------------------------
---- MESSAGE SENDING ----------
-------------------------------

-- Method:          RHEL_sync.SendMessage ( string , string , string , int )
-- What it Does:    Sends an invisible message over a specified channel that a player cannot see, but an addon can read.
-- Purpose:         Necessary function for cross-talk between players using addon.
RHEL_sync.SendMessage = function ( prefix , msg , type , target )
    if RHEL_syncGlobals.SyncOK then
        if (#msg + #prefix) >= 255 then
            RHEL.Report( RHEL_loc[ "Com Message too large for server" ] .. "\n" .. RHEL_loc["Prefix:"] .. " " .. prefix .. "\n" .. RHEL_loc["Msg:"] .. " " .. msg, true);
        elseif msg == "" and prefix == "RHEL_SYNC" then
            return
        else
			if RHEL.DebugEnabled then
                RHEL.Report ( msg );
            end
            C_ChatInfo.SendAddonMessage ( prefix , msg , type , target );
        end
    end
end

--------------------------------
--- CLOSE Window for PACKAGE ---
--------------------------------

-- Method:          RHEL_sync.CloseWindow ( int )
-- What it Does:    Check if message did not acknowledged and removes it
-- Purpose:         Necessary function for cross-talk between players using addon.
RHEL_sync.CloseWindow = function ( pckg )
	if RHEL_sync.waitPckgs[pckg] then
		RHEL_sync.waitPckgs[pckg] = nil
		if RHEL.DebugEnabled then
            RHEL.Report ( pckg .. 'to' .. RHEL_sync.waitPckgs[pckg] .. "not delivered"  );
        end
	else
		return true
	end
end

--------------------------------
---- Message Prefix Functions --
--------------------------------

-- Method:          RHEL_sync.RegisterPrefix( string )
-- What it Does:    For addon to coomunicate the prefix first needs to be registered.
-- Purpose:         For player to player addon talk.
RHEL_sync.RegisterPrefix = function ( prefix )
    -- Prefix can't be more than 16 characters
    if #prefix > 16 then
        RHEL.Report ( ("Unable to register prefix > 16 characters: "  .. prefix ), true );
    end
    C_ChatInfo.RegisterAddonMessagePrefix ( prefix );
end

-- Method:          RHEL_sync.RegisterPrefixes()
-- What it Does:    Registers the tages for all of the messages, so the addon recognizes and knows to pick them up
-- Purpose:         Prefixes need to be registered to the server to be usable for addon to addon talk.
RHEL_sync.RegisterPrefixes = function ( )
    for i = 1 , #RHEL_sync.listOfPrefixes do 
        RHEL_sync.RegisterPrefix ( RHEL_sync.listOfPrefixes[i] );
    end
end

-- Method:          RHEL_sync.IsPrefixVerified ( string )
-- What it Does:    Returns true if received prefix is listed in this addon's
-- Purpose:         Control the spam in case of other prefixes received from other addons in guild channel.
RHEL_sync.IsPrefixVerified = function( prefix )
    local result = false;
    for i = 1 , #RHEL_syncGlobals.listOfPrefixes do
        if RHEL_syncGlobals.listOfPrefixes[i] == prefix then
            result = true;
            break;
        end
    end
    return result;
end

-------------------------------
------ MESSAGE LOGIC ----------
-------------------------------

-- Method:          RHEL_sync.CommunicationReceived()
-- What it Does:    Establishes the channel communication rules for receiving
-- Purpose:         Need to make rules to get this to behave properly!
RHEL_sync.CommunicationReceived = function()
    RHEL_sync.MessageTracking:RegisterEvent ( "CHAT_MSG_ADDON" );
--    RHEL_sync.MessageTracking:SetScript ( "OnUpdate" , RHEL_sync.MessageThrottleUpdate );
    -- Register used prefixes!
    RHEL_sync.RegisterPrefixes ( RHEL_syncGlobals.listOfPrefixes );

    -- Setup tracking...
    RHEL_sync.MessageTracking:SetScript ( "OnEvent" , function( self , event , prefix , msg , channel , sender )
        if not RHEL_syncGlobals.SyncOK then
            self:UnregisterAllEvents();
        else
			print(event , prefix , msg , channel , sender )
            if event == "CHAT_MSG_ADDON" and channel == "WHISPER" and RHEL_sync.IsPrefixVerified ( prefix ) then     -- Don't need to register my own sends.		
				------------------------------------------
                -----------RECEIVED MESSAGE AFFIX---------
                ------------------------------------------
                -- Sender must not equal themselves...
                if sender ~= GetUnitName ( "PLAYER" , false ) then
                    -- Let's strip out the message, as well as the affix.
                    -- msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                    local affix = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
					local pckgnmbr = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
					msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
					if RHEL.DebugEnabled then
						RHEL.Report ( affix .. ' ' .. pckgnmbr .. ' ' .. msg );
					end
					
					-- Affix: CHCK. Version Control Check and reply
					-- First, see if they are on compatible list.
					if affix == "CKCK" or affix == "CKCKRPL" then
						local isFound = false;
						for i = 1 , #RHEL_syncGlobals.CompatibleAddonUsers do
							if RHEL_syncGlobals.CompatibleAddonUsers[i] == sender then
								isFound = true;
								break;
							end
						end

						-- See if they are on the incompatible list.
						local abortSync = false;
						if not isFound then
							for i = 1 , #RHEL_syncGlobals.IncompatibleAddonUsers do
								if RHEL_syncGlobals.IncompatibleAddonUsers[i] == sender then
									return;
								end
							end

							-- If you make it to this point, it means the player is not on the compatible list, and they are not on the incompatible list, they have never been checked...
							-- Let's do it now!
							-- Due to older verisons... need to check if this is nil. It will be nil for many. To prevent Lua error/crash.
							versionCheck = tonumber ( string.sub ( msg ) );
							if versionCheck ~= nil then
								if versionCheck < RHEL_sync.Version then                   -- player sending data has an older version                   
									abortSync = true;
									RHEL.Report(sender .. " has an older version");
								elseif versionCheck > RHEL_sync.Version then					   -- player reciving data has an older version
									abortSync = true;
									RHEL.Report(sender .. " has an newer version");
								else
									if affix == "CKCKRPL" then 
										if RHEL_sync.waitPckgs[pckg] then
											RHEL_sync.waitPckgs[pckg] = nil;
											RHEL.Report(msg)
										else
											RHEL.Report("Late responce or communication package number misunderstood", true)	-- late responce or error
										end
									else
										RHEL_sync.SyncReplySend(pckg, sender)
									end
								end 
							else
								-- Older versions are incompatible, regardless of setting...
								abortSync = true;
							end                            
						end
					else
						if RHEL.DebugEnabled then
							RHEL.Report ( msg );
						end
					end   
                end
            end
        end
    end);
end

-- Method:          RHEL_sync.SyncSend(string)
-- What it Does:    rules for sending sync
-- Purpose:         Need to make rules to get this to behave properly!
RHEL_sync.SyncSend = function(target)
	local pckg = RHEL_sync.pckg
	msg =  'CKCK' .. "?" .. tostring(pckg) .. '?' .. RHEL_sync.Version;
	RHEL_sync.SendMessage ( "RHEL_SYNC" , msg , RHEL_syncGlobals.channelType , target );
	RHEL_sync.pckg = RHEL_sync.pckg + 1;
	RHEL_sync.waitPckgs[pckg] = target;
	C_Timer.After(2, RHEL_sync.CloseWindow(pckg))
end

-- Method:          RHEL_sync.SyncReplySend(int, string)
-- What it Does:    rules for sending reply to sync
-- Purpose:         Need to make rules to get this to behave properly!
RHEL_sync.SyncReplySend = function(pckg,target)
	msg =  'CKCKRPL' .. "?" .. tostring(pckg) .. '?' .. RHEL_sync.Version;
	RHEL_sync.SendMessage ( "RHEL_SYNC" , msg , RHEL_syncGlobals.channelType , target );
end

-- ON LOADING!!!!!!!
-- Event Tracking
RHEL_sync.Initialize = function()
    if RHEL_syncGlobals.SyncOK then
    --    if GRM_AddonSettings_Save[GRM_G.FID][GRM_G.setPID][2][14] and IsInGuild() and GRM_G.HasAccessToGuildChat then
    --       RHEL_sync.TriggerFullReset();
    --       GRM.RegisterGuildAddonUsersRefresh();
    --       RHEL_syncGlobals.LeadSyncProcessing = false;
    --       RHEL_syncGlobals.errorCheckEnabled = false;
        RHEL_sync.MessageTracking = RHEL_sync.MessageTracking or CreateFrame ( "Frame" , "RHEL_syncMessageTracking" );
    --       GRM_G.playerRankID = GRM.GetGuildMemberRankID ( GRM_G.addonPlayerName );
        RHEL_sync.CommunicationReceived();
    --    end
    end
end