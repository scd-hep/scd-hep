# - Locate pythia8 library
# Defines:
#
#  PYTHIA8_FOUND
#  PYTHIA8_VERSION
#  PYTHIA8_INCLUDE_DIR
#  PYTHIA8_XMLDOC_DIR
#  PYTHIA8_INCLUDE_DIRS (not cached)
#  PYTHIA8_LIBRARY
#  PYTHIA8_hepmcinterface_LIBRARY
#  PYTHIA8_lhapdfdummy_LIBRARY
#  PYTHIA8_LIBRARIES (not cached) : includes 3 libraries above; not to be used if lhapdf is used
set(TEST_PYTHIA8_HOME  "" ${PYTHIA8_HOME})
IF(TEST_PYTHIA8_HOME STREQUAL "")
IF(DEFINED ENV{PYTHIA8_HOME})
set(PYTHIA8_HOME  $ENV{PYTHIA8_HOME})
else()
set(PYTHIA8_HOME  "/usr")
endif()
endif()

find_path(PYTHIA8_INCLUDE_DIR Pythia.h Pythia8/Pythia.h
  HINTS  ${PYTHIA8_HOME}/include)

find_path(PYTHIA8_XMLDOC_DIR Version.xml
  HINTS  ${PYTHIA8_HOME}/xmldoc  ${PYTHIA8_HOME}/share/Pythia8/xmldoc ${PYTHIA8_HOME}/share/pythia8-data/xmldoc  ${PYTHIA8_HOME}/share/doc/packages/pythia/xmldoc ) 

if(PYTHIA8_INCLUDE_DIR AND PYTHIA8_XMLDOC_DIR)
  file(READ ${PYTHIA8_XMLDOC_DIR}/Version.xml versionstr)
  string(REGEX REPLACE ".*Pythia:versionNumber.*default.*[0-9][.]([0-9]+).*" "\\1" PYTHIA8_VERSION "${versionstr}")

  find_library(PYTHIA8_LIBRARY NAMES pythia8 Pythia8
    HINTS ${PYTHIA8_HOME}/lib
          ${PYTHIA8_HOME}/lib64)

  find_library(PYTHIA8_lhapdfdummy_LIBRARY NAMES lhapdfdummy
    HINTS ${PYTHIA8_HOME}/lib
          ${PYTHIA8_HOME}/lib64)

  set(PYTHIA8_INCLUDE_DIRS ${PYTHIA8_INCLUDE_DIR} ${PYTHIA8_INCLUDE_DIR}/Pythia8 )
  set(PYTHIA8_LIBRARIES ${PYTHIA8_LIBRARY})
  if(PYTHIA8_VERSION VERSION_LESS 200)
    #Is this library needed?
    #set(PYTHIA8_LIBRARIES ${PYTHIA8_LIBRARY} ${PYTHIA8_lhapdfdummy_LIBRARY})
  endif()
endif()

# handle the QUIETLY and REQUIRED arguments and set PYTHIA8_FOUND to TRUE if
# all listed variables are TRUE

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(Pythia8 DEFAULT_MSG PYTHIA8_INCLUDE_DIR PYTHIA8_LIBRARIES PYTHIA8_XMLDOC_DIR)

mark_as_advanced(PYTHIA8_FOUND PYTHIA8_INCLUDE_DIR PYTHIA8_LIBRARY PYTHIA8_LIBRARIES PYTHIA8_XMLDOC_DIR)

