shared = {}

shared.garagelist, shared.currentVehicleingarage = {}, {}

shared.scaleform = false
 
shared.GarageList = {
    ["2place"] = {
        Entering = vector3(179.19, -1000.64, -99.0),
        Menu = vector3(331.987, -976.85, -99.0), 
        CarSpots = { 
            {Pos = vector3(175.21, -1003.91, -99.99), Heading = 167.96},
            {Pos = vector3(170.80, -1004.23, -99.99), Heading = 167.96}
        }
    },
    ["4place"] = {
        Entering = vector3(207.09, -1018.3, -99.0), 
        Menu = vector3(205.356, -1014.88, -99.99), 
        CarSpots = { 
            {Pos = vector3(194.50, -1016.14, -99.99), Heading = 180.13},
            {Pos = vector3(194.57, -1022.32, -99.99), Heading = 180.13},
            {Pos = vector3(202.21, -1020.14, -99.99), Heading = 90.13},  
            {Pos = vector3(202.21, -1023.32, -99.99), Heading = 90.13}
        }
    },
    ["6place"] = {
        Entering = vector3(206.89, -999.21, -99.0),  
        Menu = vector3(205.186, -995.41, -99.99), 
        CarSpots = { 
            {Pos = vector3(203.82, -1004.63, -99.99), Heading = 88.05},
            {Pos = vector3(194.16, -1004.63, -99.99), Heading = 266.42},
            {Pos = vector3(193.83, -1000.63, -99.99), Heading = 266.42},
            {Pos = vector3(202.62, -1000.63, -99.99), Heading = 88.05},
            {Pos = vector3(193.83, -997.01, -99.99), Heading = 266.42},
            {Pos = vector3(202.62, -997.01, -99.99), Heading = 88.05},
        }
    },
    ["10place"] = {
        Entering = vector3(237.42, -1004.60, -99.0),
        Menu = vector3(228.872, -976.85, -100.0), 
        CarSpots = { 
            {Pos = vector3(233.47, -982.57, -99.99), Heading = 90.1},
            {Pos = vector3(233.47, -987.57, -99.99), Heading = 90.1},
            {Pos = vector3(233.47, -992.57, -99.99), Heading = 90.1},
            {Pos = vector3(233.47, -997.57, -99.99), Heading = 90.1},
            {Pos = vector3(233.47, -1002.57, -99.99), Heading = 90.1},
            {Pos = vector3(223.55, -982.57, -99.99), Heading = 266.36},
            {Pos = vector3(223.55, -987.57, -99.99), Heading = 266.36},
            {Pos = vector3(223.55, -992.57, -99.99), Heading = 266.36},
            {Pos = vector3(223.55, -997.57, -99.99), Heading = 266.36},
            {Pos = vector3(223.55, -1002.57, -99.99), Heading = 266.36},
        }
    },
    ["12place"] = {
        Entering = vector3(-1521.28, -2978.54, -80.30),
        Menu = vector3(-1498.1, -2983.77, -83.21),  
        CarSpots = { 
            {Pos = vector3(-1517.83, -2988.32, -83.28), Heading = 181.3},
            {Pos = vector3(-1513.63, -2988.22, -83.28), Heading = 181.3},
            {Pos = vector3(-1509.41, -2988.12, -83.28), Heading = 181.3},
            {Pos = vector3(-1505.19, -2988.02, -83.28), Heading = 181.3},
            {Pos = vector3(-1501.11, -2987.92, -83.28), Heading = 181.3},
            {Pos = vector3(-1496.78, -2987.82, -83.28), Heading = 181.3}, 

            {Pos = vector3(-1517.76, -2998.04, -83.28), Heading = 0.25}, 
            {Pos = vector3(-1513.29, -2998.12, -83.28), Heading = 0.25}, 
            {Pos = vector3(-1509.16, -2998.01, -83.28), Heading = 0.25}, 
            {Pos = vector3(-1504.98, -2998.06, -83.28), Heading = 0.25}, 
            {Pos = vector3(-1500.85, -2998.12, -83.28), Heading = 0.25}, 
            {Pos = vector3(-1496.9, -2998.05, -83.28), Heading = 0.25}, 
        }
    },
    ["24place"] = {
        Entering = vector3(-198.34, -580.75, 136.0),
        Menu = vector3(-190.57, -587.84, 135.0), 
        CarSpots = { 
            {Pos = vector3(-172.97, -585.00, 135.0), Heading = 68.51},
            {Pos = vector3(-171.99, -580.76, 135.00), Heading = 100.95},
            {Pos = vector3(-173.57, -576.31, 135.00), Heading = 130.0},
            {Pos = vector3(-177.32, -573.38, 135.00), Heading = 146.0},
            {Pos = vector3(-182.33, -571.89, 135.00), Heading = 186.0},
            {Pos = vector3(-187.22, -573.04, 135.00), Heading = 224.0},
            {Pos = vector3(-192.84, -572.55, 135.00), Heading = 224.0},
            {Pos = vector3(-194.93, -575.80, 135.00), Heading = 224.0},

            {Pos = vector3(-172.97, -585.00, 140.34), Heading = 68.51},
            {Pos = vector3(-171.99, -580.76, 140.34), Heading = 100.95},
            {Pos = vector3(-173.57, -576.31, 140.34), Heading = 130.0},
            {Pos = vector3(-177.32, -573.38, 140.34), Heading = 146.0},
            {Pos = vector3(-182.33, -571.89, 140.34), Heading = 186.0},
            {Pos = vector3(-187.22, -573.04, 140.34), Heading = 224.0},
            {Pos = vector3(-192.84, -572.55, 140.34), Heading = 224.0},
            {Pos = vector3(-194.93, -575.80, 140.34), Heading = 224.0},

            {Pos = vector3(-172.97, -585.00, 145.69), Heading = 68.51},
            {Pos = vector3(-171.99, -580.76, 145.69), Heading = 100.95},
            {Pos = vector3(-173.57, -576.31, 145.69), Heading = 130.0},
            {Pos = vector3(-177.32, -573.38, 145.69), Heading = 146.0},
            {Pos = vector3(-182.33, -571.89, 145.69), Heading = 186.0},
            {Pos = vector3(-187.22, -573.04, 145.69), Heading = 224.0},
            {Pos = vector3(-192.84, -572.55, 145.69), Heading = 224.0},
            {Pos = vector3(-194.93, -575.80, 145.69), Heading = 224.0},
        }
    },
    ["11place"] = {
        Entering = vector3(-1266.95, -3048.98, -48.49),
        Menu = vector3(-1267.51, -3041.46, -49.55), 
        CarSpots = { 
            {Pos = vector3(-1274.53, -2970.56, -48.13), Heading = 182.00},
            {Pos = vector3(-1274.4, -2988.09, -48.13), Heading = 182.00},
            {Pos = vector3(-1274.5, -3004.11, -48.13), Heading = 182.00},
            {Pos = vector3(-1274.39, -3023.28, -48.13), Heading = 182.00},
            {Pos = vector3(-1274.5, -3041.12, -48.13), Heading = 182.00},

            {Pos = vector3(-1258.54, -2970.65, -48.13), Heading = 182.00},
            {Pos = vector3(-1258.49, -2988.28, -48.13), Heading = 182.00},
            {Pos = vector3(-1258.62, -3004.68, -48.13), Heading = 182.00},
            {Pos = vector3(-1258.66, -3023.63, -48.13), Heading = 182.00},
            {Pos = vector3(-1258.75, -3041.91, -48.13), Heading = 182.00},


            {Pos = vector3(-1266.92, -3011.63, -48.13), Heading = 182.00},


        }
    },

    ["20place"] = {
        Entering = vector3(1295.39, 220.41, -50.0),
        Menu = vector3(1295.35,225.81,-49.0), 
        CarSpots = { 
            {Pos = vector3(1281.194, 239.252, -50.057), Heading = 270.238},
            {Pos = vector3(1281.194, 243.384, -50.057), Heading = 270.238},
            {Pos = vector3(1281.194, 247.328, -50.057), Heading = 270.238},
            {Pos = vector3(1281.194, 252.607, -50.057), Heading = 270.238},
            {Pos = vector3(1281.194, 256.068, -50.057), Heading = 270.238},
            {Pos = vector3(1281.194, 260.195, -50.057), Heading = 270.238},
            {Pos = vector3(1295.500, 251.565, -50.057), Heading = 272.435},
            {Pos = vector3(1295.500, 247.587, -50.057), Heading = 93.551},
            {Pos = vector3(1295.5006, 243.149, -50.057), Heading = 271.835},
            {Pos = vector3(1295.500, 239.390, -50.057), Heading = 90.444},
            {Pos = vector3(1295.522, 234.267, -50.057), Heading = 272.914},
            {Pos = vector3(1295.522, 229.673, -50.057), Heading = 93.184},
            {Pos = vector3(1309.913, 228.723, -50.057), Heading = 89.670},
            {Pos = vector3(1309.218, 234.304, -50.057), Heading = 89.670},
            {Pos = vector3(1309.059, 239.318, -50.057), Heading = 89.670},
            {Pos = vector3(1309.303, 243.553, -50.057), Heading = 89.670},
            {Pos = vector3(1309.510, 247.668, -50.057), Heading = 89.670},
            {Pos = vector3(1309.516, 252.253, -50.057), Heading = 89.670},
            {Pos = vector3(1309.581, 256.453, -50.057), Heading = 89.670},
            {Pos = vector3(1309.564, 260.439, -50.057), Heading = 89.670},
        }
    },

    ["94place"] = {
        Entering = vector3(-1549.42, -560.42, 25.84),
        Menu = vector3(-1542.53, -569.79, 24.707), 
        CarSpots = { 
            {Pos = vector3(-1558.28, -572.902, 24.707), Heading = 211.484},
            {Pos = vector3(-1555.39, -571.172, 24.707), Heading = 211.484},
            {Pos = vector3(-1560.98, -574.835, 24.707), Heading = 211.484},
            {Pos = vector3(-1563.72, -576.535, 24.707), Heading = 211.484},
            {Pos = vector3(-1566.42, -578.856, 24.707), Heading = 211.484},
            {Pos = vector3(-1553.05, -569.434, 24.707), Heading = 211.484},
            {Pos = vector3(-1543.644, -582.900, 24.707), Heading = 31.484},
            {Pos = vector3(-1546.380, -584.521, 24.707), Heading = 31.484},
            {Pos = vector3(-1549.098, -586.284, 24.707), Heading = 31.484},
            {Pos = vector3(-1552.107, -588.058, 24.707), Heading = 31.484},
            {Pos = vector3(-1554.589, -589.784, 24.707), Heading = 31.484}, 
            {Pos = vector3(-1557.511, -591.761, 24.707), Heading = 31.484},


            {Pos = vector3(-1495.379, -573.273, 22.27), Heading = 31.484},
            {Pos = vector3(-1497.975, -575.175, 22.27), Heading = 31.484},
            {Pos = vector3(-1500.678, -576.930, 22.27), Heading = 31.484},
            {Pos = vector3(-1503.407, -578.694, 22.27), Heading = 31.484},
            {Pos = vector3(-1506.199, -580.409, 22.27), Heading = 31.484},
            {Pos = vector3(-1508.793, -582.200, 22.27), Heading = 31.484},
            {Pos = vector3(-1492.654, -571.868, 22.27), Heading = 31.484},
            {Pos = vector3(-1489.086, -576.938, 22.27), Heading = 211.484},
            {Pos = vector3(-1492.259, -578.319, 22.27), Heading = 211.484},
            {Pos = vector3(-1494.912, -580.075, 22.27), Heading = 211.484},
            {Pos = vector3(-1497.478, -582.210, 22.27), Heading = 211.484},
            {Pos = vector3(-1500.149, -583.902, 22.27), Heading = 211.484},
            {Pos = vector3(-1502.833, -585.592, 22.27), Heading = 211.484},
            {Pos = vector3(-1505.648, -587.374, 22.27), Heading = 211.484},

            {Pos = vector3(-1539.73, -560.712, 24.707), Heading = 211.484},
            {Pos = vector3(-1537.05, -558.632, 24.707), Heading = 211.484},
            {Pos = vector3(-1534.211, -556.82, 24.707), Heading = 211.484},
            {Pos = vector3(-1531.49, -555.078, 24.707), Heading = 211.484},
            {Pos = vector3(-1528.82, -553.146, 24.707), Heading = 211.484},
            {Pos = vector3(-1526.279, -551.442, 24.707), Heading = 211.484},
            {Pos = vector3(-1523.608, -549.652, 24.707), Heading = 211.484},
            {Pos = vector3(-1520.782, -547.71, 24.707), Heading = 211.484},
            {Pos = vector3(-1518.058, -546.175, 24.707), Heading = 211.484},
            {Pos = vector3(-1515.500, -544.257, 24.707), Heading = 211.484},
            {Pos = vector3(-1512.694, -542.324, 24.707), Heading = 211.484},

            {Pos = vector3(-1503.421, -555.42, 24.707), Heading = 31.484},  
            {Pos = vector3(-1505.929, -557.57, 24.707), Heading = 31.484},  
            {Pos = vector3(-1508.676, -559.159, 24.707), Heading = 31.484}, 
            {Pos = vector3(-1511.429, -561.192, 24.707), Heading = 31.484}, 
            {Pos = vector3(-1513.924, -562.679, 24.707), Heading = 31.484}, 
            {Pos = vector3(-1516.752, -564.751, 24.707), Heading = 31.484}, 
            {Pos = vector3(-1519.494, -566.642, 24.707), Heading = 31.484}, 
            {Pos = vector3(-1521.868, -568.614, 24.707), Heading = 31.484}, 


  
            {Pos = vector3(-1473.923, -581.673, 22.274), Heading = 34.993},
            {Pos = vector3(-1476.425, -583.302, 22.274), Heading = 34.993},
            {Pos = vector3(-1479.394, -584.936, 22.274), Heading = 34.993},
            {Pos = vector3(-1481.942, -587.080, 22.274), Heading = 34.993},
            {Pos = vector3(-1484.585, -588.922, 22.274), Heading = 34.993},
            {Pos = vector3(-1487.092, -590.931, 22.274), Heading = 34.993},
            {Pos = vector3(-1489.768, -592.825, 22.274), Heading = 34.993},
            {Pos = vector3(-1492.397, -594.534, 22.274), Heading = 34.993},
            {Pos = vector3(-1494.910, -596.414, 22.274), Heading = 34.993},
            {Pos = vector3(-1497.757, -598.196, 22.274), Heading = 34.993},
            {Pos = vector3(-1500.419, -600.151, 22.274), Heading = 34.993},
            {Pos = vector3(-1503.114, -601.824, 22.274), Heading = 34.993},

 

            {Pos = vector3(-1508.07, -602.71, 22.270), Heading = 0.484},
            {Pos = vector3(-1511.35, -602.77, 22.270), Heading = 0.484},
            {Pos = vector3(-1514.55, -602.61, 22.270), Heading = 0.484},
            {Pos = vector3(-1517.93, -602.63, 22.270), Heading = 0.484},
            {Pos = vector3(-1521.00, -602.61, 22.270), Heading = 0.484},
            {Pos = vector3(-1524.26, -602.26, 22.270), Heading = 0.484},
            {Pos = vector3(-1527.38, -601.91, 22.270), Heading = 0.484},
     

            {Pos = vector3(-1502.378, -563.135, 22.274), Heading = 213.993},
            {Pos = vector3(-1499.726, -561.135, 22.274), Heading = 213.993}, 
            {Pos = vector3(-1497.084, -559.345, 22.274), Heading = 213.993},
            {Pos = vector3(-1494.317, -557.518, 22.274), Heading = 213.993},
            {Pos = vector3(-1491.410, -555.569, 22.274), Heading = 213.993},
             
            {Pos = vector3(-1515.681, -572.466, 22.274), Heading = 213.993},
            {Pos = vector3(-1512.952, -570.534, 22.274), Heading = 213.993},
            {Pos = vector3(-1510.244, -568.541, 22.274), Heading = 213.993},
            {Pos = vector3(-1507.650, -566.716, 22.274), Heading = 213.993},
            {Pos = vector3(-1505.042, -564.882, 22.274), Heading = 213.993},

            {Pos = vector3(-1509.62, -588.429, 22.274), Heading = 123.805},
            {Pos = vector3(-1511.71, -586.161, 22.274), Heading = 123.805},
            {Pos = vector3(-1488.15, -572.638, 22.274), Heading = 33.993},

            {Pos = vector3(-1531.60, -583.856, 22.274), Heading = 211.484},
            {Pos = vector3(-1534.48, -584.899, 22.274), Heading = 211.484},
            {Pos = vector3(-1537.45, -586.728, 22.274), Heading = 211.484},
            {Pos = vector3(-1539.95, -588.758, 22.274), Heading = 211.484},
            {Pos = vector3(-1542.41, -590.639, 22.274), Heading = 211.484},
            {Pos = vector3(-1545.20, -592.247, 22.274), Heading = 211.484},
            {Pos = vector3(-1548.14, -594.021, 22.274), Heading = 211.484},
            {Pos = vector3(-1550.77, -595.663, 22.274), Heading = 211.484},
            {Pos = vector3(-1553.58, -597.476, 22.274), Heading = 211.484},
            {Pos = vector3(-1556.17, -599.360, 22.274), Heading = 211.484}, 
            {Pos = vector3(-1559.13, -600.814, 22.274), Heading = 211.484}, 
            {Pos = vector3(-1561.71, -602.707, 22.274), Heading = 211.484},
            
            {Pos = vector3(-1547.42, -624.48, 22.270), Heading = 354.484},
            {Pos = vector3(-1553.922, -623.972, 22.270), Heading = 354.484},
            {Pos = vector3(-1560.566, -623.307, 22.270), Heading = 354.484},
            {Pos = vector3(-1550.723, -625.264, 22.270), Heading = 354.484},
            {Pos = vector3(-1557.239, -624.793, 22.270), Heading = 354.484},
        }
    },
}