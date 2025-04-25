#' Draw a road segment
#'
#' For illustration purposes, draw a road segment of a specified length and number of lanes.
#' @param road_length length (in feet)
#' @param lanes_per_direction integer
#' @param lane_width lane width (in feet). In the US, lanes are generally 12 to 13 feet wide.
#' @returns ggplot2 object with layers for the road and lines. The coordinates of the returned plot are in feet, centered around an origin in the middle of the road segment.
#' @export
#' @import ggplot2
#' @examples
#' # example code
#' draw_multi_lane_road(road_length = 50, lanes_per_direction = 2, lane_width = 12)
#' draw_multi_lane_road(road_length = 50, lanes_per_direction = 1, lane_width = 12)
draw_multi_lane_road <- function(road_length = 50, lanes_per_direction = 2, lane_width = 12) {
  total_lanes <- lanes_per_direction * 2
  road_width <- total_lanes*lane_width


  # Create road background
  road <- data.frame(
    xmin = -road_length/2,
    xmax = road_length/2,
    ymin = -road_width/2,
    ymax = road_width/2
  )

  # Create yellow center line
  center_line <- NULL
  if (lanes_per_direction > 1) {
  center_line <- line_double_solid(
    x = -road_length/2,
    xend =  road_length/2,
    y = 0,
    yend = 0,
    color = "yellow",
    linewidth = 1.5
  )} else {
    center_line <- line_single_broken(
      x = -road_length/2,
      xend =  road_length/2,
      y = 0,
      yend = 0,
      color = "yellow",
      linewidth = 1.5
    )
  }

  # Create lane boundary lines (dashed white)
  lane_lines <- NULL
  if (lanes_per_direction > 1) {
    lane_lines <- lapply(
      -(lanes_per_direction-1):(lanes_per_direction-1),
      FUN = function(y) {
        if (y == 0) return(NULL)
        line_single_broken(
          y = y*lane_width,
          yend=y*lane_width,
          x = -road_length/2,
          xend =  road_length/2,
          color = "white", linewidth = 1)
      })
  }

  # Plot
  ggplot() +
    geom_rect(data = road, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), fill = road_color()) +
    center_line +
    lane_lines +
    coord_fixed(ratio = 1) +
    theme_void()
}

