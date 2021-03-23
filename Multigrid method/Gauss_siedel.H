#ifndef GAUSS_SIEDEL_H
#define GAUSS_SIEDEL_H

#include<iostream>

using namespace std; 

template <typename TwoD>

void gauss_siedel(TwoD& T,int iter,int n, int c)
{
	if (c==1)
	{
		cout<<"Fine level: \n";
	}
	else
	{
		cout<<"Coarse level: \n";
	}
	for (int k=0; k<iter; ++k)
	{
		for (int i=1;i<n-1;++i)
        	{
        	        for (int j=1;j<n-1;++j)
        	        {
        	                T[i][j]=0.25*(T[i][j+1]+T[i+1][j]+T[i-1][j]+T[i][j-1]);
        	        }
		}
        }
}
#endif
