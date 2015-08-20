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
### create session
```
library(LightningR)
vizserver <- Lightning$new("http://my-lightning.herokuapp.com/")
vizserver$createsession()
vizserver$createsession("optional_session_name")
```
### create a vizualisation
```
vizserver$line(c(1,2,3,4,5,6,7,8))
vizserver$map(c('POL', 'USA', 'RUS', 'GBR', 'FRA'), c(1,2,3,4,5), "Blues")
```
### open last (or chosen) vizualisation:
```
vizserver$openviz()
vizserver$openviz(vizid)
```
### enable/disable auto opening of created vizualisations (disabled by default):
```
vizserver$enableautoopening()
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
![Alt text](/../screenshots/plots/linestacked.png?raw=true)
```
linestacked(series, [color, label, size])
Parameters: series  - matrix of data for lines, where each row represents a single line
            color   - vector of RGB values for each line
            label   - vector of labels for lines, sets color according to label
            size    - vector of line thickness values
```
#### force(matrix, ...)
![Alt text](/../screenshots/plots/force.png?raw=true)
```
force(matrix, [color, label, size])
Parameters: matrix  - connectivity matrix, binary or weighted
            color   - vector of RGB values for each point
            label   - vector of labels for points, sets color according to label
            size    - vector of point size values
```
#### graph(x, y, matrix, ...)
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
![Alt text](/../screenshots/plots/map.png?raw=true)
```
map(regions, weights, colormap)
Parameters: regions   - vector or region abbreviations (3-chars for countries, 2-chars for states in USA)
            weights   - vector of weights for each region
            colormap  - colorbrewer string for type of map coloring
```
#### matrix(matrix, colormap)
![Alt text](/../screenshots/plots/matrix.png?raw=true)
```
matrix(matrix, colormap)
Parameters: matrix    - matrix to visualise as a heat map
            colormap  - colorbrewer string for type of map coloring
```
#### adjacency(matrix, ...)
![Alt text](/../screenshots/plots/adjacency.png?raw=true)
```
adjacency(matrix, [label])
Parameters: matrix  - adjacency matrix data
            label   - labels for each pixel
```

### Linked

#### scatterline(x, y, t, ...)
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
![Alt text](/../screenshots/plots/scatter3.png?raw=true)

#### scatter3(x, y, z, ...)
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
