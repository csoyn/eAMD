library(sunburstR)
draw_sunburst <- function (data) {
  sunburstTxPathway<-c()
  for (j in data$TxPathway){
    txPathway<-c()
    treatment<-unlist(strsplit(j, '-'))
    
    for (i in 1:length(treatment)){
      txPathway <- c(txPathway, treatment[i])
    }
    sunburstTxPathway<-c(sunburstTxPathway, paste(txPathway, collapse = '-'))
  }
  sunburstTxPathway <- data.frame(table(sunburstTxPathway))
  
  
  sum(sunburstTxPathway$Freq) #
  
  
  # sunburst plot
  legend_items <- c('Bevacizumab', 'Ranibizumab', 'Aflibercept', 'Verteporfin')
  cols <- c('Bevacizumab', 'Ranibizumab', 'Aflibercept',  'Verteporfin')
  cols[legend_items=='Bevacizumab'] = "#984ea3"
  cols[legend_items=='Ranibizumab'] = "#ff7f00"
  cols[legend_items=='Aflibercept'] = "#377eb8"
  cols[legend_items=='Verteporfin'] = "#8dd3c7"
  # rm(sb)
  
  sb = sunburstTxPathway %>% sunburst(colors=list(range=cols, domain=legend_items),
                                      legendOrder = c('Bevacizumab', 'Ranibizumab', 'Aflibercept', 'Verteporfin'),
                                      valueField = "size",
                                      percent = TRUE,
                                      count = TRUE,
                                      legend = list(w=150),
                                      #width = 700,
                                      #height = 700,
                                      withD3=TRUE,
                                      sortFunction = htmlwidgets::JS(
                                        "
                                      function(a,b){
                                        abb = {
                                          Bevacizumab:1,
                                          Aflibercept:2,
                                          Ranibizumab:3,
                                          Verteporfin:4
                                        }
                                        return abb[a.data.name] - abb[b.data.name];
                                      }
                                      "
                                      )) 
  
  
  sb = htmlwidgets::onRender(sb,
                             "
	  function(el, x) {
	  d3.selectAll('.sunburst-legend text').attr('font-size', '15px');
    d3.select(el).select('.sunburst-togglelegend').property('checked',true);
    d3.select(el).select('.sunburst-togglelegend').on('click')();
    d3.select(el).select('.sunburst-togglelegend').remove();
	  }
	  "
  )
  
  
  #sb = htmlwidgets::prependContent(sb, htmltools::h1(maintitle), htmltools::h2(subtitle))
  #sb = htmlwidgets::saveWidget(widget=sb, paste0(plottitle,".html"), selfcontained = FALSE, libdir = getwd())
  return (sb)
}


data = read.csv("./eyeData_for_plot.csv")
data = read.csv("./eyeData_for_plot_rep.csv")


#################################### PLOT ###############################
## 08 ~ 19년도   all 
plotData_all_S <- data %>% 
  filter(PERIOD %in% "A" | PERIOD %in% "B")
plot_all = draw_sunburst(plotData_all_S)
name = "2008 ~ 2019"
maintitle = name 
plottitle = name 
plot_all = htmlwidgets::prependContent(plot_all, htmltools::h1(maintitle))
sb = htmlwidgets::saveWidget(widget=plot_all, paste0(plottitle,".html"), selfcontained = FALSE, libdir = getwd())

plot_all

# 08 ~ 12
plotData_A <- data %>% 
  filter(PERIOD %in% "A")

plot_A = draw_sunburst(plotData_A)
name = "2008 ~ 2012"
maintitle = name 
plottitle = name 
plot_A = htmlwidgets::prependContent(plot_A, htmltools::h1(maintitle))
sb = htmlwidgets::saveWidget(widget=plot_A, paste0(plottitle,".html"), selfcontained = FALSE, libdir = getwd())

plot_A

# 13 ~ 19
plotData_B <- data %>% 
  filter(PERIOD %in% "B")
plot_B = draw_sunburst(plotData_B)

name = "2013 ~ 2019"
maintitle = name 
plottitle = name 
plot_B = htmlwidgets::prependContent(plot_B, htmltools::h1(maintitle))
sb = htmlwidgets::saveWidget(widget=plot_B, paste0(plottitle,".html"), selfcontained = FALSE, libdir = getwd())

plot_B

