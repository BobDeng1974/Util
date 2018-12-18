#
# This file is part of the Util library.
# Copyright (C) 2018 Sascha Brandt <sascha@brandt.graphics>
#
# This library is subject to the terms of the Mozilla Public License, v. 2.0.
# You should have received a copy of the MPL along with this library; see the 
# file LICENSE. If not, you can obtain one at http://mozilla.org/MPL/2.0/.
#
include(FetchContent)

find_package(SDL2_net 2.0.1 QUIET)
if(NOT SDL2_NET_FOUND)
	if(WIN32)
		# download prebuild binaries for windows
		FetchContent_Declare(
	    sdl2_net
	    URL https://www.libsdl.org/projects/SDL_net/release/SDL2_net-devel-2.0.1-mingw.tar.gz
	    URL_HASH MD5=D069C815763D3575DB07FFF257EAF209
		)

		FetchContent_GetProperties(sdl2_net)
		if(NOT sdl2_net_POPULATED)
	    execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append "Fetching SDL2 Net...")
	    FetchContent_Populate(sdl2_net)
	    execute_process(COMMAND ${CMAKE_COMMAND} -E echo "Done")
		endif()
			
		find_path(SDL2_NET_INCLUDE_DIRS NAMES SDL_net.h HINTS ${sdl2_net_SOURCE_DIR}/${ARCH_TRIPLET}/include PATH_SUFFIXES SDL2)	
		find_library(SDL2_NET_LIBRARY NAMES SDL2_net HINTS ${sdl2_net_SOURCE_DIR}/${ARCH_TRIPLET}/bin)
		
		set(SDL2_NET_LIBRARIES ${SDL2_NET_LIBRARY})
		set(SDL2_NET_FOUND TRUE)
	endif()
endif()
