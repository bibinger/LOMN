/////////////////////////////////////////////////////////////////
//header
/////////////////////////////////////////////////////////////////

#include <Rcpp.h>

using namespace Rcpp;
using namespace std;

/////////////////////////////////////////////////////////////////
//rep_col
/////////////////////////////////////////////////////////////////

// [[Rcpp::export]]
SEXP rep_col(SEXP x,const int n){
  const int p=Rf_length(x);
  SEXP f;
  int i,j;
  switch(TYPEOF(x)){
  case INTSXP:{
    f=PROTECT(Rf_allocMatrix(INTSXP,p,n));
    int *ff=INTEGER(f),*xx=INTEGER(x),*start=xx;
    for(i=0;i<n;++i){
      for(start=xx,j=0;j<p;++j,++ff,++start){
        *ff=*start;
      }
    }
    break;
  }
  default:{
    f=PROTECT(Rf_allocMatrix(REALSXP,p,n));
    double *ff=REAL(f),*xx=REAL(x),*start=xx;
    for(i=0;i<n;++i){
      for(start=xx,j=0;j<p;++j,++ff,++start){
        *ff=*start;
      }
    }
    break;
  }
  }
  UNPROTECT(1);
  return f;
}

/////////////////////////////////////////////////////////////////
//rep_row
/////////////////////////////////////////////////////////////////

// [[Rcpp::export]]
SEXP rep_row(SEXP x,const int n){
  const int p=Rf_length(x);
  SEXP F;
  switch(TYPEOF(x)){
  case INTSXP:{
    F=PROTECT(Rf_allocMatrix(INTSXP,n,p));
    int *xx=INTEGER(x),*f=INTEGER(F),*endx=xx+p,*startf,val;
    for(;xx!=endx;++xx){
      val=*xx;
      for(startf=f,f+=n;startf!=f;++startf){
        *startf=val;
      }
    }
    break;
  }
  default:{
    F=PROTECT(Rf_allocMatrix(REALSXP,n,p));
    double *xx=REAL(x),*f=REAL(F),*endx=xx+p,*startf,val;
    for(;xx!=endx;++xx){
      val=*xx;
      for(startf=f,f+=n;startf!=f;++startf){
        *startf=val;
      }
    }
    break;
  }
  }
  UNPROTECT(1);
  return F;
}

/////////////////////////////////////////////////////////////////
//row_min
/////////////////////////////////////////////////////////////////

// [[Rcpp::export]]
SEXP row_min(SEXP x){
  int ncol=Rf_ncols(x),nrow=Rf_nrows(x);
  SEXP F;
  F=PROTECT(Rf_allocVector(REALSXP,nrow));
  double *xx=REAL(x),*end=xx+ncol*nrow,*f=REAL(F),*x3,*ff;
  const double *endf=f+LENGTH(F);
  for(ff=f;ff!=endf;++ff,++xx)
    *ff=*xx;
  for(;xx!=end;)
    for(ff=f,x3=xx,xx+=nrow;x3!=xx;++ff,++x3){
      *ff=std::min(*ff,*x3);
    }
    UNPROTECT(1);
  return F;
}

/////////////////////////////////////////////////////////////////
//row_max
/////////////////////////////////////////////////////////////////

// [[Rcpp::export]]
SEXP row_max(SEXP x){
  int ncol=Rf_ncols(x),nrow=Rf_nrows(x);
  SEXP F;
  F=PROTECT(Rf_allocVector(REALSXP,nrow));
  double *xx=REAL(x),*end=xx+ncol*nrow,*f=REAL(F),*x3,*ff;
  const double *endf=f+LENGTH(F);
  for(ff=f;ff!=endf;++ff,++xx)
    *ff=*xx;
  for(;xx!=end;)
    for(ff=f,x3=xx,xx+=nrow;x3!=xx;++ff,++x3){
      *ff=std::max(*ff,*x3);
    }
    UNPROTECT(1);
  return F;
}