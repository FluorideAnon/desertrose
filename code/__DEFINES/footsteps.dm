#define FOOTSTEP_WOOD "wood"
#define FOOTSTEP_FLOOR "floor"
#define FOOTSTEP_PLATING "plating"
#define FOOTSTEP_CARPET "carpet"
#define FOOTSTEP_SAND "sand"
#define FOOTSTEP_GRASS "grass"
#define FOOTSTEP_WATER "water"
#define FOOTSTEP_LAVA "lava"
#define FOOTSTEP_MEAT "meat"
#define FOOTSTEP_RUST "rust"

#define FOOTSTEP_DIRT "dirt"
#define FOOTSTEP_ROAD "road"
#define FOOTSTEP_SNOW "snow"
#define FOOTSTEP_GRAVEL "gravel"

//barefoot sounds
#define FOOTSTEP_WOOD_BAREFOOT "woodbarefoot"
#define FOOTSTEP_WOOD_CLAW "woodclaw"
#define FOOTSTEP_HARD_BAREFOOT "hardbarefoot"
#define FOOTSTEP_HARD_CLAW "hardclaw"
#define FOOTSTEP_CARPET_BAREFOOT "carpetbarefoot"
//misc footstep sounds
#define FOOTSTEP_GENERIC_HEAVY "heavy"

#define FOOTPRINT_SHOE	"shoe"
#define FOOTPRINT_FOOT	"foot"
#define FOOTPRINT_PAW	"paw"
#define FOOTPRINT_CLAW	"claw"
#define FOOTPRINT_WHEEL	"wheels"
#define FOOTPRINT_TRAIL	"trails_"
#define FOOTPRINT_SNAKE	"snake"
#define FOOTPRINT_DRAG	"drag"

#define FOOTSTEP_DIRT_BAREFOOT	"dirtbare"
#define FOOTSTEP_SAND_BAREFOOT	"sandbare"
#define FOOTSTEP_SNOW_BAREFOOT	"snowbare"
#define FOOTSTEP_GRAVEL_BAREFOOT	"gravelbare"
#define FOOTSTEP_ROAD_BAREFOOT	"roadbare"


//footstep mob defines
#define FOOTSTEP_MOB_CLAW 1
#define FOOTSTEP_MOB_BAREFOOT 2
#define FOOTSTEP_MOB_HEAVY 3
#define FOOTSTEP_MOB_SHOE 4
#define FOOTSTEP_MOB_HUMAN 5 //Warning: Only works on /mob/living/carbon/human
#define FOOTSTEP_MOB_SLIME 6
#define FOOTSTEP_MOB_CRAWL 7

/*

id = list(
list(sounds),
base volume,
extra range addition
)


*/

GLOBAL_LIST_INIT(footstep, list(
	FOOTSTEP_DIRT = list(list(
		'sound/f13effects/footsteps/dirt/dirt1.ogg',
		'sound/f13effects/footsteps/dirt/dirt2.ogg',
		'sound/f13effects/footsteps/dirt/dirt3.ogg',
		'sound/f13effects/footsteps/dirt/dirt4.ogg',
		'sound/f13effects/footsteps/dirt/dirt5.ogg'), 75, 0),
	FOOTSTEP_SAND = list(list(
		'sound/f13effects/footsteps/sand/sand1.ogg',
		'sound/f13effects/footsteps/sand/sand2.ogg',
		'sound/f13effects/footsteps/sand/sand3.ogg',
		'sound/f13effects/footsteps/sand/sand4.ogg'), 100, 1),
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/wood1.ogg',
		'sound/effects/footstep/wood2.ogg',
		'sound/effects/footstep/wood3.ogg',
		'sound/effects/footstep/wood4.ogg',
		'sound/effects/footstep/wood5.ogg'), 100, 0),
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/floor1.ogg',
		'sound/effects/footstep/floor2.ogg',
		'sound/effects/footstep/floor3.ogg',
		'sound/effects/footstep/floor4.ogg',
		'sound/effects/footstep/floor5.ogg'), 75, -1),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/plating1.ogg',
		'sound/effects/footstep/plating2.ogg',
		'sound/effects/footstep/plating3.ogg',
		'sound/effects/footstep/plating4.ogg',
		'sound/effects/footstep/plating5.ogg'), 100, 1),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/carpet1.ogg',
		'sound/effects/footstep/carpet2.ogg',
		'sound/effects/footstep/carpet3.ogg',
		'sound/effects/footstep/carpet4.ogg',
		'sound/effects/footstep/carpet5.ogg'), 75, -1),
	FOOTSTEP_ROAD = list(list(
		'sound/f13effects/footsteps/road/road_walk1.ogg',
		'sound/f13effects/footsteps/road/road_walk2.ogg',
		'sound/f13effects/footsteps/road/road_walk3.ogg',
		'sound/f13effects/footsteps/road/road_walk4.ogg',
		'sound/f13effects/footsteps/road/road_walk5.ogg',
		'sound/f13effects/footsteps/road/road_walk6.ogg'), 60, 1),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'), 75, 0),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 1),
	FOOTSTEP_RUST = list(list(
		'sound/f13effects/footsteps/metal/hull1.ogg',
		'sound/f13effects/footsteps/metal/hull2.ogg',
		'sound/f13effects/footsteps/metal/hull3.ogg',
		'sound/f13effects/footsteps/metal/hull4.ogg',
		'sound/f13effects/footsteps/metal/hull5.ogg'), 100, 1),
	FOOTSTEP_SNOW = list(list(
		'sound/f13effects/footsteps/snow/snow1.ogg',
		'sound/f13effects/footsteps/snow/snow2.ogg',
		'sound/f13effects/footsteps/snow/snow3.ogg',
		'sound/f13effects/footsteps/snow/snow4.ogg',
		'sound/f13effects/footsteps/snow/snow5.ogg'), 100, 1),
	FOOTSTEP_GRAVEL = list(list(
		'sound/f13effects/footsteps/gravel/gravel1.ogg',
		'sound/f13effects/footsteps/gravel/gravel2.ogg',
		'sound/f13effects/footsteps/gravel/gravel3.ogg',
		'sound/f13effects/footsteps/gravel/gravel4.ogg'), 100, 1),
	FOOTSTEP_LAVA = list(list(
		'sound/effects/footstep/lava1.ogg',
		'sound/effects/footstep/lava2.ogg',
		'sound/effects/footstep/lava3.ogg'), 100, 0),
	FOOTSTEP_MEAT = list(list(
		'sound/effects/meatslap.ogg'), 100, 0),
))

//bare footsteps lists
GLOBAL_LIST_INIT(barefootstep, list(
	FOOTSTEP_DIRT_BAREFOOT = list(list(
		'sound/f13effects/footsteps/dirt/dirt1.ogg',
		'sound/f13effects/footsteps/dirt/dirt2.ogg',
		'sound/f13effects/footsteps/dirt/dirt3.ogg',
		'sound/f13effects/footsteps/dirt/dirt4.ogg',
		'sound/f13effects/footsteps/dirt/dirt5.ogg'), 50, 0),
	FOOTSTEP_ROAD_BAREFOOT = list(list(
		'sound/f13effects/footsteps/road/road_walk1.ogg',
		'sound/f13effects/footsteps/road/road_walk2.ogg',
		'sound/f13effects/footsteps/road/road_walk3.ogg',
		'sound/f13effects/footsteps/road/road_walk4.ogg',
		'sound/f13effects/footsteps/road/road_walk5.ogg',
		'sound/f13effects/footsteps/road/road_walk6.ogg'), 40, 1),
	FOOTSTEP_WOOD_BAREFOOT = list(list(
		'sound/effects/footstep/woodbarefoot1.ogg',
		'sound/effects/footstep/woodbarefoot2.ogg',
		'sound/effects/footstep/woodbarefoot3.ogg',
		'sound/effects/footstep/woodbarefoot4.ogg',
		'sound/effects/footstep/woodbarefoot5.ogg'), 80, -1),
	FOOTSTEP_HARD_BAREFOOT = list(list(
		'sound/effects/footstep/hardbarefoot1.ogg',
		'sound/effects/footstep/hardbarefoot2.ogg',
		'sound/effects/footstep/hardbarefoot3.ogg',
		'sound/effects/footstep/hardbarefoot4.ogg',
		'sound/effects/footstep/hardbarefoot5.ogg'), 80, -1),
	FOOTSTEP_CARPET_BAREFOOT = list(list(
		'sound/effects/footstep/carpetbarefoot1.ogg',
		'sound/effects/footstep/carpetbarefoot2.ogg',
		'sound/effects/footstep/carpetbarefoot3.ogg',
		'sound/effects/footstep/carpetbarefoot4.ogg',
		'sound/effects/footstep/carpetbarefoot5.ogg'), 75, -2),
	FOOTSTEP_SAND_BAREFOOT = list(list(
		'sound/f13effects/footsteps/sand/sand1.ogg',
		'sound/f13effects/footsteps/sand/sand2.ogg',
		'sound/f13effects/footsteps/sand/sand3.ogg',
		'sound/f13effects/footsteps/sand/sand4.ogg'), 50, 1),
	FOOTSTEP_SNOW_BAREFOOT = list(list(
		'sound/f13effects/footsteps/snow/snow1.ogg',
		'sound/f13effects/footsteps/snow/snow2.ogg',
		'sound/f13effects/footsteps/snow/snow3.ogg',
		'sound/f13effects/footsteps/snow/snow4.ogg',
		'sound/f13effects/footsteps/snow/snow5.ogg'), 50, 1),
	FOOTSTEP_GRAVEL_BAREFOOT = list(list(
		'sound/f13effects/footsteps/gravel/gravel1.ogg',
		'sound/f13effects/footsteps/gravel/gravel2.ogg',
		'sound/f13effects/footsteps/gravel/gravel3.ogg',
		'sound/f13effects/footsteps/gravel/gravel4.ogg'), 75, 1),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'), 75, 0),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 1),
	FOOTSTEP_LAVA = list(list(
		'sound/effects/footstep/lava1.ogg',
		'sound/effects/footstep/lava2.ogg',
		'sound/effects/footstep/lava3.ogg'), 100, 0),
	FOOTSTEP_MEAT = list(list(
		'sound/effects/meatslap.ogg'), 100, 0),
	FOOTSTEP_RUST = list(list(
		'sound/effects/footstep/rustystep1.ogg'), 100, 0)
))

//claw footsteps lists
GLOBAL_LIST_INIT(clawfootstep, list(
	FOOTSTEP_WOOD_CLAW = list(list(
		'sound/effects/footstep/woodclaw1.ogg',
		'sound/effects/footstep/woodclaw2.ogg',
		'sound/effects/footstep/woodclaw3.ogg',
		'sound/effects/footstep/woodclaw2.ogg',
		'sound/effects/footstep/woodclaw1.ogg'), 90, 1),
	FOOTSTEP_HARD_CLAW = list(list(
		'sound/effects/footstep/hardclaw1.ogg',
		'sound/effects/footstep/hardclaw2.ogg',
		'sound/effects/footstep/hardclaw3.ogg',
		'sound/effects/footstep/hardclaw4.ogg',
		'sound/effects/footstep/hardclaw1.ogg'), 90, 1),
	FOOTSTEP_CARPET_BAREFOOT = list(list(
		'sound/effects/footstep/carpetbarefoot1.ogg',
		'sound/effects/footstep/carpetbarefoot2.ogg',
		'sound/effects/footstep/carpetbarefoot3.ogg',
		'sound/effects/footstep/carpetbarefoot4.ogg',
		'sound/effects/footstep/carpetbarefoot5.ogg'), 75, -2),
	FOOTSTEP_SAND = list(list(
		'sound/f13effects/footsteps/sand/sand1.ogg',
		'sound/f13effects/footsteps/sand/sand2.ogg',
		'sound/f13effects/footsteps/sand/sand3.ogg',
		'sound/f13effects/footsteps/sand/sand4.ogg'), 100, 1),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'), 75, 0),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 1),
	FOOTSTEP_LAVA = list(list(
		'sound/effects/footstep/lava1.ogg',
		'sound/effects/footstep/lava2.ogg',
		'sound/effects/footstep/lava3.ogg'), 100, 0),
	FOOTSTEP_MEAT = list(list(
		'sound/effects/meatslap.ogg'), 100, 0),
	FOOTSTEP_RUST = list(list(
		'sound/effects/footstep/rustystep1.ogg'), 100, 0)
))

//heavy footsteps list
GLOBAL_LIST_INIT(heavyfootstep, list(
	FOOTSTEP_GENERIC_HEAVY = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg'), 100, 2),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 2),
	FOOTSTEP_LAVA = list(list(
		'sound/effects/footstep/lava1.ogg',
		'sound/effects/footstep/lava2.ogg',
		'sound/effects/footstep/lava3.ogg'), 100, 0),
	FOOTSTEP_MEAT = list(list(
		'sound/effects/meatslap.ogg'), 100, 0),
	FOOTSTEP_RUST = list(list(
		'sound/effects/footstep/rustystep1.ogg'), 150, 2)
))
