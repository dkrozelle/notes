\# testing my shiny app deployed on shiny server, 
# but having trouble getting the log file to see what 
# errors are output. If you connect to the server 
# and forward the port it'll print out the stdout 
# on your local machine while running from the 
# actual shiny server location


# needed for deployment on some rstudio instances to force port of preference
options(shiny.port = 7688,shiny.host = "0.0.0.0")


# connect with port forwarding
ssh -L localhost:7688:localhost:7688 civetta:/srv/shiny-server/WDR5/
# add to your app.R if necessary
options(shiny.port = 7688)
# launch the app
cd /srv/shiny-server/WDR5/
Rscript app.R
# visit 127.0.0.1:7688 on your local machine


[Golem Cheatsheet](https://thinkr.fr/golem_cheatsheet_V0.1.pdf)



app     <- "App Explorer"
version <- "0.0.2"
date    <- "2018-12-04"

# easily place a standardized, versioned my footer on a shiny page.
my_footer <- function(app_name=app, version_number=version, version_date=date){
  shiny::HTML(
    paste0('
           <div class="container footer">
           <span class="text-muted left-foot">Supported by 
           <a href="http://www.google.com/">Company</a>
           </span>
           <span class="text-muted right-foot">',app_name,', version <a href="https://github.com/organization/',app_name,'">',version_number,'</a> (',version_date,')</span>
           </div>'
    ))
}