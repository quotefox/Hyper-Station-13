/mob/living/carbon/proc/expand_belly(expansion = 1)
	var/obj/item/organ/genital/belly/_belly = getorganslot("belly")
	if(!expansion || !_belly || !_belly.inflatable)
		return
	var/original_size = _belly.size
	_belly.size = clamp(_belly.size + expansion, BELLY_MIN_SIZE, BELLY_MAX_SIZE)
	if(_belly.size == original_size)
		return
	var/_verb = "expand"
	switch(_belly.size)
		if(BELLY_MAX_SIZE to INFINITY)
			_verb = "stretch to its limit"
		if(BELLY_STRETCH_SIZE to BELLY_MAX_SIZE)
			_verb = "stretch"
		if(BELLY_STRAIN_SIZE to BELLY_STRETCH_SIZE)
			_verb = "strain"
	to_chat(src, "<span class='userlove'>You feel your belly [_verb].</span>")
	_belly.update()


/mob/living/carbon/proc/shrink_belly(shrinkage = 1)
	var/obj/item/organ/genital/belly/_belly = getorganslot("belly")
	if(!shrinkage ||!_belly || !_belly.inflatable)
		return
	var/original_size = _belly.size
	_belly.size = clamp(_belly.size - shrinkage, BELLY_MIN_SIZE, BELLY_MAX_SIZE)
	if(_belly.size == original_size)
		return
	var/_verb = "diminish"
	var/_class = "userlove"
	if(_belly.size == BELLY_MIN_SIZE)
		_verb = "can't shrink anymore"
		_class = "warning"
	to_chat(src, "<span class='[_class]'>You feel your belly [_verb].</span>")
	_belly.update()