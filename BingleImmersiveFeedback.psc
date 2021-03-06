Scriptname BingleImmersiveFeedback extends ReferenceAlias

BingleImmersiveFeedbackMCM property pMCMScript auto
Weapon property Unarmed auto
Sound property BingleDeflect auto

Function RegisterMainScript() native
Function EvaluateEvent(string eventname) global native

Actor player
Actor translateTarget
Function InitializeStuff()
	pMCMScript.UpdateIFState(1)
	player = GetActorReference()
	UnregisterForAnimationEvent(player, "attackStop")
	UnregisterForAnimationEvent(player, "preHitFrame")
	UnregisterForAnimationEvent(player, "weaponSwing")
	UnregisterForAnimationEvent(player, "weaponLeftSwing")
	UnregisterForAnimationEvent(player, "AttackWinStart")
	UnregisterForAnimationEvent(player, "AttackWinStartLeft")
	UnregisterForAnimationEvent(player, "AttackWinEnd")
	UnregisterForAnimationEvent(player, "AttackWinEndLeft")
	bool a = RegisterForAnimationEvent(player, "attackStop")
	bool b = RegisterForAnimationEvent(player, "preHitFrame")
	bool c = RegisterForAnimationEvent(player, "weaponSwing")
	bool d = RegisterForAnimationEvent(player, "weaponLeftSwing")
	bool e = RegisterForAnimationEvent(player, "AttackWinStart")
	bool f = RegisterForAnimationEvent(player, "AttackWinStartLeft")
	bool g = RegisterForAnimationEvent(player, "AttackWinEnd")
	bool h = RegisterForAnimationEvent(player, "AttackWinEndLeft")
EndFunction

Event OnInit()
	pMCMScript.UpdateIFState(0)
	RegisterMainScript()
EndEvent

Event OnPlayerLoadGame()
	RegisterMainScript()
EndEvent

Event OnSyncConfig(int type, float v)
	pMCMScript.UpdateIFState(2)
	pMCMScript.SyncConfig(type, v)
EndEvent

Event OnInitializeRequested(int dummy)
	InitializeStuff()
EndEvent

Event OnFistRequested(ObjectReference _ac)
	Utility.Wait(0.1)
	Actor ac = _ac as Actor
	if(ac.GetEquippedItemType(0) + ac.GetEquippedItemType(1) == 0)
		ac.EquipItem(Unarmed, false, true)
	endif
EndEvent

Event OnNotificationRequest(string content)
	Debug.Notification(content)
EndEvent

Event OnMessageBoxRequest(string content)
	Debug.MessageBox(content)
EndEvent

Event OnTranslateToTarget(ObjectReference _ac)
	translateTarget = (_ac as Actor)
EndEvent

Event OnTranslateTo(float x, float y, float z, float vel)
	translateTarget.TranslateTo(x, y, z, translateTarget.GetAngleX(), translateTarget.GetAngleY(), translateTarget.GetAngleZ(), vel, 0)
EndEvent

Event OnStopTranslation(int i)
	translateTarget.StopTranslation()
EndEvent

Event OnDeflectSoundPlay(ObjectReference obj)
	BingleDeflect.Play(obj)
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	EvaluateEvent(asEventName)
	;Debug.Notification(asEventName + " fired.")
	;if(asEventName == "preHitFrame")
	;	(akSource as Actor).ForceAV("weaponSpeedMult", pMCMScript.valuePreAttackSpeed)
	;elseif(asEventName == "weaponSwing")
	;	weptype = (akSource as Actor).GetEquippedWeapon(false).GetWeaponType()
	;	if(weptype == 5 || weptype == 6)
	;		(akSource as Actor).ForceAV("weaponSpeedMult", pMCMScript.valueSwingSpeed)
	;	elseif(weptype == 0 || weptype == 1 || weptype == 3 || weptype == 4)
	;		(akSource as Actor).ForceAV("weaponSpeedMult", pMCMScript.valueSwingSpeed1H)
	;	elseif(weptype == 2)
	;		(akSource as Actor).ForceAV("weaponSpeedMult", pMCMScript.valueSwingSpeedDagger)
	;	endif
	;elseif(asEventName == "AttackWinStart")
	;	(akSource as Actor).ForceAV("weaponSpeedMult", pMCMScript.valueBaseSpeed)
	;elseif(asEventName == "weaponLeftSwing")
	;	weptype = (akSource as Actor).GetEquippedWeapon(true).GetWeaponType()
	;	if(weptype == 5 || weptype == 6)
	;		(akSource as Actor).ForceAV("LeftWeaponSpeedMult", pMCMScript.valueSwingSpeed)
	;	elseif(weptype == 0 || weptype == 1 || weptype == 3 || weptype == 4)
	;		(akSource as Actor).ForceAV("LeftWeaponSpeedMult", pMCMScript.valueSwingSpeed1H)
	;	elseif(weptype == 2)
	;		(akSource as Actor).ForceAV("LeftWeaponSpeedMult", pMCMScript.valueSwingSpeedDagger)
	;	endif
	;endif
EndEvent