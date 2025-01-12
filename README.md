# Life Style

**A LifeStyle Script for RedM VORP. Allows players to have personalised starter items, spawn locations and servers to integrate what a player can do based on their role in society.**

## Script Features
- Menu to select life styles.
- Section to add starter items and money.
- Uses state bags to efficiently store data.

## Getting Life Style
There are 2 ways of getting the life style of a player, using **export** or using the **state bag**. The export uses default civilian if lifestyle is nil whilst the state bag will return nil if lifestyle is nil.
### Server
```lua
Player(source).state.lifeStyle
```
or
```lua
exports["ez_lifestyle"]:GetLifeStyle(source)
```

### Client
```lua
LocalPlayer.state.lifeStyle
```
or
```lua
exports["ez_lifestyle"]:GetLifeStyle()
```

## Documentation
https://docs.ezscripts.org/

![alt text](image.png)
Preview Video: https://youtu.be/0dStdxe9-gw