include(FetchContent)

if(WIN32)
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
	
	find_library(SDL2_NET_LIBRARIES
	  NAMES SDL2_net
	  HINTS
	    ${sdl2_net_SOURCE_DIR}/${ARCH_TRIPLET}/bin
	)
	find_path(SDL2_NET_INCLUDE_DIR
	  NAMES SDL_net.h
	  HINTS
	    ${sdl2_net_SOURCE_DIR}/${ARCH_TRIPLET}/include
	  PATH_SUFFIXES SDL2
	)
	
	target_compile_definitions(Util PRIVATE UTIL_HAVE_LIB_SDL2_NET)
	target_include_directories(Util PRIVATE ${SDL2_NET_INCLUDE_DIR})
	target_link_libraries(Util PRIVATE ${SDL2_NET_LIBRARIES})
	add_custom_command(TARGET Util PRE_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${SDL2_NET_LIBRARIES} $<TARGET_FILE_DIR:Util>)
else()	
  # Dependency to SDL2_net
  find_package(SDL2_net 2.0.0)
  if(SDL2_NET_FOUND)
  	target_compile_definitions(Util PRIVATE UTIL_HAVE_LIB_SDL2_NET)
  	target_include_directories(Util PRIVATE ${SDL2_NET_INCLUDE_DIRS})
  	target_link_libraries(Util PRIVATE ${SDL2_NET_LIBRARIES})
  endif()
endif()
