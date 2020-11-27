--[[
      ArcLuaScripts for ArcEmu
      www.ArcEmu.org
      Elwynn Forest: Cylina Darkheart and Minion
      Engine: A.L.E
      Credits: nil

      Developer notes: since summons spells are bugged or unimplemented in arcemu
                       (if unit is creature) we dont have more choice than spawn them
                       manually... at least for now.
--]]

local FACTION_ALLIANCE = 12;
local UNIT_FIELD_SUMMONEDBY = 0x0006 + 0x0008;
local UNIT_FIELD_CREATEDBY  = 0x0006 + 0x000A;

CYLINA_DARKHEART = {}

function CYLINA_DARKHEART.OnSpawnAndDeath( unit, event )

    if( event == 4 )

    then

        local minion = unit:GetCreatureNearestCoords( -9466, -6.72, 49.79, 12922 );

        if( minion ~= nil )

        then

            minion:Despawn( 1000, 0 );

        end

    elseif( event == 18 )

    then
        -- unit:CastSpell( 11939 ); -- cast "Summon Imp" (bugged spell on creature cast)

        local minion = unit:SpawnCreature( 12922, -9466, -6.72, 49.79, 4.5, FACTION_ALLIANCE, 0, 0, 0, 0, 1, 0 );

        local guid = unit:GetGUID();

        minion:SetUInt64Value( UNIT_FIELD_SUMMONEDBY, guid );

        minion:SetUInt64Value( UNIT_FIELD_CREATEDBY, guid );

    end

end

RegisterUnitEvent( 6374, 4, CYLINA_DARKHEART.OnSpawnAndDeath );

RegisterUnitEvent( 6374, 18, CYLINA_DARKHEART.OnSpawnAndDeath );