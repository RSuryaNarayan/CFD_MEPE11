# CFD-Group 10: Assignment: Solution to a porous fin 
Find the updates and changes in codes here. Stuff to do: \
~1. Explore finite volume method~  \
~2. Derive conditions of stability and explain dependance on grid resolution~ \
~3. Add analytical solution comparison to the code~\
~4. Derive other plot-vars~\
~5. Segment the code into a pre-processor (generates inputs), solver, and post-processor to enable investigations on fin efficiency~
6. Create the final documentation using LaTeX
![plot!](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Group%20Assignment/Results/final_compare.png) \
I finally tested it for many test cases changing the Darcy factor *Da* and parameter *xi*  \
![plot!](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Group%20Assignment/Results/multi_plot_compare.jpeg)\
Finally added the analytical solution! and the results are very satisfying. Below is the comparison between the non-Linear FDM and the actual solution obtained from adomain decomposition. \
![plot!](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Group%20Assignment/Results/FDM_Analytical_compare.png) \
Plots can be decieving! let's find out the actual error for 100 grid points: 
![plot!](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Group%20Assignment/Results/error_100_points.png) \
Voila! the max error itself is close to 0.4%. Let's get computationally greedy and increase the mesh size to 1000:
![plot!](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Group%20Assignment/Results/error_1000_points.png) \
The max error in this case is 0.026% which means the relative error is still ```2E-4```. I feel this is a good enough tolerance for validating the solution!
Refer to [Usage.md](https://github.com/RSuryaNarayan/CFD_MEPE11/blob/main/Group%20Assignment/Usage.md) for instructions on using the code
