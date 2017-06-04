%{
%define the range of x,y,z coordinates
step=.5;
x=-10:step:10;
y=-10:step:10;
z=-10:step:10;
%generate a grid with all triplets (x,y,z)
[X,Y,Z] = meshgrid(x,y,z);
%intersection of inequalities in a logical matrix
I = (X.*Y-X-Y+1>0) & (Z<1) & (X.*Y-X-Y-4*Z+1>0);
%plot of the points (x,y,z) that verify all inequalities
scatter3(X(I),Y(I),Z(I),'.');
xlabel('X'); ylabel('Y'); zlabel('Z');
%}

clear all;clc;close all;
% density
n=1;
% create coordinates
[xx,yy,zz] = meshgrid(-150:n:150,-150:n:150,-150:n:150);
% boundary condition 1
rr = (abs(xx) + abs(yy)+ abs(zz));
region3= rr<1;
p=patch(isosurface(region3,0.01))
set(p,'FaceColor','blue','EdgeColor','none');
daspect([1,1,1])
view(3); axis equal
camlight 
lighting gouraud
grid on   