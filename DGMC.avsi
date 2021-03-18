function DGMC(clip input, int "tradius", int "mthresh", int "mthresh2", float "limit", float "limitc", int "blocksize", int "overlap", int "search", int "searchparam", clip "auxclip")
{
    search=default(search,1)
	searchparam=default(searchparam,2)
	tradius=default(tradius,5)
	mthresh=default(mthresh,300)
	mthresh2=default(mthresh2,300)
	limit=default(limit,8)
	limitc=default(limitc,16)
	blocksize=default(blocksize,8)
	overlap=default(overlap,2)
	aux=Defined(auxclip)
	auxclip=aux ? auxclip : input
		
	prefilt=auxclip
	super=MSuper(levels=1,input, pel=2,mt=false,hpad=blocksize,vpad=blocksize)
	superfilt=MSuper(prefilt,pel=2,mt=false,hpad=blocksize,vpad=blocksize)
    
    multivectors=Manalyse(superfilt,multi=true,delta=tradius,mt=false,blksize=blocksize,search=search,searchparam=searchparam)
    multivectors2=Mrecalculate(superfilt,multivectors,thsad=mthresh,tr=tradius,mt=false,blksize=blocksize,overlap=overlap,search=search,searchparam=searchparam)
    dg=MdegrainN(input,super,multivectors2,tradius,thsad=mthresh,thsad2=mthresh2,thsadc=mthresh,thsadc2=mthresh2,limit=limit,limitc=limitc,mt=false,plane=4)
    return(dg)
}
