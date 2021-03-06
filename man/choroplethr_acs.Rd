% Generated by roxygen2 (4.0.1): do not edit by hand
\name{choroplethr_acs}
\alias{choroplethr_acs}
\title{Create a choropleth from ACS data.}
\usage{
choroplethr_acs(tableId, lod, num_buckets = 9, showLabels = T,
  states = state.abb, endyear = 2011, span = 5, renderAsInsets = TRUE)
}
\arguments{
\item{tableId}{The id of an ACS table}

\item{lod}{A string indicating the level of detail of the map.  Must be "state", "county" or "zip".}

\item{num_buckets}{The number of equally sized buckets to places the values in.  A value of 1
will use a continuous scale, and a value in [2, 9] will use that many buckets.  For
example, 2 will show values above or below the median, and 9 will show the maximum
resolution.  Defaults to 9.}

\item{showLabels}{For state choropleths, whether or not to show state abbreviations on the map.
Defaults to T.}

\item{states}{A vector of states to render.  Defaults to state.abb.}

\item{endyear}{The end year of the survey to use.  See acs.fetch (?acs.fetch) and http://1.usa.gov/1geFSSj for details.}

\item{span}{The span of time to use.  See acs.fetch and http://1.usa.gov/1geFSSj for details.}

\item{renderAsInsets}{If true, Alaska and Hawaii will be rendered as insets on the map.  If false, all 50 states will be rendered
on the same longitude and latitude map to scale. This variable is only checked when the "states" variable is equal to all 50 states.}
}
\value{
A choropleth.
}
\description{
Creates a choropleth using the US Census' American Community Survey (ACS) data.
Requires the acs package to be installed, and a Census API Key to be set with
the acs's api.key.install function.  Census API keys can be obtained at http://www.census.gov/developers/tos/key_request.html.
}
\examples{
\dontrun{
# population of all states, 9 equally sized buckets
choroplethr_acs("B01003", "state")

# median income, continuous scale, counties in New York, New Jersey and Connecticut
choroplethr_acs("B19301", "county", num_buckets=1, states=c("NY", "NJ", "CT"))

# median income, all zip codes
choroplethr_acs("B19301", "zip") }
}
\seealso{
\code{\link{choroplethr}} which this function wraps

\code{api.key.install} in the acs package which sets an Census API key for the acs library

http://factfinder2.census.gov/faces/help/jsf/pages/metadata.xhtml?lang=en&type=survey&id=survey.en.ACS_ACS
which contains a list of all ACS surveys.
}
\keyword{acs}
\keyword{choropleth,}

