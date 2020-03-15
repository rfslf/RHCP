-- Taken from GRM Author: Arkaan... aka "TheGenomeWhisperer"

RHEL_sync = {};

-- All Sync Globals
RHEL_syncGlobals = {};
RHEL_syncGlobals.channelName = "GUILD";
RHEL_syncGlobals.DebugEnabled = false;
RHEL_syncGlobals.channelType = "WHISPER"
RHEL_syncGlobals.SyncOK = true;

-- Prefixes for tagging info as it is sent and picked up across server channel to other players in guild.
RHEL_syncGlobals.listOfPrefixes = { 

    -- Main Sync Prefix...  rest will be text form
    "RHEL_SYNC"
};

-- Version check
RHEL_sync.Version = '001100';
RHEL_syncGlobals.IncompatibleAddonUsers = {};
RHEL_syncGlobals.CompatibleAddonUsers = {};

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
            C_ChatInfo.SendAddonMessage ( prefix , msg , type , target );
			if RHEL_syncGlobals.DebugEnabled then
                RHEL.Report ( msg .. " sended to ".. target);
            end
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
		if RHEL_syncGlobals.DebugEnabled then
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
    for i = 1 , #RHEL_syncGlobals.listOfPrefixes do 
        RHEL_sync.RegisterPrefix ( RHEL_syncGlobals.listOfPrefixes[i] );
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
            if event == "CHAT_MSG_ADDON" and channel == "WHISPER" and RHEL_sync.IsPrefixVerified ( prefix ) then     -- Don't need to register my own sends.
			-- print(event , prefix , msg , channel , sender )		
				------------------------------------------
                -----------RECEIVED MESSAGE AFFIX---------
                ------------------------------------------
                -- Sender must not equal themselves...
                if sender ~= GetUnitName ( "PLAYER" , true ) then
                    -- Let's strip out the message, as well as the affix.
                    -- msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
                    local affix = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
                    msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
					local pckgnmbr = string.sub ( msg , 1 , string.find ( msg , "?" ) - 1 );
					msg = string.sub ( msg , string.find ( msg , "?" ) + 1 );
					if RHEL_syncGlobals.DebugEnabled then
						RHEL.Report ( 'Recived message: '.. affix .. ' ' .. pckgnmbr .. ' ' .. msg );
					end
					
					-- Affix: "CHCK". Version Control Check
					if affix == "CHCK" then
						-- If you make it to this point, it means that sender have never been checked...
						-- Let's do it now!
						versionCheck = tonumber (  msg );
						if versionCheck ~= nil then
							if versionCheck < tonumber ( RHEL_sync.Version ) then                   -- player sending data has an older version                   
								RHEL.Report(sender .. " has an older version");
							elseif versionCheck > tonumber (RHEL_sync.Version ) then				-- player reciving data has an older version
								RHEL.Report(sender .. " has an newer version");
							else
								RHEL_sync.SyncReplySend(tonumber(pckgnmbr), sender)  				-- nice, trust to sender next time
								table.insert(RHEL_syncGlobals.CompatibleAddonUsers, sender)
							end 
						else
							-- Older versions are incompatible
							if RHEL_syncGlobals.DebugEnabled then
								RHEL.Report ( 'Recived version check message without version from ' .. sender);
							end
						end                            


					-- Affix: "CHCKRPL". Version Control Reply
					elseif affix == "CHCKRPL" then
						if RHEL_sync.waitPckgs[pckgnmbr] then
							RHEL_sync.waitPckgs[pckgnmbr] = nil;
						else
							RHEL.Report("Late responce or communication package numbers misunderstood", true)	-- late responce or error
						end
						versionCheck = tonumber (  msg );
						if versionCheck ~= nil then
							if versionCheck < tonumber ( RHEL_sync.Version ) then                   -- player sending data has an older version                   
								RHEL.Report(sender .. " has an older version");
							elseif versionCheck > tonumber (RHEL_sync.Version ) then				-- player reciving data has an older version
								RHEL.Report(sender .. " has an newer version");
							else								
								table.insert(RHEL_syncGlobals.CompatibleAddonUsers, sender)			-- nice, trust to sender next time
							end 
						else
							-- Older versions are incompatible
							if RHEL_syncGlobals.DebugEnabled then
								RHEL.Report ( 'Recived version check message without version from ' .. sender);
							end                          
						end

					-- Affix: "ANCE". Announce
					elseif affix == "ANCE" then
						-- Get a clue what is what
						local raidboss = string.sub ( msg , 1 , string.find ( msg , "&" ) - 1 );
						msg = string.sub ( msg , string.find ( msg , "&" ) + 1 );
						local heals = string.sub ( msg , 1 , string.find ( msg , "&" ) - 1 );
						msg = string.sub ( msg , string.find ( msg , "&" ) + 1 );
						local buffs = string.sub ( msg , 1 , string.find ( msg , "&" ) - 1 );
						local disps = string.sub ( msg , string.find ( msg , "&" ) + 1 );
						-- then show a window with it
						RHEL_sync.AnnounceFrame(sender, raidboss, heals, buffs, disps)					
						-- then acknowledge "ANCE"
						RHEL_sync.AnnounceReplySend(tonumber(pckgnmbr), sender)
					-- Affix: "CHCKRPL". Version Control Reply
					elseif affix == "ANCERPL" then
						if RHEL_sync.waitPckgs[pckgnmbr] then
							RHEL_sync.waitPckgs[pckgnmbr] = nil;
						else
							RHEL.Report("Late responce or communication package numbers misunderstood", true)	-- late responce or error
						end				
					end
                else
					if RHEL_syncGlobals.DebugEnabled then
						RHEL.Report ( "Selfsend message: " .. msg );
					end
				end
            end
        end
    end);
end

-- Method:          RHEL_sync.SyncSend(string)
-- What it Does:    Sending sync to target if have not
-- Purpose:         Need to trust to sender
RHEL_sync.SyncSend = function(target)
	-- If not checked yet
	local pckg = tostring(RHEL_sync.pckg)
	msg =  'CHCK' .. "?" .. pckg .. '?' .. RHEL_sync.Version;
	if RHEL_syncGlobals.DebugEnabled then
		RHEL.Report ( msg .. ' in ' .. pckg ..  ' to ' .. target .. " created"  );
	end
	RHEL_sync.SendMessage ( "RHEL_SYNC" , msg , RHEL_syncGlobals.channelType , target );
	RHEL_sync.pckg = RHEL_sync.pckg + 1;
	RHEL_sync.waitPckgs[pckg] = target;
	C_Timer.After(3, function ( )
		if RHEL_sync.waitPckgs[pckg] == target then
			RHEL_sync.waitPckgs[pckg] = nil;
			if RHEL_syncGlobals.DebugEnabled then
				RHEL.Report ( pckg .. ' to ' .. target .. " not delivered"  ); -- failed
			end
		else
			table.insert(RHEL_syncGlobals.CompatibleAddonUsers, target); -- OK 
		end	
	end);
end

-- Method:          RHEL_sync.SyncReplySend(int, string)
-- What it Does:    Sending reply to sync
-- Purpose:         Need to trust to sender
RHEL_sync.SyncReplySend = function(pckg,target)
	msg =  'CHCKRPL' .. "?" .. tostring(pckg) .. '?' .. RHEL_sync.Version;
	RHEL_sync.SendMessage ( "RHEL_SYNC" , msg , RHEL_syncGlobals.channelType , target );
end

-- Method:          RHEL_sync.AnnounceSend(string, string, string, string, string)
-- What it Does:    Sending announce to target - healer
-- Purpose:         Announce communication start
RHEL_sync.AnnounceSend = function(target, raidboss, heals, buffs, disps)
	-- Check compatible list
	local need_sync = true
	for i = 1 , #RHEL_syncGlobals.CompatibleAddonUsers do
		if RHEL_syncGlobals.CompatibleAddonUsers[i] == target then
			need_sync = false;	-- all OK
			break
		end
	end
	if need_sync then
		RHEL_sync.SyncSend(target)
	end
	
	local pckg = tostring(RHEL_sync.pckg)
	msg =  'ANCE' .. "?" .. pckg .. '?' .. raidboss .. '&' .. heals .. '&' .. buffs .. '&' .. disps;
	if RHEL_syncGlobals.DebugEnabled then
		RHEL.Report ( raidboss .. ' announce in ' .. pckg..  ' to ' .. target .. " created"  );
	end
	RHEL_sync.SendMessage ( "RHEL_SYNC" , msg , RHEL_syncGlobals.channelType , target );
	RHEL_sync.pckg = RHEL_sync.pckg + 1;
	RHEL_sync.waitPckgs[pckg] = target;
	C_Timer.After(3, function ( )
		if RHEL_sync.waitPckgs[pckg] == target then
			RHEL_sync.waitPckgs[pckg] = nil -- failed
			if RHEL_syncGlobals.DebugEnabled then
				RHEL.Report ( pckg .. ' to ' .. target .. " not delivered"  );
			end
		end	
	end);
end

-- Method:          RHEL_sync.AnnounceReplySend(int, string)
-- What it Does:    Sending reply to announce
-- Purpose:         Announce communication finish
RHEL_sync.AnnounceReplySend = function(pckg,target)
	msg =  'ANCERPL' .. "?" .. tostring(pckg) .. '?OK';
	RHEL_sync.SendMessage ( "RHEL_SYNC" , msg , RHEL_syncGlobals.channelType , target );
end	

-- Method:          RHEL_sync.AnnounceFrame(string, string, string, string, string)
-- What it Does:    Create a frame with announce banner
-- Purpose:         Announce banner
RHEL_sync.AnnounceFrame = function(sender, raidboss, heals, buffs, disps)
	if RHEL_Announce then
		RHEL_Announce:Show();
		RHEL_Announce.Font0:SetText(raidboss .. " @" .. sender);
		RHEL_Announce.Font1:SetText(RHEL_loc["Heals:"] .. " " .. heals );
		RHEL_Announce.Font2:SetText(RHEL_loc["Buffs:"] .. " " .. buffs);
		RHEL_Announce.Font3:SetText(RHEL_loc["Dispells:"] .. " " .. disps);
	else
		RHEL_Announce = CreateFrame("Frame", "RHEL_Announce", UIParent);
		RHEL_Announce.RHEL_AnnounceCloseButton = CreateFrame( "Button", "RHEL_AnnounceCloseButton", RHEL_Announce, "UIPanelCloseButton");
		RHEL_Announce.RHEL_AnnounceCloseButton:SetPoint("TOPRIGHT", RHEL_Announce, 3, 3);
		RHEL_Announce:SetSize(300, 55);
		RHEL_Announce:SetMovable(true);
		RHEL_Announce:EnableMouse(true);
		RHEL_Announce:SetToplevel(true);
		RHEL_Announce:SetPoint("LEFT", 0 , 0);
		RHEL_Announce:SetBackdrop(RHEL_GUI.RHEL_Backdrop1);
	
		RHEL_Announce.Font0 = RHEL_Announce:CreateFontString(RHEL_Announce, "OVERLAY", "GameFontNormal");
		RHEL_Announce.Font0:SetPoint("TOPLEFT", 5, -5);
		RHEL_Announce.Font0:SetText(raidboss .. " @" .. sender)
		RHEL_Announce.Font1 = RHEL_Announce:CreateFontString(RHEL_Announce, "OVERLAY", "GameFontNormal");
		RHEL_Announce.Font1:SetPoint("TOPLEFT", 5, -20);
		if heals then
			RHEL_Announce.Font1:SetText(RHEL_loc["Heals:"] .. " " .. heals )
		end
		RHEL_Announce.Font2 = RHEL_Announce:CreateFontString(RHEL_Announce, "OVERLAY", "GameFontNormal");
		RHEL_Announce.Font2:SetPoint("TOPLEFT", 5, -35);
		if buffs then
			RHEL_Announce.Font2:SetText(RHEL_loc["Buffs:"] .. " " ..buffs )
		end
		RHEL_Announce.Font3 = RHEL_Announce:CreateFontString(RHEL_Announce, "OVERLAY", "GameFontNormal");
		RHEL_Announce.Font3:SetPoint("TOPLEFT", 5, -50);
		if disps then
			RHEL_Announce.Font3:SetText(RHEL_loc["Dispells:"] .. " " ..disps )
		end

		RHEL_Announce:SetScript("OnMouseDown", function(self)
			RHEL_OnMouseDown(self);
		end);
		RHEL_Announce:SetScript("OnMouseUp", function(self)
			RHEL_OnMouseUp(self);
		end);
	end
	--RHEL_Announce:Show();
end

-- ON LOADING!!!!!!!
-- Event Tracking
RHEL_sync.Initialize = function()
    if RHEL_syncGlobals.SyncOK then
        RHEL_sync.MessageTracking = RHEL_sync.MessageTracking or CreateFrame ( "Frame" , "RHEL_syncMessageTracking" );
        RHEL_sync.CommunicationReceived();
    end
end

RHEL_sync.Initialize()