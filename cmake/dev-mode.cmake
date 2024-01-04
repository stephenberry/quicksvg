enable_language(CXX)

set_property(GLOBAL PROPERTY USE_FOLDERS YES)

include(CTest)

include(FetchContent)

FetchContent_Declare(
   ut
   GIT_REPOSITORY https://github.com/boost-ext/ut.git
   GIT_TAG master
   GIT_SHALLOW TRUE
)

FetchContent_MakeAvailable(ut)

# Done in developer mode only, so users won't be bothered by this :)
file(GLOB_RECURSE headers CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/include/quicksvg/*.hpp")
source_group(TREE "${PROJECT_SOURCE_DIR}/include" PREFIX headers FILES ${headers})

file(GLOB_RECURSE sources CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/src/*.cpp")
source_group(TREE "${PROJECT_SOURCE_DIR}/src" PREFIX sources FILES ${sources})

add_executable(quicksvg_test ${sources} ${headers})

target_link_libraries(quicksvg_test PRIVATE quicksvg::quicksvg ut)

add_test(NAME quicksvg_test COMMAND quicksvg_test)
