# Geometry API functions.

ctypedef int OGRErr


ctypedef struct OGREnvelope:
    double MinX
    double MaxX
    double MinY
    double MaxY


cdef extern from "ogr_api.h":
    OGRErr  OGR_G_AddGeometryDirectly (void *geometry, void *part)
    void    OGR_G_AddPoint (void *geometry, double x, double y, double z)
    void    OGR_G_AddPoint_2D (void *geometry, double x, double y)
    void    OGR_G_CloseRings (void *geometry)
    void *  OGR_G_CreateGeometry (int wkbtypecode)
    void    OGR_G_DestroyGeometry (void *geometry)
    unsigned char * OGR_G_ExportToJson (void *geometry)
    void    OGR_G_ExportToWkb (void *geometry, int endianness, char *buffer)
    int     OGR_G_GetCoordinateDimension (void *geometry)
    int     OGR_G_GetGeometryCount (void *geometry)
    unsigned char *  OGR_G_GetGeometryName (void *geometry)
    int     OGR_G_GetGeometryType (void *geometry)
    void *  OGR_G_GetGeometryRef (void *geometry, int n)
    int     OGR_G_GetPointCount (void *geometry)
    double  OGR_G_GetX (void *geometry, int n)
    double  OGR_G_GetY (void *geometry, int n)
    double  OGR_G_GetZ (void *geometry, int n)
    void    OGR_G_ImportFromWkb (void *geometry, unsigned char *bytes, int nbytes)
    int     OGR_G_WkbSize (void *geometry)


cdef class GeomBuilder:
    cdef void *geom
    cdef object code
    cdef object geomtypename
    cdef object ndims
    cdef _buildCoords(self, void *geom)
    cpdef _buildPoint(self)
    cpdef _buildLineString(self)
    cpdef _buildLinearRing(self)
    cdef _buildParts(self, void *geom)
    cpdef _buildPolygon(self)
    cpdef _buildMultiPoint(self)
    cpdef _buildMultiLineString(self)
    cpdef _buildMultiPolygon(self)
    cpdef _buildGeometryCollection(self)
    cdef build(self, void *geom)
    cpdef build_wkb(self, object wkb)


cdef class OGRGeomBuilder:
    cdef void * _createOgrGeometry(self, int geom_type) except NULL
    cdef _addPointToGeometry(self, void *cogr_geometry, object coordinate)
    cdef void * _buildPoint(self, object coordinates) except NULL
    cdef void * _buildLineString(self, object coordinates) except NULL
    cdef void * _buildLinearRing(self, object coordinates) except NULL
    cdef void * _buildPolygon(self, object coordinates) except NULL
    cdef void * _buildMultiPoint(self, object coordinates) except NULL
    cdef void * _buildMultiLineString(self, object coordinates) except NULL
    cdef void * _buildMultiPolygon(self, object coordinates) except NULL
    cdef void * _buildGeometryCollection(self, object coordinates) except NULL
    cdef void * build(self, object geom) except NULL


cdef unsigned int geometry_type_code(object name)
cdef object normalize_geometry_type_code(unsigned int code)