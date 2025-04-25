#' @export
#' @keywords internal
line_single_broken <- function(x, y, xend, yend, color, linewidth) {
  dash_length <- 5
  gap <- 5

  #num_dashes <- floor((xend-x) / (dash_length + gap))
  lane_line <- data.frame(
    x = seq(x+gap/2, xend - dash_length, by = dash_length + gap),
    xend = seq(x + dash_length+gap/2, xend, by = dash_length + gap)
  )
  geom_segment(data = lane_line, aes(x = x, xend = xend, y = y, yend = yend), color = color, linewidth = linewidth)
}

#' @export
#' @keywords internal
line_single_solid <- function(x, y, xend, yend, color, linewidth) {
  solid_line <- data.frame(
    x = x, y = y,
    xend =  xend,
    yend = yend
  )
  geom_segment(data = solid_line, aes(x = x, xend = xend, y = y, yend = yend), color = color, linewidth = linewidth)
}

#' @export
#' @keywords internal
road_color <- function(color = "grey70") {
  return (color)
}

#' @export
#' @keywords internal
line_double_solid <- function(x, y, xend, yend, color, linewidth) {
  line_color <- line_single_solid(x = x, xend = xend, y = y, yend = yend, color = color, linewidth = 3*linewidth)
  line_middle <- line_single_solid(x = x, xend = xend, y = y, yend = yend, color = road_color(), linewidth = linewidth)
  list(line_color, line_middle)
}

#' @export
#' @keywords internal
line_double_broken <- function(x, y, xend, yend, color, linewidth) {
  line_color <- line_single_broken(x = x, xend = xend, y = y, yend = yend, color = color, linewidth = 3*linewidth)
  line_middle <- line_single_solid(x = x, xend = xend, y = y, yend = yend, color = road_color(), linewidth = linewidth)
  list(line_color, line_middle)
}
