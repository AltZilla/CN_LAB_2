clear;
clc;

// =====================================================
// BUS TOPOLOGY (Nodes 1–8)
// =====================================================
bStart = [1 2 3 4 5 6 7];
bEnd   = [2 3 4 5 6 7 8];

xBus = [100 150 200 250 300 350 400 450];
yBus = [480 480 480 480 480 480 480 480];   // lowered for visibility

// =====================================================
// RING TOPOLOGY (Nodes 9–16)
// =====================================================
rStart = [9 10 11 12 13 14 15 16];
rEnd   = [10 11 12 13 14 15 16 9];

angle = 0:%pi/4:(7*%pi/4);
xRing = 300 + 100*cos(angle);
yRing = 280 + 100*sin(angle);

// =====================================================
// TREE TOPOLOGY (Nodes 17–25)
// =====================================================
tStart = [17 17 18 18 19 19 20 20];
tEnd   = [18 19 20 21 22 23 24 25];

xTree = [500 480 520 460 540 440 560 420 580];
yTree = [500 450 450 400 400 350 350 300 300];

// =====================================================
// MERGE ALL TOPOLOGIES
// =====================================================
nodesTotal = 25;

startAll = [bStart rStart tStart];
endAll   = [bEnd   rEnd   tEnd];

xAll = [xBus xRing xTree];
yAll = [yBus yRing yTree];

// =====================================================
// HYBRID INTERCONNECTIONS
// Bus → Ring, Ring → Tree
// =====================================================
bridgeStart = [4 12];
bridgeEnd   = [9 17];

startAll = [startAll bridgeStart];
endAll   = [endAll   bridgeEnd];

edgesTotal = length(startAll);

// =====================================================
// DISPLAY TOPOLOGY
// =====================================================
scf(1);
clf();

// Draw nodes
plot(xAll, yAll, 'ro');
h = gce();
h.children.mark_size = 10;
h.children.thickness = 2;

// Draw edges
for i = 1:edgesTotal
    xpoly([xAll(startAll(i)) xAll(endAll(i))], ...
          [yAll(startAll(i)) yAll(endAll(i))], "lines");
end

// =====================================================
// LABEL NODES
// =====================================================
for i = 1:nodesTotal
    xstring(xAll(i)+8, yAll(i)+8, "N"+string(i));
end

// =====================================================
// LABEL EDGES
// =====================================================
for i = 1:edgesTotal
    xm = (xAll(startAll(i)) + xAll(endAll(i))) / 2;
    ym = (yAll(startAll(i)) + yAll(endAll(i))) / 2;
    xstring(xm, ym, "E"+string(i));
end

xtitle("Hybrid Topology: Bus + Ring + Tree", "X", "Y");

// =====================================================
// AXIS SETTINGS (IMPORTANT FIX)
// =====================================================
a = gca();
a.data_bounds = [50 150; 650 550];
a.isoview = "on";

// =====================================================
// DEGREE CALCULATION
// =====================================================
degree = zeros(1, nodesTotal);

for i = 1:edgesTotal
    degree(startAll(i)) = degree(startAll(i)) + 1;
    degree(endAll(i))   = degree(endAll(i)) + 1;
end

disp("Number of edges connected to each node:");
for i = 1:nodesTotal
    disp("Node " + string(i) + " : " + string(degree(i)));
end

[maxDeg, maxNode] = max(degree);
disp("Node with maximum edges: Node " + string(maxNode));
disp("Maximum number of edges: " + string(maxDeg));

// =====================================================
// TOTAL COUNTS
// =====================================================
disp("Total number of nodes: " + string(nodesTotal));
disp("Total number of edges: " + string(edgesTotal));
