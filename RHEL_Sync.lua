-- Taken from GRM Author: Arkaan... aka "TheGenomeWhisperer"

RHEL_sync = {};

-- All Sync Globals
RHEL_syncGlobals = {};
RHEL_syncGlobals.channelName = "GUILD";
RHEL_syncGlobals.DebugEnabled = true
--RHEL_syncGlobals.DatabaseLoaded = false;
--RHEL_syncGlobals.RulesSet = false;
--RHEL_syncGlobals.LeadSyncProcessing = false;
RHEL_syncGlobals.SyncOK = true;

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