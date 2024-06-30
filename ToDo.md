# Today:
- 

# Demo ToDo:
- Basic Enemy behaviour
- Redesign level (make smaller)
- New Inventory
- Bear trap
- Prox Alarm
- Timed Distraction
- Panic button item
- Item Crafter
- Item Recycler
- <s>TP Doors</s>
- UI
- Interact system holding items
- Monster design
- Safe Zone design

Details on trello board.

# Bonus ToDo (feature creep):
- Difficulty options
- Full settings
- More traps
- ...More stuff
- Random modifiers/events

Look into web version

Player should have a 6th sense, when they are close to being detected a stinger should play.

Enemy uses similar "menace" value from alien:isolation
High menace effects the environment (flickering lights)

Chainsaw creature

Van company game mode
- Accepting jobs to get money and upgrades

Player cant return to the van for a period of time after a major objective has been completed
Interactable stress relief interactables (bobble head)
Van interior is 2nd Qodot level placed into the scene with a scraper and crafter

Interactions are different based on held object
Base hand need to interact with most objects
This allows for using items with interactables to create puzzles

Placed traps can be picked up by holding interact with an empty hand

Hand held tools (non consumables) will need recharging? Charging takes time or requires major objectives to be completed?

Creature leaving trail of blood could be cool (floor decals)

Add back interaction into base doors (add variable for enableing it)

Create TP doors, use id and exit id, when interacted with teleport the player to an exit door of the exit id

If slot gets eptied, return to slot one (the hand)

Key binds for dropping items, swapping to empty hand, and open inventory

Remove room system, create simpler areas system (the same thing but just the area sections of the rooms)
This will keep the building feeling more natural and ai decisions easier
Areas will have a raycast that can look towards the player to track if it's within line of sight
Areas still track player entries

Creating places where the enemy can jump and hide on the roof, they track the roof height using a ray cast.
This is used for amushing (get common area, find nearest roof spot, hide)

During chases, if the player gets too far, the enemy may enter a vent and tp to the player after a delay
