//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		#include "map_files\Tipton\Tipton-Sky-3.dmm"
		#include "map_files\Tipton\Tipton-Surface-2.dmm"
		#include "map_files\Tipton\Tipton-Underground-1.dmm"
		#include "map_files\Tipton\dungeons.dmm"

		#ifdef TRAVISBUILDING
			#include "templates.dm"
		#endif
	#endif
#endif
