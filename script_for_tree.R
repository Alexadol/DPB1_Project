
#tree representation with ggtree package

#load packages
library(extrafont)
library(ggtree)
library(ggplot2)

#read tree in Newick format
n <- read.tree("GST.treefile")

#at this step choose nodes with support more than 0.7 
label <- n$node.label 
changed_label<- as.numeric(sub("/", "", label))
morethan <- changed_label > 0.7 & !is.na(bayes)
newlabel <- ifelse( morethan,label,'')
n$node.label <- newlabel
newnewlabel <- ifelse(newlabel == "", "", intToUtf8(9679))
#9679 is a circle in UTF-8 and nodes with support > 0.7 will be labeled by circles
n$node.label <- newnewlabel

#colors,highlights and labels
p2 <- ggtree(n) + 
  geom_tiplab(linesize=0.5,size=3.2,offset=0.05,family='Cambria')+    #label branch tips and here we can change font(family,you need extrafont package for this step), size and colour
  geom_hilight(node=68, fill="green1", alpha=0.2,extend=0.95)+        #that's how we can highlight different clade
  ggplot2::xlim(0, 4.5)+ggplot2::ylim(0, 60)+                         #sometimes you need set your own scale limits if your tree doesn't fit in defolt limits
  geom_hilight(node = 61,fill="red",alpha = 0.2,extend=1.4)+          #now let's highlight a little bit more clades
  geom_hilight(node=72, fill="dodgerblue1", alpha=0.2,extend=1.2)+
  geom_hilight(node=76, fill="blue", alpha=0.2,extend=1.2)+
  geom_hilight(node=89, fill="cyan1", alpha=0.2,extend=1)+
  geom_cladelabel(node=61, label="Mitochondrial", align=TRUE,  offset = 1, color='red',fontsize = 4,barsize = 1.2)+    #you also can add text label for your clade
  geom_cladelabel(node=71, label="Cytosolic", align=TRUE,  offset = 1, color='blue1',fontsize = 4,barsize = 1.2)+
  geom_cladelabel(node=68, label="Microsomal", align=TRUE,  offset = 1, color='forestgreen',fontsize = 4,barsize = 1.2)+
  geom_nodelab(hjust=1,vjust=.3, size=5,color='darkred')                                                                 #for label nodes chosen previously 

phylopic_info <- data.frame(node=1,phylopic='7fb6a9de-0024-4e45-bb8d-1cc32fb2470f')

p<-p %<+% phylopic_info + geom_tiplab(aes(image=phylopic), geom="phylopic", alpha=.8, color='forestgreen',hjust = 1,size=0.08)

ggsave('GST.png',width = 45,height = 40,"cm")  #save the plot


#You can also make plot with group labeled tips 

groupInfo <- split(t$tip.label, a)  #where "a" is a vector with length equal to t$tip.label and this vector contains information
#about tips' belonging group
t <- groupOTU(t, groupInfo)
ggtree(t) + geom_tiplab(size=3, aes(color=group)) 



#Tree combined with boxplot
n <- read.tree("Catalase.treefile")
p <- ggtree(n) 
d1 <- data.frame(id=n$tip.label)#we should create dataframe with tip labels
p1 <- p %<+% d1 #pass it to our tree
d4 = data.frame(id=rep(n$tip.label, each=22), val=r$V8) #vector r$V8 contains values which match tip labels and for each tips there are EXACTLY 22 values
                                                        #in vector r$V8 and these values are in the same order as tips in n$tip.label 

#And finally we can build our plot using facet_plot function
p2 <- facet_plot(p1, panel="Boxplot", data=d4, geom_boxploth, mapping = aes(x=val,group=label,colour=Species,fill=Species),size=0.5)+
  scale_color_manual(values=c('#ffffff','#006d2c','#3182bd','#8856a7'))+
  scale_fill_manual(values=c('#ffffff','#66c2a4','#6baed6','#c994c7'))


