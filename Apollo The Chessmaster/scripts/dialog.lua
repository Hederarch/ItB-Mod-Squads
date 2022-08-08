
-- Adds a personality without the use of a csv file.
-- Table of responses to various triggers.
return {
	-- Game States
	Gamestart = {"Registering new opponent. Let us begin, commander.","No human can beat me in games of strategy. Be the first, commander.","I already see the course to victory. The Vek lost before they even began.","Don't get in my way."},
	FTL_Found = {"The unit in that pod isn't in my database. I must learn its methods.","I cannot predict this creature's actions. Whatever it is, it's not from here."},
	--FTL_Start = {},
	Gamestart_PostVictory = {"I know the patterns of these creatures. They cannot outplay me."},
	Death_Revived = {"All part of my master plan."},
	Death_Main = {"I... meant to do that.","A humiliating defeat."},
	Death_Response = {"No no no... This wasn't supposed to happen!","This wasn't part of the plan!","That doesn't count! Take it back! Take it back!"},
	Death_Response_AI = {"A calculated gamble. We must continue.","All part of the plan.","The Vek has fallen for our decoy."},
	TimeTravel_Win = {"This was thrilling. Care for a rematch?"},
	Gameover_Start = {"Power guages dropping! This wasn't part of the plan.","My Mech has surrendered. I shall do the same.","This can't be happening! The Vek must have cheated!","Checkmate."},
	Gameover_Response = {"But... my perfect strategies...","Outplayed by such a simple minded foe...","A catastrophic misplay...","Preparing for a rematch..."},
	
	-- UI Barks
	Upgrade_PowerWeapon = {"This opens many new strategies. Thank you.","The Vek will never see this coming.","",},
	Upgrade_NoWeapon = {"My plans aren't enough on their own. I need weapons.","Do not handicap me like this.","No time for mind games, commander. Give me something to work with.","I cannot play without pieces, commander.","If you must forefeit, do so. This is just humiliating."},
	Upgrade_PowerGeneric = {"A vital step to victory.","This will turn the tide of battle.","All systems nominal. As expected.",},
	
	-- Mid-Battle
	MissionStart = {"Let us analyze the board.","Textbook openings, everyone. Stick to the plan.","Another puzzle. How exciting.","Time to put my plans to work.",},
	Mission_ResetTurn = {"A do-over? How humiliating.","Move withrdrawn. Do better.","We cannot afford these mistakes. Stick to the plan.","All the pieces where they were. Resume the plan."},
	MissionEnd_Dead = {"Total victory. Just as planned.","Another flawless win. You're welcome, everybody.","This is the kind of victory I deserve."},
	MissionEnd_Retreat = {"A surrender. How pathetic.","A draw? How unsatisfying.","Let's hope we don't see a rematch."},

	MissionFinal_Start = {"I have... failed to account for power requirements.","The Grid has not followed us. Its disobedience will cost us greatly.","My Mech is paralyzed in fear. Or are we out of power?","We were supposed to have power here, what happened?",},
	MissionFinal_StartResponse = {"Pylons arriving. And now the endgame begins...","Everything is falling into place. Especially the pylons.","Let us begin our killing blow!","Ah... the soothing buzz of the Grid..."},
	--MissionFinal_FallStart = {},
	MissionFinal_FallResponse = {"The stupid island has outplayed us! How humiliating!","This wasn't part of the plaaaaaaaan!","We're losing positonal advantage! Recalculating..."},
	--MissionFinal_Pylons = {},
	MissionFinal_Bomb = {"Finally a worthy opponent. But can we even destroy it?","A masterful reversal of battle. We cannot win this.","Those idiot bugs! They've outplayed us!"},
	--MissionFinal_BombResponse = {},
	MissionFinal_CaveStart = {"Forget the plan. New plan! Protect that bomb!","Aha! A hidden advantage! Use it well.","The final piece of the puzzle falls into place. Keep it safe!","That bomb has the Vek in check. We mustn't lose it.",},
	--MissionFinal_BombDestroyed = {},
	MissionFinal_BombArmed = {"And with that, our victory is assured.","At last, the plan is complete.","That's enough, everyone. We've won."},

	PodIncoming = {"Just as I predicted! A Time Pod!","So I was correct... We'll need this."},
	PodResponse = {"Edit to the plan: collect that pod!","Feeling lucky, Apollo?","This pod will prove vital to our victory. Secure it at once!"},
	PodCollected_Self = {"Thank me later. Back to work!","And with this, our victory grows closer."},
	PodDestroyed_Obs = {"It was unecessary anyway. ...I hope.","We can succeed without it. ...Right?","A gruesome misplay. How humiliating.","Reverting edits to the plan. Proceed as normal."},
	Secret_DeviceSeen_Mountain = {"Unidentified signal from that mountain. Is it a trap?","Something's not right... That mountain is talking..."},
	Secret_DeviceSeen_Ice = {"Unidentified signal from under the ice. Is it a trap?","Something's not right... A signal in the water..."},
	Secret_DeviceUsed = {"Don't get distracted. Proceed with the plan.","This device confuses me. Is it a trap?"},
	Secret_Arriving = {"We've triggered some kind of weapon! Or is it a time pod?","A pod! Clever tactic, whatever you are."},
	Emerge_Detected = {"Incoming enemies. Defensive maneuvers!","Just as I predicted. Don't let them surface!"},
	Emerge_Success = {"More bugs to play with. How annoying.","The Vek are gaining a material advantage."},
	Emerge_FailedMech = {"Outplayed.","I saw that coming."},
	Emerge_FailedVek = {"A strategic victory. The Vek are keeping themselves manageable.","Getting in each others' way. How clumsy."},

	-- Mech State
	Mech_LowHealth = {"No more mistakes! I can't take it!","I'm nearly down. Play this carefully, Apollo.","A calculated gamble. Don't push it too far."},
	Mech_Webbed = {"They've got me cornered.","A good strategy, but not enough!","I'm in check!"},
	Mech_Shielded = {"A valuable contingency.","I love a good backup plan."},
	Mech_Repaired = {"Damage solved. Now to avoid these mistakes in the first place..."},
	Pilot_Level_Self = {"My genius knows no bounds."},
	Pilot_Level_Obs = {"I've taught you well, #main_second.","You've surpassed my predictions, #main_second."},
	Mech_ShieldDown = {"No more room for mistakes.","An acceptable loss. Proceed as normal.","I meant to do that."},

	-- Damage Done
	Vek_Drown = {"An effective cleanup.","Vek washed off the board.","Hit. Vek sunk.","The water is cooperating nicely.","Outsmarted by a puddle. Pathetic."},
	Vek_Fall = {"The Vek fell for our trap.","Everything's falling into place.","Chances of Vek survival at 0%. Well done.","Outsmarted by a hole. Pathetic."},
	Vek_Smoke = {"Vek neutralized, for now.","The Vek cannot think inside that smoke.","Vek stunned. Now for the kill!","Vek is in check, for now."},
	Vek_Frozen = {"Vek put on pause.","Vek and the ice have reached a stalemate.","We'll deal with that later. Proceed as normal.","Outsmarted by an ice cube. Pathetic."},
	VekKilled_Self = {"Another capture for me.","I saw this coming hours ago.","All part of the plan.","Vek losing material advantage."},
	VekKilled_Obs = {"Well played, #main_second.","An effective capture.","All part of the plan.","A fine move."},
	VekKilled_Vek = {"Another flawless prediction.","Such simple-minded creatures.","Vek losing material advantage.","How pathetic.","The Vek play right into my hands."},

	DoubleVekKill_Self = {"And that's why I'm the best.","Can anyone else do better?","Impressed yet?","Thoroughly outsmarted."},
	DoubleVekKill_Obs = {"Well played, #main_second.","An efficient capture.","You've surpassed my predictions, #main_second.","An expert move."},
	DoubleVekKill_Vek = {"Vek rapidly losing material advantage.","Two down. Well played... Vek...?","Is the Vek a traitor? Or simply that stupid?","These foolish bugs confuse me sometimes."},

	MntDestroyed_Self = {"A new space for the board.","I do not tolerate obstacles.","This should open up some new options."},
	MntDestroyed_Obs = {"Must I remind you to shoot at the bugs?","Unnecessary demolition. But perhaps it will help.","No time for vandalism. Stick to the plan."},
	MntDestroyed_Vek = {"Is this part of their plan?","Such an inefficient strategy.","Such a crude act of vandalism."},

	PowerCritical = {"The Grid is nearly gone. No more room for mistakes.","The Vek have us cornered. Play this carefully, Apollo."},
	Bldg_Destroyed_Self = {"A... tactical loss. It had to be done.","It... had to be done. I do not make mistakes."},
	Bldg_Destroyed_Obs = {"Such a cruel execution. How heartless.","A devastating mistake.","Your mistakes cost lives."},
	Bldg_Destroyed_Vek = {"We cannot lose more pieces! Do better!","A fatal oversight and a gruesome tragedy.","And the Grid hums even quieter."},
	Bldg_Resisted = {"It held. Just as I predicted.","No deaths. All according to plan.","Good. Don't take that risk again.","Odd, I predicted it would crumble."},


	-- Shared Missions
	--[[Mission_Train_TrainStopped = {},
	Mission_Train_TrainDestroyed = {},
	Mission_Block_Reminder = {},

	-- Archive
	Mission_Airstrike_Incoming = {},
	Mission_Tanks_Activated = {},
	Mission_Tanks_PartialActivated = {},
	Mission_Dam_Reminder = {},
	Mission_Dam_Destroyed = {},
	Mission_Satellite_Destroyed = {},
	Mission_Satellite_Imminent = {},
	Mission_Satellite_Launch = {},
	Mission_Mines_Vek = {},

	-- RST
	Mission_Terraform_Destroyed = {},
	Mission_Terraform_Attacks = {},
	Mission_Cataclysm_Falling = {},
	Mission_Lightning_Strike_Vek = {},
	Mission_Solar_Destroyed = {},
	Mission_Force_Reminder = {},

	-- Pinnacle
	Mission_Freeze_Mines_Vek = {},
	Mission_Factory_Destroyed = {},
	Mission_Factory_Spawning = {},
	Mission_Reactivation_Thawed = {},
	Mission_SnowStorm_FrozenVek = {},
	Mission_SnowStorm_FrozenMech = {},
	BotKilled_Self = {},
	BotKilled_Obs = {},

	-- Detritus
	Mission_Disposal_Destroyed = {},
	Mission_Disposal_Activated = {},
	Mission_Barrels_Destroyed = {},
	Mission_Power_Destroyed = {},
	Mission_Teleporter_Mech = {},
	Mission_Belt_Mech = {},]]
}