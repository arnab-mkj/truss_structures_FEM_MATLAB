clear all;
close all;
clc;

%%%PRE PROCESS

format long;

A = 0.01;
E = 10^6;

%PD- Problem Definition
%NPE- Number of Nodes per Element
%NoN- Number of Nodes
%NoE- Number of Elements
%NL- Node List(NoN x PD) (coord)
%EL - Element list (NoE x NPE)
%ENL- Extended Node list (NoN x (6xPD))
%DOFs- Degrees of Freedom
%DOCs- Degrees of Constraint

NL = [0 0; 1 0; 0.5 1];
EL = [1 2; 2 3; 1 3];
[ENL, DOFs, DOCs] = assign_BCs(NL);

K = assemble_stiffness(ENL, EL, NL, E, A);

Fp = assemble_forces(ENL, EL);

Up = assemble_displacements(ENL, NL);



