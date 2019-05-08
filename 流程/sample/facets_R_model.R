#! /usr/bin/env Rscript


library("facets")



# data processing ---------------------------------------------------------
set.seed(1234)
rcmat = readSnpMatrix("./snp_pileup/<head>.out.gz")
xx = preProcSample(rcmat,gbuild = "hg38")
oo=procSample(xx,cval=300)
fit=emcncf(oo)

# plot figure -------------------------------------------------------------
pdf("./path/<head>.pdf")
plotSample(x=oo,emfit=fit)
logRlogORspider(oo$out, oo$dipLogR)
dev.off()

# save fit var ------------------------------------------------------------
save(fit, file = "./path/<head>.fit.RData")

# output purity and ploidy ------------------------------------------------
purity=fit$purity
purity=round(purity,2)
ploidy=fit$ploidy
ploidy=round(ploidy,1)
output <- paste("<head>", purity, ploidy, sep = "\t")
write(output, "./facets_result/facets_purity_ploidy.txt", append = TRUE)

