## POST(url = "http://localhost:3000/sessions/199/visualizations/", encode = 'multipart', body = list(file = upload_file("/home/kamil/image.png"), data = list(type = 'image')))
## POST(url = "http://localhost:3000/sessions/201/visualizations/", encode = 'multipart', body = list(file = upload_file("/home/kamil/image.png"), type = "gallery"))


Lightning <- R6Class("Lightning",
   public = list(
      serveraddress = NA,
      sessionid = NA,
      url = NA,
      autoopen = FALSE,
      initialize = function(serveraddress) {
         if(!missing(serveraddress)){
            self$serveraddress <- serveraddress
         }
      },
      line = function(series, index = NA, color = NA, label = NA, size = NA, xaxis = NA, yaxis = NA, logScaleX = "false", logScaleY = "false") {
         listbuilder <- list(type = "line", opts = list(logScaleX = logScaleX, logScaleY = logScaleY))
         features <- list(series = series)

         if (!is.na(index)) {
            features$index <- index
         }
         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }
         if (!is.na(xaxis)) {
            features$xaxis <- xaxis
         }
         if (!is.na(yaxis)) {
            features$yaxis <- yaxis
         }

         listbuilder$data <- features

         jsonbody <- toJSON(listbuilder, .na = "")
         oldbody = "placeholder"

         while (!(jsonbody == oldbody)) {
            oldbody <- jsonbody
            jsonbody <- gsub(", ,", ",", jsonbody)
         }
         jsonbody <- gsub(",  ]", " ]", jsonbody)
         jsonbody <- gsub('[ ,', '[', jsonbody, fixed = TRUE)
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      scatter = function(x, y, color = NA, label = NA, size = NA, alpha = NA, xaxis = NA, yaxis = NA){
         listbuilder <- list(type = "scatter")
         points <- matrix(ncol = 2, nrow = length(x))
         points[,1] <- x
         points[,2] <- y
         features <- list(points = points)

         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }
         if (!is.na(alpha)) {
            features$alpha <- alpha
         }
         if (!is.na(xaxis)) {
            features$xaxis <- xaxis
         }
         if (!is.na(yaxis)) {
            features$yaxis <- yaxis
         }

         listbuilder$data <- features
         listbuilder$opts <- c(NaN)
         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         if (self$autoopen) {
            browseURL(url)
         }
         self$url <- url
         return(list(url = url, id = response$id))
      },
      linestacked = function(series, color = NA, label = NA, size = NA){
         listbuilder <- list(type = "line-stacked")
         features <- list(series = series)

         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }

         listbuilder$data <- features
         listbuilder$opts <- c("options")
         jsonbody <- toJSON(listbuilder, .na = "")

         oldbody = "placeholder"

         while (!(jsonbody == oldbody)) {
            oldbody <- jsonbody
            jsonbody <- gsub(", ,", ",", jsonbody)
         }
         jsonbody <- gsub(",  ]", " ]", jsonbody)
         jsonbody <- gsub('[ ,', '[', jsonbody, fixed = TRUE)

         jsonbody <- gsub('"options"', "{}", jsonbody)
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      force = function(matrix, color = NA, label = NA, size = NA){
         ##matrix- connectivity matrix n by n, where value is the weight of the edge

         listbuilder <- list(type = "force", opts = NA)
         nodes <- vector(mode = "numeric", length = nrow(matrix))
         for (i in 0:(length(nodes)-1)) {
            nodes[i] <- i
         }
         features <- list(nodes = nodes)

         ##convert matrix to links
         links <- matrix(ncol = 3, byrow = TRUE)
         for (i in 1:ncol(matrix)) {
            for (j in 1:nrow(matrix)) {
               if (!(matrix[i,j] == 0)) {
                  links <- rbind(links, c((i-1), (j-1), (matrix[i,j])))
               }
            }
         }
         links <- links[-1,]
         features$links <- links

         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }

         listbuilder$data <- features

         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      graph = function(x, y, matrix, color = NA, label = NA, size = NA) {
         listbuilder <- list(type = "graph", opts = NA)
         points <- matrix(ncol = 2, nrow = length(x))
         points[,1] <- x
         points[,2] <- y
         features <- list(nodes = points)

         links <- matrix(ncol = 3, byrow = TRUE)
         for (i in 1:ncol(matrix)) {
            for (j in 1:nrow(matrix)) {
               if (!(matrix[i,j] == 0)) {
                  links <- rbind(links, c((i-1), (j-1), (matrix[i,j])))
               }
            }
         }
         links <- links[-1,]
         features$links <- links

         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }

         listbuilder$data <- features
         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      map = function(regions, weights, colormap) {
         listbuilder <- list(type = "map", opts = NA)
         features = list(regions = regions, values = weights, colormap = colormap)
         listbuilder$data <- features
         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      graphbundled = function(x, y, matrix, color = NA, label = NA, size = NA){
         listbuilder <- list(type = "graph-bundled", opts = NA)
         points <- matrix(ncol = 2, nrow = length(x))
         points[,1] <- x
         points[,2] <- y
         features <- list(nodes = points)

         links <- matrix(ncol = 3, byrow = TRUE)
         for (i in 1:ncol(matrix)) {
            for (j in 1:nrow(matrix)) {
               if (!(matrix[i,j] == 0)) {
                  links <- rbind(links, c((i-1), (j-1), (matrix[i,j])))
               }
            }
         }
         links <- links[-1,]
         features$links <- links

         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }

         listbuilder$data <- features
         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      matrix = function(matrix, colormap){
         listbuilder <- list(type = "matrix", opts = NA)
         features = list(matrix = matrix, colormap = colormap)
         listbuilder$data <- features
         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      adjacency = function (matrix, label = NA) {
         listbuilder <- list(type = "adjacency", opts = NA)
         nodes <- c(0:(nrow(matrix) - 1))
         links <- matrix(ncol = 3, byrow = TRUE)
         for (i in 1:ncol(matrix)) {
            for (j in 1:nrow(matrix)) {
               if (!(matrix[i,j] == 0)) {
                  links <- rbind(links, c((i-1), (j-1), (matrix[i,j])))
               }
            }
         }
         links <- links[-1,]
         features <- list(links = links, nodes = nodes)

         if (!is.na(label)) {
            features$label <- label
         }

         listbuilder$data <- features
         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      scatterline = function(x, y, t, color = NA, label = NA, size = NA){
         listbuilder <- list(type = "scatter-line")
         points <- matrix(ncol = 2, nrow = length(x))
         points[,1] <- x
         points[,2] <- y
         features <- list(points = points, series = t)

         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }

         listbuilder$data <- features
         listbuilder$opts <- c("options")
         jsonbody <- toJSON(listbuilder, .na = "")
         oldbody = "placeholder"

         while (!(jsonbody == oldbody)) {
            oldbody <- jsonbody
            jsonbody <- gsub(", ,", ",", jsonbody)
         }
         jsonbody <- gsub(",  ]", " ]", jsonbody)
         jsonbody <- gsub('[ ,', '[', jsonbody, fixed = TRUE)

         jsonbody <- gsub('"options"', "{}", jsonbody)
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      scatter3 = function(x, y, z, color = NA, label = NA, size = NA, alpha = NA) {
         listbuilder <- list(type = "scatter-3")
         points <- matrix(ncol = 3, nrow = length(x))
         points[,1] <- x
         points[,2] <- y
         points[,3] <- z
         features <- list(points = points)

         if (!is.na(color)) {
            features$color <- color
         }
         if (!is.na(label)) {
            features$label <- label
         }
         if (!is.na(size)) {
            features$size <- size
         }
         if (!is.na(alpha)) {
            features$alpha <- alpha
         }

         listbuilder$data <- features
         listbuilder$opts <- c(NaN)
         jsonbody <- toJSON(listbuilder, .na = "{}")
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      image = function(imgpath) {
         rawresponse <- POST(url = paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""), encode = 'multipart', body = list(file = upload_file(imgpath), type = "image"))
         jsonstring <- rawToChar(rawresponse$content)
         response <- fromJSON(jsonstring)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      gallery = function(imgpathvector) {
         firstpath <- imgpathvector[1]
         otherpaths <- imgpathvector[-1]
         rawresponse <- POST(url = paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", sep=""), encode = 'multipart', body = list(file = upload_file(firstpath), type = "gallery"))
         jsonstring <- rawToChar(rawresponse$content)
         response <- fromJSON(jsonstring)
         url <- paste(self$serveraddress, "visualizations/", response$id, "/", sep="")
         self$url <- url
         for (var in otherpaths) {
            POST(url = paste(self$serveraddress, "sessions/", self$sessionid, "/visualizations/", response$id, "/data/images/", sep=""), encode = 'multipart', body = list(file = upload_file(var), type = "image"))
         }
         if (self$autoopen) {
            browseURL(url)
         }
         return(list(url = url, id = response$id))
      },
      createsession = function(sessionname = ""){
         jsonbody <- toJSON(list(name=sessionname))
         httpheader<- c(Accept = "text/plain", "Content-Type" = "application/json")
         response = postForm(paste(self$serveraddress, "sessions/", sep=""),
                             .opts = list(httpheader = httpheader, postfields=jsonbody))
         response = fromJSON(response)
         self$sessionid <- response$id
         return(response)
      },
      usesession = function(sessionid){
         self$sessionid <- sessionid
      },
      sethost = function(serveraddress){
         self$url <- NA
         self$sessionid <- NA
         self$serveraddress <- serveraddress
      },
      enableautoopening = function(){
         self$autoopen <- TRUE
      },
      disableautoopening = function(){
         self$autoopen <- FALSE
      },
      openviz = function(vizid = NA){
         if (is.na(vizid)) {
            if (is.na(self$url)) {
               print("No vizualisation to show")
            } else{
               browseURL(self$url)
            }
         } else{
            url <- paste(self$serveraddress, "visualizations/", vizid, "/", sep="")
            browseURL(url)
         }
      }
   )
)
