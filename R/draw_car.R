#' Draw a car
#'
#' @param x coordinate in x (unit are feet)
#' @param y coordinate in y (unit are feet)
#' @param color character, one of `black` o `white`
#' @param direction driving direction in degrees, default is 0 (from left to right).
#' @param size numeric value, used as a scalar to modify the average width of a US car (height is scaled proportionally).
#' @export
#' @returns a ggplot2 layer with car images drawn at the specified locations
#' @examples
#' # example code
#' draw_multi_lane_road(road_length = 50, lanes_per_direction = 1, lane_width = 12) +
#'    draw_car(x = -10, y = -6, color = "white", size=1.2) + draw_car(x = 10, y = 6, direction = -180)
draw_car <- function(x, y, color = "black", direction = 0, size = 1) {
  d <- data.frame(x = x, y = y, image <- sprintf("inst/%s-car-2in.png", color))
  geom_image(data = d, aes(x=x, y=y, image=image), angle=direction, size=size*.45)
}
