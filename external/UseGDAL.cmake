#download netcdf
set(NETCDF netcdf-4.3.0)
set(NETCDF_TGZ ${NETCDF}.tar.gz)

if(NOT EXISTS ${CMAKE_BINARY_DIR}/modules/omegaOsgEarth/${NETCDF_TGZ})
  file(DOWNLOAD ftp://ftp.unidata.ucar.edu/pub/netcdf/${NETCDF_TGZ} ${CMAKE_BINARY_DIR}/modules/omegaOsgEarth/${NETCDF_TGZ} SHOW_PROGRESS)
endif()

if(NOT EXISTS ${CMAKE_BINARY_DIR}/modules/omegaOsgEarth/${NETCDF})
  execute_process(COMMAND ${CMAKE_COMMAND} -E tar xzvf ${NETCDF_TGZ} WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/modules/omegaOsgEarth)
endif()

ExternalProject_Add(
    gdal
    URL "http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz"
    CONFIGURE_COMMAND <SOURCE_DIR>/configure --with-netcdf=${CMAKE_BINARY_DIR}/modules/omegaOsgEarth/${NETCDF} --prefix=${CMAKE_BINARY_DIR}/modules/omegaOsgEarth/gdal-prefix/src/gdal-install
    BUILD_IN_SOURCE 1
    BUILD_COMMAND make
    INSTALL_COMMAND make install
)

ExternalProject_Get_Property(gdal DOWNLOAD_DIR)

set(GDAL_INCLUDE_DIR ${DOWNLOAD_DIR}/gdal-install/include CACHE INTERNAL "")
# NOTE: setting the GDAL_INCLUDES as an internal cache variable, makes it accessible to other modules.
if(APPLE)
    set(LIB_SUFFIX dylib)
else()
    set(LIB_SUFFIX so)
endif()

set(GDAL_LIBRARY  ${DOWNLOAD_DIR}/gdal-install/lib/libgdal.${LIB_SUFFIX} CACHE INTERNAL "")
