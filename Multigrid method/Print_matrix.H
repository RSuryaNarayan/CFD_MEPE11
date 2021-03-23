#ifndef PRINT_MATRIX_H
#define PRINT_MATRIX_H

#include<iostream>

using namespace std; 

template <typename TwoD>

void print_mat(TwoD& T,int n,int c)
{
	if (c==1)
	{
		cout<<"Fine level: \n";
	}
	else
	{
		cout<<"Coarse level: \n";
	}
	for (int i=0;i<n;++i)
        {
                for (int j=0;j<n;++j)
                {
                        cout<<T[i][j]<<"\t\t";
                }
		cout<<"\n";
        }
}
#endif
