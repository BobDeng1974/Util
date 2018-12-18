include(FetchContent)

if(WIN32)
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
	
	find_library(SDL2_IMAGE_LIBRARIES
	  NAMES SDL2_image
	  HINTS
	    ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/bin
	)
	find_path(SDL2_IMAGE_INCLUDE_DIR
	  NAMES SDL_image.h
	  HINTS
	    ${sdl2_image_SOURCE_DIR}/${ARCH_TRIPLET}/include
	  PATH_SUFFIXES SDL2
	)
	
	target_compile_definitions(Util PRIVATE UTIL_HAVE_LIB_SDL2_IMAGE)
	target_include_directories(Util PRIVATE ${SDL2_IMAGE_INCLUDE_DIR})
	target_link_libraries(Util PRIVATE ${SDL2_IMAGE_LIBRARIES})
	add_custom_command(TARGET Util PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${SDL2_IMAGE_LIBRARIES} $<TARGET_FILE_DIR:Util>)
else()
	# Dependency to SDL2_image
  find_package(SDL2_image 2.0.0)
  if(SDL2_IMAGE_FOUND)
  	target_compile_definitions(Util PRIVATE UTIL_HAVE_LIB_SDL2_IMAGE)
  	target_include_directories(Util PRIVATE ${SDL2_IMAGE_INCLUDE_DIRS})
  	target_link_libraries(Util PRIVATE ${SDL2_IMAGE_LIBRARIES})
  endif()
endif()
