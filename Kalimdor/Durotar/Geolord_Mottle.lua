GEOLORD_MOTTLE = {}

function GEOLORD_MOTTLE.OoCCastBuff( unit, event )

    if( event == 18 )
    then
        unit:RegisterAIUpdateEvent( 1000 );
    else
        if( unit:IsInCombat() == false and unit:HasAura( 324 ) == false )
        then
            unit:FullCastSpell( 324 ); -- Lighting Shield
            unit:ModifyAIUpdateEvent( 600000 );
        end
    end
end

RegisterUnitEvent( 5826, 18, GEOLORD_MOTTLE.OoCCastBuff );
RegisterUnitEvent( 5826, 21, GEOLORD_MOTTLE.OoCCastBuff );