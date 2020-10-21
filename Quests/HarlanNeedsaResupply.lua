--[[  www.ArcEmu.org
      Stormwind City: Harlan Needs a Resupply
      Engine: A.L.E
      Credits: to Trinity for waypoints and creature texts
--]]

local FACTION_FRIENDLY = 35
local NO_DESPAWN = 0

local CHAT = {}

CHAT[ 1 ] = "Business must be good down at the bazaar.  I'll get him resupplied right away!";
CHAT[ 2 ] = "Corbett, dear. Harlan needs a load of knitted shirts and pants as soon as we can manage.";
CHAT[ 3 ] = "Corbett, you there? Harlan needs another load of knitted goods. Can you take it to him?";
CHAT[ 4 ] = "My pleasure, sugar drop.  I'll be back soon...";

CHAT[ 5 ] = "Hm...after dropping this off, I think I'll head to that cheese shop for a snack.";
CHAT[ 6 ] = "I should have a few extra coins from this sale.  Maybe I'll buy myself some lunch...";

CHAT[ 7 ] = "Hey, Harlan.  Here's a load of knitted cloth for you.";
CHAT[ 8 ] = "Oomph!  Here's another load of supplies, Harlan.  It must be selling fast!";
CHAT[ 9 ] = "Ah, much appreciated, Corbett.  We'll get these on the racks immediately.";
CHAT[ 10 ] = "Ah yes, and promptly delivered. As always, it's a pleasure doing business with you, Corbett.";

CHAT[ 11 ] = "Well, I'm off then.  Take care, Harlan.";
CHAT[ 12 ] = "Glad to see you're doing so well, Harlan.  And I hope to see you again soon...";

CHAT[ 13 ] = "Now for that snack...";

CHAT[ 14 ] = "Good day, Elling!  Hullo Elaine!  Let me have a wheel of bleu cheese, eh?";
CHAT[ 15 ] = "Hullo, Trias clan!  A ball of your smoked mozzarella, if you please!";
CHAT[ 16 ] = "Good day, Corbett.  Here's your cheese, fresh made this morning!  And how are things at your shop?";
CHAT[ 17 ] = "Hi Corbett!  Here, you go!  I trust business is faring well at your clothier shop...?";

CHAT[ 18 ] = "Yes ma'am, business is brisk!";

CHAT[ 19 ] = "Thank you kindly!";
CHAT[ 20 ] = "Thanks for the cheese!";

CHAT[ 21 ] = "I should get back before Rema starts to worry...";
CHAT[ 22 ] = "Time to get back to the shop...";

CHAT[ 23 ] = "I'm back!";

HARLAN_RESUPPLY = {}

function HARLAN_RESUPPLY.OnComplete( plr, questID )

    if( questID == 333 )
    then
        local rema = plr:GetCreatureNearestCoords( -8777.60, 713.50, 99.62, 1428 );
        if( rema ~= nil )
        then
            rema:SendChatMessage( 12, 7, CHAT[ 1 ] );
            rema:EventChat( 12, 7, CHAT[ math.random( 2, 3 ) ], 6000 );
            local corbett = rema:SpawnCreature( 1433, -8773.65, 717.401, 99.534, 3.8705, FACTION_FRIENDLY, NO_DESPAWN, 1, 1, 1, 1, 0 );
            corbett:EventChat( 12, 7, CHAT[ 4 ], 9000 );
            corbett:StopMovement( 15000 );
            local result = WorldDBQuery( "SELECT `p_x`, `p_y`, `p_z`, `p_o`, `wtime`, `flags` FROM `waypoints_lua` WHERE `entry` = '1433'" );
            if( result ~= nil )
            then
                corbett:CreateCustomWaypointMap();
                local i = 0;
                repeat
                    i = i + 1;
                    local x = result:GetColumn( 0 ):GetFloat();
                    local y = result:GetColumn( 1 ):GetFloat();
                    local z = result:GetColumn( 2 ):GetFloat();
                    local o = result:GetColumn( 3 ):GetFloat();
                    local time = result:GetColumn( 4 ):GetUShort();
                    corbett:CreateCustomWaypoint( i, x, y, z, o, time, 0, 0 );

                until result:NextRow() ~= true;
            end
        end
    end
end

function HARLAN_RESUPPLY.OnReachWP( unit, event, wpID )

    if( wpID == 4 )
    then
        unit:SendChatMessage( 12, 7, CHAT[ math.random( 5, 6 ) ] );

    elseif( wpID == 31 )
    then
        unit:SendChatMessage( 12, 7, CHAT[ math.random( 7, 8 ) ] );
        local harlan = unit:GetCreatureNearestCoords( -8782.90, 640.19, 97.41, 1427 );
        if( harlan ~= nil )
        then
            harlan:EventChat( 12, 7, CHAT[ math.random( 9, 10 ) ], 5000 );
            unit:EventChat( 12, 7, CHAT[ math.random( 11, 12 ) ], 10000 );
        end

    elseif( wpID == 34 )
    then
        unit:SendChatMessage( 12, 7, CHAT[ 13 ] );

    elseif( wpID == 41 )
    then
        unit:SendChatMessage( 12, 7, CHAT[ math.random( 14, 15 ) ] );
        --unit:SendChatMessageAlternateEntry( 483, 12, 7, CHAT[ math.random( 16, 17 ) ] );
        local elaine = unit:GetCreatureNearestCoords( -8845.68, 566.49, 94.77, 483 );
        if( elaine ~= nil )
        then
            elaine:EventChat( 12, 7, CHAT[ math.random( 16, 17 ) ], 5000 );
            unit:EventChat( 12, 7, CHAT[ 18 ], 10000 );
            unit:EventChat( 12, 7, CHAT[ math.random( 19, 20 ) ], 15000 );
        end

    elseif( wpID == 44 )
    then
        unit:SendChatMessage( 12, 7, CHAT[ math.random( 21, 22 ) ] );

    elseif( wpID == 64 )
    then
        unit:SendChatMessage( 12, 7, CHAT[ 23 ] );

    elseif( wpID == 70 )
    then
        unit:DestroyCustomWaypointMap();
        unit:Despawn( 1000, 0 );
    end
end

RegisterQuestEvent( 333, 2, HARLAN_RESUPPLY.OnComplete );
RegisterUnitEvent( 1433, 19, HARLAN_RESUPPLY.OnReachWP );
