# Usage
The solver can be downloaded from this repo using the ```git clone``` command or by directly just clicking on ```download files``` option. Once it downloads the files extract all files to a single folder. Do this for all subfolders. For instance, remove the ```Code/Source/FVM``` directory after you move them to a single folder and ```Code/Source/Analytical``` to the folder where ```main.m``` is. Similarly ```Analytical/Polynomials``` contains all the adomain decomposition polynomials as individual files. Move all of that to the same folder as ```main.m```. All you have to to next is to run the solver using MATLAB by hitting run with the ```main.m``` open. If you are running this on MATLAB online then I advise you to do the exact same thing but with an extra step of uploading all the files using the ```Upload``` option. Note that uploading should also be devoid of any organizations in the folder (i.e remove the FVM folder and have all the files in one single location). Hitting run thence should produce a plot like the following: \
![plot](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Group%20Assignment/Results/final_compare.png) \
If you are getting this plot in the ```Figures``` tab in your MATLAB window we have the base code running properly. Ping me if you have any issues doing this. We shall now see how to use the code to produce other results and how the code is organized internally. 
# Code organization
This project follows any other organization a software generally has:
1. ```main.m``` - contains all the assembly of the functions and is the master file 
2. ```compute_w.m``` - a function to compute the parameters for the differential equation from the basic constants like Nusselt number and Rayleigh number
3. ```Non_liniear_FDM.m```-a function that returns the solution to the governing ODE using non-linear FDM 
4. ```Linearized_FDM.m```- a function that returns the solution to the governing ODE using linearized FDM
5. ```Finite_Volume_Method.m```- a function to compute the solution using FVM

Further files in ```Source/FVM``` are dependencies for computing the finite volume solution using linearized source terms (Picard's method). Let's see how one can use the code now 
# Running a method 
Running a given method using this solver is pretty simple. Any solver in the code, be it FDM or FVM returns a (nx2) matrix with the first column for the non-dimensional temperature (theta) and the second column for non-dimensionalized x. Also all of these ubitquitously require only 3 inputs: ```params``` containing the parameters that define the problem in the same order as specified in the ```main.m``` file, ```mesh``` denotes the size of the mesh (for FVM it will produce a total of (n-1) cells so choose accordingly) and finally the tolerance ```tol``` for the linear-solver. A recommended, safe and acceptable tolerance is 1e-9. You may try smaller and tighter ones, but you are bound to run into infinite loops after 1e-16. So the command for running the non-linear FDM and immediately plot the solution is as follows:
```
[t,x] = Non_Linear_FDM(params, mesh, tol);
plot(x,t,'+r') %choose the plot style using the third argument
```
Similarly for running the linearized FDM would be: 
```
[t,x] = Linearized_FDM(params, mesh, tol);
plot(x,t,'+r') %choose the plot style using the third argument
```
For FVM: 
```
[t,x] = Finite_Volume_method(params, mesh, tol);
plot(x,t,'+r') %choose the plot style using the third argument
```
For analytical solution:
```
[t,x] = analytical_solution(params,mesh);
plot(x,t);
```
Once the solution for the non-dimensionalized temperature is computed you can now compute the performance parameters of the fin using the ```performance_eval``` function as follows: 
```
perf = performance_eval(params,t_1);
Q = perf(1);
eta = perf(2);
epsilon = perf(3);
```
These lines of code basically return the efficiency and effectiveness of the fin (represented by eta and epsilon) along with the net heat transfered (Q). Note that you have to follow the same index notation for the object ```perf``` each time. 
