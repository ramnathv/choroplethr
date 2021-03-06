if (base::getRversion() >= "2.15.1") {
  utils::globalVariables(c("map.world", "country.names"))
}

bind_df_to_world_map = function(df, warn_na = TRUE)
{
  stopifnot(c("region", "value") %in% colnames(df))
 
  df$region = tolower(df$region)

  data(map.world, package="choroplethr", envir=environment())
  choropleth = merge(map.world, df, all.x=TRUE)
  
  missing_countries = unique(choropleth[is.na(choropleth$value), ]$region);
  if (warn_na && length(missing_countries) > 0)
  {
    missing_countries = paste(missing_countries, collapse = ", ");
    warning_string = paste("The following countries were missing and are being set to NA:", missing_countries);
    print(warning_string);
  }
  
  choropleth = choropleth[order(choropleth$order), ];
  
  choropleth
}

render_world_choropleth = function(choropleth.df, title="", scaleName="", countries)
{
  # only show the states the user asked
  choropleth.df = choropleth.df[choropleth.df$region %in% countries, ]
  
  # maps with numeric values are mapped with a continuous scale
  if (is.numeric(choropleth.df$value))
  {
    choropleth = ggplot(choropleth.df, aes(long, lat, group = group)) +
                     geom_polygon(aes(fill = value), color = "dark grey", size = 0.2) + 
                     scale_fill_continuous(scaleName, labels=comma, na.value="black") + # use a continuous scale
                     ggtitle(title) +
                     theme_clean();
  } else { # assume character or factor
    stopifnot(length(unique(na.omit(choropleth.df$value))) <= 9) # brewer scale only goes up to 9

    choropleth = ggplot(choropleth.df, aes(long, lat, group = group)) +
                     geom_polygon(aes(fill = value), color = "dark grey", size = 0.2) + 
                     scale_fill_brewer(scaleName, labels=comma, na.value="black") + # use discrete scale for buckets
                     ggtitle(title) +
                     theme_clean();
  } 
 
  choropleth
}

world_choropleth_auto = function(df, 
                            num_buckets = 9, 
                            title = "", 
                            scaleName = "",
                            countries,
                            warn_na)
{
  stopifnot(!any(duplicated(df$region)))
  
  # test for valid countries
  if (!is.null(countries))
  {
    data(country.names, package="choroplethr", envir=environment())
    stopifnot(countries %in% country.names$region)
    stopifnot(!any(duplicated(countries)))
  } else {
    data(country.names, package="choroplethr", envir=environment())
    countries = country.names$region
  }
  
  df$region = tolower(df$region)
  
  df = clip_df(df, "world", countries=countries) # remove elements we won't be rendering
  df = discretize_df(df, num_buckets) # if user requested, discretize the values
  
  choropleth.df = bind_df_to_world_map(df, warn_na) # bind df to map
  render_world_choropleth(choropleth.df, title, scaleName, countries) # render map
}