cmake_minimum_required(VERSION 3.18)

include(cmake/prelude.cmake)

project(
    quicksvg
    VERSION 0.0.1
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

add_library(quicksvg_quicksvg INTERFACE)
add_library(quicksvg::quicksvg ALIAS quicksvg_quicksvg)

if (MSVC)
   string(REGEX MATCH "\/cl(.exe)?$" matched_cl ${CMAKE_CXX_COMPILER})
   if (matched_cl)
      # for a C++ standards compliant preprocessor, not needed for clang-cl
      target_compile_options(quicksvg_quicksvg INTERFACE "/Zc:preprocessor" /GL /permissive- /Zc:lambda)
      target_link_options(quicksvg_quicksvg INTERFACE /LTCG /INCREMENTAL:NO)
   endif()
else()
   target_compile_options(quicksvg_quicksvg INTERFACE "-Wno-missing-braces")
endif()

set_property(TARGET quicksvg_quicksvg PROPERTY EXPORT_NAME quicksvg)

target_compile_features(quicksvg_quicksvg INTERFACE cxx_std_20)
target_include_directories(
   quicksvg_quicksvg ${warning_guard}
    INTERFACE "$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

if (PROJECT_IS_TOP_LEVEL)
  include(cmake/dev-mode.cmake)
endif()
