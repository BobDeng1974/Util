#
# This file is part of the Util library.
# Copyright (C) 2018 Sascha Brandt <sascha@brandt.graphics>
#
# This library is subject to the terms of the Mozilla Public License, v. 2.0.
# You should have received a copy of the MPL along with this library; see the 
# file LICENSE. If not, you can obtain one at http://mozilla.org/MPL/2.0/.
#
include(FetchContent)

find_package(SDL2 2.0.9 QUIET)
if(NOT SDL2_FOUND)
	if(WIN32)
		# download prebuild binaries for windows
		FetchContent_Declare(
	    sdl2
	    URL https://www.libsdl.org/release/SDL2-devel-2.0.9-mingw.tar.gz
	    URL_HASH MD5=F5645EED64214C3BC22A3E157FC1F15F
		)

		FetchContent_GetProperties(sdl2)
		if(NOT sdl2_POPULATED)
	    execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append "Fetching SDL2...")
	    FetchContent_Populate(sdl2)
	    execute_process(COMMAND ${CMAKE_COMMAND} -E echo "Done")
		endif()
					
		find_path(SDL2_INCLUDE_DIRS NAMES SDL.h HINTS ${sdl2_SOURCE_DIR}/${ARCH_TRIPLET}/include PATH_SUFFIXES SDL2)	
		find_library(SDL2_LIBRARY NAMES SDL2 HINTS ${sdl2_SOURCE_DIR}/${ARCH_TRIPLET}/bin)

		set(SDL2_LIBRARIES ${SDL2_LIBRARY})
		set(SDL2_FOUND TRUE)
  endif()
endif()
