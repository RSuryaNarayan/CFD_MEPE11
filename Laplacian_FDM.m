%=================MATLAB code to solve the 2-D laplacian stencil===========% 
%preamble
clear all; clc;
%===============================Geometry===================================%
%x-distance
length_x=1;
%y-distance
length_y=1;
%===============================mesh parameters============================%
mesh_x=100;
mesh_y=100;
%==========================declare solution array==========================%
T=zeros(mesh_x,mesh_y);
%=============================boundary conditions==========================%
%south edge
T(1,1:mesh_x)=100;
%east edge
T(1:mesh_y,mesh_x)=200;
%west edge
T(1:mesh_y,1)=200;
%north edge
T(mesh_y,1:mesh_x)=300;
%============================Solver========================================%
%number of gauss-siedel iterations
outer_iterations=100;
for k=1:outer_iterations
    for i=2:mesh_y-1
        for j=2:mesh_x-1
            T(i,j)=0.25*(T(i-1,j)+T(i,j-1)+T(i,j+1)+T(i+1,j));
        end
    end
end
%===========================vizualization==================================%
%declare X
dx=length_x/mesh_y;
x=dx*[0:mesh_y-1];
%declare Y
dy=length_y/mesh_x;
y=dy*[0:mesh_x-1];
%generate mesh
[X,Y]=meshgrid(x,y);
%plot using contourf
figure(1);
title('Temperature Distribution');
contourf(X,Y,T);
%plot surface
figure(2)
surf(X,Y,T);
