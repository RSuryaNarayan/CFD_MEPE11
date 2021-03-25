#include<iostream>
#include "Print_matrix.H"
#include "Gauss_siedel.H"
using namespace std;

int main()
{
	float T_fine[9][9], T_true[9][9], T_coarse[5][5], residual_fine[9][9], residual_coarse[5][5], error_coarse[5][5], error_fine[9][9]; 
	/* Here's some quick calcs:
	 * 1. The number of grid points (along a line in 1-D) in the fine level has to be odd. Otherwise the overlying coarse mesh isn't strctured or uniform. 
	 * We would then need to adopt a different mesh spacing for the boundaries. For simplicity we seek a coarsening ratio of 2 each time. 
	 * To do so one requires N- odd number of grid points at the finest including boundaries. 
	 * 2. The working grid points are N-2 on the finest, with 2 at either end excluded for the boundaries
	 * 3. The coarse mesh shall have (N-3)/2 working grid points and (N+1)/2 grid points including boundaries */
	//initialize the arrays
	//fine
	for (int i=0;i<9;++i)
	{
		for (int j=0;j<9;++j)
		{
			if(i==0 || j==0 || i==8 || j==8)
			{//boundaries	
				T_fine[i][j]=40;
				T_true[i][j]=40;
				residual_fine[i][j]=0;
				error_fine[i][j]=0;
			}
			else
			{
				T_fine[i][j]=0;
				T_true[i][j]=0;
				residual_fine[i][j]=0;
				error_fine[i][j]=0;
			}
		}
	}
	//coarse
	for (int i=0;i<5;++i)
        {
                for (int j=0;j<5;++j)
                {
                        if (i==0 || j==0 || i==4 || j==4)
                        {//boundaries
                        	T_coarse[i][j]=40;
                        	residual_coarse[i][j]=0;
				error_coarse[i][j]=0;
                        }
                        else
                        {
                        	T_coarse[i][j]=0;
                        	residual_coarse[i][j]=0;
				error_coarse[i][j]=0;
                        }
                }
        }
	//print the initial guess
        print_mat(T_fine,9,1);
	//coarse
        print_mat(T_coarse,5,0);
	//the smoothening step - do 10 rounds of Gauss-siedel iterations 
	gauss_siedel(T_fine,10,9,1);
	cout<<"\nAfter 10 iterations of Gauss-Siedel..\n";
	print_mat(T_fine,9,1);
	//compute residual on the fine level
	for (int i=0;i<=8;++i)
	{
		for (int j=0;j<=8;++j)
		{	
			if (i==0 || j==0 || i==8 || j==8)
			{ //boundaries carry zero error	
				residual_fine[i][j]=0;
			}
			else
			{
				residual_fine[i][j]=4*T_fine[i][j]-(T_fine[i+1][j]+T_fine[i][j+1]+T_fine[i-1][j]+T_fine[i][j-1]);
			}
		}
	}
	cout<<"residuals::";
	print_mat(residual_fine,9,1);
	// the restriction step- inject this into the coarse level
	for (int i=1; i<=3; ++i)
	{
		for (int j=1; j<=3; ++j)
		{
			residual_coarse[i][j]=residual_fine[2*i][2*j];
		}
	}
	cout<<"residuals::";
	print_mat(residual_coarse,5,0);
	//solve for the errors on the coarse grid using gauss siedel
	//first initialize guesses
	for (int i=1; i<=3;++i)
	{
		for (int j=1;j<=3;++j)
		{
			error_coarse[i][j]=0;
		}
	}
	//gauss-siedel
	int iter_error=20;
	for (int k=0;k<iter_error;++k)
	{
		for (int i=1; i<=3; ++i)
		{
			for (int j=1;j<=3;++j)
			{
				error_coarse[i][j]=-residual_coarse[i][j]+0.25*(error_coarse[i+1][j]+error_coarse[i][j+1]+error_coarse[i-1][j]+error_coarse[i][j-1]);		
			}
		}
	}
	cout<<"solved corrections on coarse level:";
	print_mat(error_coarse,5,0);
	//The Prolongation step - now interpolate the corrections back onto the fine level
	//horizontal sweep
	for (int i=1; i<=3; ++i)
	{
		for(int j=1;j<=3;++j)
		{
			error_fine[2*i][2*j]=error_coarse[i][j];
			error_fine[2*i][2*j+1]=0.5*(error_coarse[i][j]+error_coarse[i][j+1]);
		}
	}
	//vertical sweep
	for (int i=0; i<=3;++i)
	{
		for (int j=0; j<=3; ++j)
		{
			error_fine[2*i+1][2*j]=0.5*(error_coarse[i][j]+error_coarse[i+1][j]);
			error_fine[2*i+1][2*j+1]=0.25*(error_coarse[i+1][j]+error_coarse[i][j+1]+error_coarse[i][j]+error_coarse[i+1][j+1]);
		}
	}
	//add the errors to the fine level
	for (int i=1;i<=7;++i)
	{
		for (int j=1;j<=7;++j)
		{
			T_fine[i][j]=T_fine[i][j]+error_fine[i][j];
		}
	}
	print_mat(T_fine,9,1);
	//another smoothening step
	gauss_siedel(T_fine,10,9,1);
	cout<<"\nAfter 10 iterations of Gauss-Siedel (Finalized) ..\n";
	print_mat(T_fine,9,1);
	//compare with the true solution
	cout<<"TRUE SOLUTION::\n";
	gauss_siedel(T_true,100,9,1);
	print_mat(T_true,9,1);
	//compute the %error
	float perc[9][9];
	for (int i=0; i<=8; ++i)
	{
		for (int j=0; j<=8; ++j)
		{
			perc[i][j]=100*(T_true[i][j]-T_fine[i][j])/T_true[i][j];
		}
	}
	cout<<"\npercentage errors::\n";
	print_mat(perc,9,1);
}
