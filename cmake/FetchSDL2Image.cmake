#
# This file is part of the Util library.
# Copyright (C) 2018 Sascha Brandt <sascha@brandt.graphics>
#
# This library is subject to the terms of the Mozilla Public License, v. 2.0.
# You should have received a copy of the MPL along with this library; see the 
# file LICENSE. If not, you can obtain one at http://mozilla.org/MPL/2.0/.
#
include(FetchContent)

find_package(SDL2_image 2.0.4 QUIET)
if(NOT SDL2_IMAGE_FOUND)
	if(WIN32)
		# download prebuild binaries for windows
		FetchContent_Declare(
	    sdl2_image
	    URL https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.4-mingw.tar.gz
	    URL_HASH MD5=53FD232CE4D70A3AF18909A8A7248094
		)

		FetchContent_GetProperties(sdl2_image)
		if(NOT sdl2_image_POPULATED)
	    execute_process(COMMAND ${CMAKE_COMMAND} -E echo_append "Fetching SDL2 Image...")
	    FetchContent_Populate(sdl2_image)
	    execute_process(COMMAND ${CMAKE_COMMAND} -E echo "Done")
		endif()
		
		find_path(SDL2_IMAGE_INCLUDE_DIRS NAMES SDL_image.h HINTS ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/include PATH_SUFFIXES SDL2)
		
		find_library(SDL2_IMAGE_LIBRARY NAMES SDL2_image HINTS ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/bin)
		find_library(SDL2_IMAGE_JPEG_LIBRARY NAMES libjpeg-9 HINTS ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/bin)
		find_library(SDL2_IMAGE_PNG_LIBRARY NAMES libpng16-16 HINTS ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/bin)
		find_library(SDL2_IMAGE_TIFF_LIBRARY NAMES libtiff-5 HINTS ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/bin)
		find_library(SDL2_IMAGE_WEBP_LIBRARY NAMES libwebp-7 HINTS ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/bin)
		find_library(SDL2_IMAGE_ZLIB_LIBRARY NAMES zlib1 HINTS ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/bin)
		
		set(SDL2_IMAGE_LIBRARIES ${SDL2_IMAGE_LIBRARY} ${SDL2_IMAGE_JPEG_LIBRARY} ${SDL2_IMAGE_PNG_LIBRARY} ${SDL2_IMAGE_TIFF_LIBRARY} ${SDL2_IMAGE_WEBP_LIBRARY} ${SDL2_IMAGE_ZLIB_LIBRARY})
		set(SDL2_IMAGE_FOUND TRUE)
	endif()
endif()
