#' You shouldn’t point lasers at airplanes.
#'
#' And yet, people do... by the thousands. In 2005, the Federal Aviation
#' Administration created a system for pilots to report “laser events,” which it
#' says can temporarily blind crewmembers. The administration has published five
#' years of data from the reporting system. In 2014, the most recent year
#' available, pilots reported 3,894 laser beamings. The vast majority involved a
#' green beam, and none were reported to have caused an injury.
#'
#' @format A data frame with 2810 rows and 11 variables:
#' \describe{
#'   \item{DATE}{Date, in year-month-day format}
#'   \item{TIME (UTC)}{Time of incident report}
#'   \item{ACID}
#'   \item{No. A/C}
#'   \item{TYPE A/C}
#'   \item{ALT}
#'   \item{MAJOR CITY}
#'   \item{COLOR}
#'   \item{Injury Reported}
#'   \item{CITY}
#'   \item{STATE}
#' }
#' @source \url{http://www.faa.gov/about/initiatives/lasers/laws/media/laser_incidents_2010-2014.xls}
"laser_incidents"
