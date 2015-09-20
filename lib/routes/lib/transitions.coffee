if Meteor.isClient
	ANIMATION_DURATION = 500

	slideToTop = ->
		hooks =
			insertElement: (node, next) ->
				$(node).addClass "sliding-to-top"
				$(node).insertBefore(next)
				Meteor.setTimeout (-> $(node).removeClass "sliding-to-top"), ANIMATION_DURATION
			removeElement: (node) ->
				Meteor.setTimeout (-> $(node).remove()), ANIMATION_DURATION
			moveElement: (node, next) ->
				hooks.removeElement node
				hooks.insertElement node, next
		return -> hooks
	slideToBottom = ->
		hooks =
			insertElement: (node, next) ->
				$(node).insertBefore(next)
			removeElement: (node) ->
				$(node).addClass "sliding-to-bottom"
				Meteor.setTimeout (-> $(node).remove()), ANIMATION_DURATION
			moveElement: (node, next) ->
				hooks.removeElement node
				hooks.insertElement node, next
		return -> hooks
	slide = (slideDirection) ->
		direction = new ReactiveVar(slideDirection)
		hooks =
			insertElement: (node, next) ->
				dir = direction.get()
				$(node).addClass "sliding-from-#{dir}"
				$(node).insertBefore(next)
				Meteor.setTimeout (-> $(node).removeClass "sliding-from-#{dir}"), ANIMATION_DURATION
			removeElement: (node) ->
				dir = direction.get()
				if dir isnt 'top' and dir isnt 'bottom'
					oppositeDirection = switch dir
						when 'left' then 'right'
						when 'right' then 'left'
					oppositeDirection = if dir is 'left' then 'right' else 'left'
					$(node).addClass "sliding-to-#{oppositeDirection}"
					Meteor.setTimeout (-> $(node).remove()), ANIMATION_DURATION
			moveElement: (node, next) ->
				hooks.removeElement node
				hooks.insertElement node, next
		return -> hooks

	Momentum.registerPlugin 'rtl', slide('left')
	Momentum.registerPlugin 'ltr', slide('right')
	Momentum.registerPlugin 'bottom-to-top', slideToTop()
	Momentum.registerPlugin 'top-to-bottom', slideToBottom()
