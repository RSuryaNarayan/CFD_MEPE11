# A naive implementation of the V-cycle multigrid method on a laplacian stencil
The 2-D laplace equation is solved with a Dirchlet BC on all walls (set to 40 in the code). I just do 10 smoothening iterations of gauss-siedel before and after the multigrid algorithm. About 20 iterations at the coarsest for the corrections after injecting the residuals. Interpolation to the finest is done following Strang's algorithm of a horizontal sweep followed by a vertical sweep (find the reference in this directory). The results seem satisfying as the solution almost telescopes into the the actual with a single V-cycle:\
![plot!](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Multigrid%20method/Results/results.png)
To run the code on your terminal just do:\
```g++ main.cpp -o multigrid```\
And then run the executable: \
```./multigrid```
