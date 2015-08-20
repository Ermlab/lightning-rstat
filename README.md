# lightning-rstat
R client for the lightning-viz server API http://lightning-viz.org/

## Installation

To use this package you have to setup your own lightning server. The package by itself will not create/display any visualisations. Instructions on how to deploy your own lightning server are available at http://lightning-viz.org/documentation/#server

Clone the repository and build your package using RStudio, or download the newest binary:

```
LightningR_0.2-1_R_x86_64-pc-linux-gnu.tar.gz
```

Then run command

```
install.packages(<path to file>, repos = NULL)
```
## Usage
### create visualization
To create your first visualisation, you need to create an object of a Lightning class, installed with this package.
```
library(LightningR)
vizserver <- Lightning$new("http://my-lightning.herokuapp.com/")
```
Then you need to create your first session on the server.
```
vizserver$createsession("optional_session_name")
```
After that you are free to create your first visualisation! Lets start with a simple line plot:

```
vizserver$line(c(1,2,3,4,5,6,7,8))
```
### open last (or chosen) visualization:
You can open created visualization with
```
vizserver$openviz()
vizserver$openviz(vizid)
```
### enable/disable auto opening of created visualizations (disabled by default):
Your visualizations can be automatically opened in your browser. You can enable/disable that option with functions:
```
vizserver$enableautoopening()
```
```
vizserver$disableautoopening()
```

## Documentation

### Setup

```
parameters in [] brackets are optional
```
```
createsession([sessionname])    -   creates a new lightning session
usesession(sessionid)           -   sets current session to session with given id
sethost(serveraddress)          -   sets new server address
enableautoopening()             -   enables auto opening of created plots
disableautoopening()            -   disables auto opening of created plots
```
### Plots

#### line(series, ...)
Creates a line visualization for vector/matrix with each row representing a line, given in *series*}

![Alt text](/../screenshots/plots/line.png?raw=true)
```
line(series, [index, color, label, size, xaxis, yaxis, logScaleX, logScaleY])
Parameters: series  - vector or matrix of data for plot, each row of the matrix is plotted as another line. If lines are of different size, put NaN in empty fields
            index     - vector specyfying x-axis of the plot
            color     - vector of RGB values for each line
            label     - vector of labels for lines, sets color according to label
            size      - vector of line thickness values
            xaxis     - label for xaxis
            yaxis     - label for yaxis
            logScaleX - logical, sets X axis to logarythmic scale
            logScaleY - logical, sets Y axis to logarythmic scale
```
#### scatter(x, y, ...)
Creates a scatterplot for points with coordinates given in vectors *x* and *y*.
![Alt text](/../screenshots/plots/scatter.png?raw=true)
```
scatter(x, y, [color, label, size, alpha, xaxis, yaxis])
Parameters: x     - vector of x coordinates for points
            y     - vector of y coordinates for points
            color - vector of RGB values for each point
            label - vector of labels for points, sets color according to label
            size  - vector of point size values
            alpha - vector of opacity values for each point
            xaxis - label for xaxis
            yaxis - label for yaxis
```
#### linestacked(series, ...)
Creates a plot of multiple lines given in *matrix* series, with an ability to hide and show every one of them.
![Alt text](/../screenshots/plots/linestacked.png?raw=true)
```
linestacked(series, [color, label, size])
Parameters: series  - matrix of data for lines, where each row represents a single line
            color   - vector of RGB values for each line
            label   - vector of labels for lines, sets color according to label
            size    - vector of line thickness values
```
#### force(matrix, ...)
Creates a force plot for matrix given in *matrix*.
![Alt text](/../screenshots/plots/force.png?raw=true)
```
force(matrix, [color, label, size])
Parameters: matrix  - connectivity matrix, binary or weighted
            color   - vector of RGB values for each point
            label   - vector of labels for points, sets color according to label
            size    - vector of point size values
```
#### graph(x, y, matrix, ...)
Creates a graph of points with coordinates given in *x* and *y* vectors, with connection given in *matrix* connectivity matrix.
![Alt text](/../screenshots/plots/graph.png?raw=true)
```
graph(x, y, matrix, [color, label, size])
Parameters: x       - vector of x coordinates for points
            y       - vector of y coordinates for points
            matrix  - connectivity matrix, binary or weighted
            color   - vector of RGB values for each point
            label   - vector of labels for points, sets color according to label
            size    - vector of point size values
```
#### graphbundled(x, y, matrix, ...)
Creates a bundled graph of points with coordinates given in *x* and *y* vectors, with connection given in *matrix* connectivity matrix. Lines on this graph are stacked a bit more than in the *graph* function.
![Alt text](/../screenshots/plots/graphbundled.png?raw=true)
```
graphbundled(x, y, matrix, [color, label, size])
Parameters: x       - vector of x coordinates for points
            y       - vector of x coordinates for points
            matrix  - connectivity matrix, binary or weighted
            color   - vector of RGB values for each point
            label   - vector of labels for points, sets color according to label
            size    - vector of point size values
```
#### map(regions, weights, colormap)
Creates a world (or USA) map, marking regions given as a vector of abbreviations (3-char for countries, 2-char for states) in *regions* with weights given in *weights* vector and with *colormap* color (string from colorbrewer).
![Alt text](/../screenshots/plots/map.png?raw=true)
```
map(regions, weights, colormap)
Parameters: regions   - vector or region abbreviations (3-chars for countries, 2-chars for states in USA)
            weights   - vector of weights for each region
            colormap  - colorbrewer string for type of map coloring
```
#### matrix(matrix, colormap)
Creates a visualization of matrix given in *matrix* parameter, with its contents used as weights for the colormap given in *colormap* (string from colorbrewer).
![Alt text](/../screenshots/plots/matrix.png?raw=true)
```
matrix(matrix, colormap)
Parameters: matrix    - matrix to visualise as a heat map
            colormap  - colorbrewer string for type of map coloring
```
#### adjacency(matrix, ...)
Creates a visualization for adjacency matrix given in *matrix* parameter.
![Alt text](/../screenshots/plots/adjacency.png?raw=true)
```
adjacency(matrix, [label])
Parameters: matrix  - adjacency matrix data
            label   - labels for each pixel
```

### Linked

#### scatterline(x, y, t, ...)
Creates a scatterplot for coordinates in vectors *x* and *y* and assignes a line plot to every point on that plot. Each line is given as a row in *t* matrix.
![Alt text](/../screenshots/plots/scatterline.png?raw=true)
```
scatterline(x, y, t, [color, label, size])
Parameters: x     - vector of x coordinates for points
            y     - vector of y coordinates for points
            t     - matrix of of line data, each row represents a line for given point / label
            color - vector of RGB values for each point
            label - vector of labels for points, sets color according to label
            size  - vector of point size values

```

### 3D

#### scatter3(x, y, z, ...)
Creates a 3D scatterplot for coordinates given in vectors *x*, *y* and *z*.
![Alt text](/../screenshots/plots/scatter3.png?raw=true)
```
scatter3(x, y, z, [color, label, size, alpha])
Parameters: x     - vector of x coordinates for points
            y     - vector of y coordinates for points
            z     - vector of z coordinates for points
            color - vector of RGB values for each point
            label - vector of labels for points, sets color according to label
            size  - vector of point size values
            alpha - vector of opacity values for each point
```
