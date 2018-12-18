include(FetchContent)

if(WIN32)
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
	
	find_library(SDL2_LIBRARIES
	  NAMES SDL2
	  HINTS
	    ${sdl2_SOURCE_DIR}/${ARCH_TRIPLET}/bin
	)
	find_path(SDL2_INCLUDE_DIR
	  NAMES SDL.h
	  HINTS
	    ${sdl2_SOURCE_DIR}/${ARCH_TRIPLET}/include
	  PATH_SUFFIXES SDL2
	)
	
	target_compile_definitions(Util PRIVATE UTIL_HAVE_LIB_SDL2)
	target_include_directories(Util PRIVATE ${SDL2_INCLUDE_DIR})
	target_link_libraries(Util PRIVATE ${SDL2_LIBRARIES})
	add_custom_command(TARGET Util PRE_BUILD
                   COMMAND ${CMAKE_COMMAND} -E copy
                     ${SDL2_LIBRARIES} $<TARGET_FILE_DIR:Util>)
else()
  # Dependency to SDL2
  find_package(SDL2)
  if(SDL2_FOUND)
  	target_compile_definitions(Util PRIVATE UTIL_HAVE_LIB_SDL2)
  	target_include_directories(Util PRIVATE ${SDL2_INCLUDE_DIRS})
  	target_link_libraries(Util PRIVATE ${SDL2_LIBRARIES})
  endif()
endif()
